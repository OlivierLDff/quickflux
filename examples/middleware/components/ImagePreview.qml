import QtQuick 6.4
import QtQuick.Layouts 6.4
import QtQuick.Controls 6.4
import QuickFlux 1.1
import "../actions"

Rectangle {
    color: "#000000"

    property alias source: image.source

    signal cancelled
    signal confirmed

    ColumnLayout {
        anchors.fill: parent

        Image {
            id: image
            asynchronous: true
            Layout.fillWidth: true
            Layout.fillHeight: true

            fillMode: Image.PreserveAspectFit
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false
            Layout.maximumHeight: cancelButton.implicitHeight

            Button {
                id: cancelButton
                text: qsTr("Cancel")
                onClicked: {
                    cancelled();
                }
            }

            Button {
                id: confirmButton
                text: qsTr("Confirm");
                onClicked: {
                    confirmed();
                }
            }

        }
    }

}

