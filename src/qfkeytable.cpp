#include <QtCore>
#include <QMetaObject>
#include "qfkeytable.h"

/*!
  \qmltype KeyTable
  \brief Defines a key table

  KeyTable is an object with properties equal to its key name. Once it's construction is completed,
  it will search all of its string property. If it is a string type and not assigned to any value,
  it will set its value by its name. It can be used to create ActionTypes.qml in QuickFlux Application.

Example

\code

KeyTable {

    // It will be set to "customField1" in Component.onCompleted callback.
    property string customField1;

    // Since it is already assigned a value, KeyTable will not modify this property.
    property string customField2 : "value";

}

\endcode


 */

static QMap<int,QString> createTypes() {
    QMap<int,QString> types;
    types[QMetaType::QString] = "QString";
    types[QMetaType::Int] = "int";
    types[QMetaType::Double] = "qreal";
    types[QMetaType::Bool] = "bool";
    types[QMetaType::QPointF] = "QPointF";
    types[QMetaType::QRectF] = "QRectF";

    return types;
}

QFKeyTable::QFKeyTable(QObject *parent) : QObject(parent)
{

}

QString QFKeyTable::genHeaderFile(const QString& className)
{

    QStringList header;
    QStringList clazz;
    bool includedPointHeader = false;
    bool includedRectHeader = false;

    header << "#pragma once";
    header << "#include <QString>\n";

    clazz << QString("class %1 {\n").arg(className);
    clazz << "public:\n";

    const QMetaObject* meta = metaObject();

    QMap<int,QString> types = createTypes();

    int count = meta->propertyCount();
    for (int i = 0 ; i < count ; i++) {
        const QMetaProperty p = meta->property(i);

        QString name(p.name());

        if (name == "objectName") {
            continue;
        }

        if (types.contains(p.userType())) {
            clazz << QString("    static %2 %1;\n").arg(name).arg(types[p.userType()]);

            if (p.userType() == QMetaType::QPointF && !includedPointHeader) {
                includedPointHeader = true;
                header << "#include <QPointF>";
            } else if (p.userType() == QMetaType::QRectF && !includedRectHeader) {
                includedRectHeader = true;
                header << "#include <QRectF>";
            }
        }

    }

    clazz << "};\n";

    QStringList content;
    content << header << clazz;

    return content.join("\n");
}

QString QFKeyTable::genSourceFile(const QString &className, const QString &headerFile)
{
    QMap<int,QString> types = createTypes();

    QStringList source;

    source << QString("#include \"%1\"\n").arg(headerFile);

    const QMetaObject* meta = metaObject();

    int count = meta->propertyCount();
    for (int i = 0 ; i < count ; i++) {
        const QMetaProperty p = meta->property(i);
        QString name(p.name());
        if (name == "objectName") {
            continue;
        }

        if (types.contains(p.userType())) {
            QVariant v = property(p.name());

            if (p.userType() == QMetaType::QString) {
                source << QString("%4 %1::%2 = \"%3\";\n")
                          .arg(className)
                          .arg(p.name())
                          .arg(v.toString())
                          .arg(types[p.userType()]);

            } else if (p.userType() == QMetaType::QPointF) {
                QPointF pt = v.toPointF();

                source << QString("QPointF %1::%2 = QPointF(%3,%4);\n")
                          .arg(className)
                          .arg(p.name())
                          .arg(pt.x())
                          .arg(pt.y());

            } else if (p.userType() == QMetaType::QRectF) {

                QRectF rect = v.toRectF();

                source << QString("QRectF %1::%2 = QRect(%3,%4,%5,%6);\n")
                          .arg(className)
                          .arg(p.name())
                          .arg(rect.x())
                          .arg(rect.y())
                          .arg(rect.width())
                          .arg(rect.height());

            } else {

                source << QString("%4 %1::%2 = %3;\n")
                          .arg(className)
                          .arg(p.name())
                          .arg(v.toString())
                          .arg(types[p.userType()]);
            }
        }
    }

    return source.join("\n");
}

void QFKeyTable::classBegin()
{

}

void QFKeyTable::componentComplete()
{
    const QMetaObject* meta = metaObject();

    int count = meta->propertyCount();
    for (int i = 0 ; i < count ; i++) {
        const QMetaProperty p = meta->property(i);
        QString name(p.name());
        if (p.userType() != QMetaType::QString ||
            name == "objectName") {
            continue;
        }

        QVariant v = property(p.name());
        if (!v.toString().isEmpty()) {
            continue;
        }

        setProperty(p.name(), name);
    }

}
