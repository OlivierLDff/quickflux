TEMPLATE = app

QT += qml quick
CONFIG += c++17

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

DISTFILES += \
    actions/qmldir \
    stores/qmldir \
    README.md

include("../../quickflux.pri")
