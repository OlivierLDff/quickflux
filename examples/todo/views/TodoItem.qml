import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Layouts 6.4
import "../actions"

Rectangle {
    id: item
    color: "white"
    height: 48

    property int uid;
    property string title
    property alias checked: checkBox.checked

    RowLayout {
        anchors.fill: parent

        CheckBox {
            id: checkBox
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: title
            Layout.fillWidth: true
        }
    }

    onCheckedChanged: {
        AppActions.setTaskDone(uid,checked);
    }
}

