import QtQuick 6.4
import QtQuick.Controls 6.4
import QuickFlux 1.1
import "../actions"

Item {

    StackView {
        id: stack
        anchors.fill: parent

        initialItem: ImageViewer {

        }
    }

    AppListener {
        filter: ActionTypes.navigateTo
        onDispatched: {
            stack.push(message.item,message.properties);
        }
    }

    AppListener {
        filter: ActionTypes.navigateBack
        onDispatched: {
            stack.pop();
        }
    }

}

