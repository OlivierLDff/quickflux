import QtQuick 6.4
import QtQuick.Controls 6.4
import "../actions"
import "../stores"

Item {
    height: 48

    CheckBox {
        id: checkBox
        checked: false
        text: "Show Completed";
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        onCheckedChanged: {
            AppActions.setShowCompletedTasks(checked);
        }

        Binding {
            target: checkBox
            property: "checked"
            value: MainStore.userPrefs.showCompletedTasks
        }
    }

}

