import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Layouts 6.4
import "../actions"

Item {
    height: 56

    function add() {
        AppActions.addTask(textField.text);
        textField.text = "";
    }

    RowLayout {
        anchors.fill: parent

        TextField {
            id: textField
            Layout.fillWidth: true
            focus: true
            onAccepted: add();
        }

        Button {
            text: "ADD"
            onClicked: {
                add();
            }
        }
    }
}

