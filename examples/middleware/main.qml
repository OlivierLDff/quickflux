import QtQuick 6.4
import QtQuick.Window 6.4
import QtQuick.Controls 6.4
import QuickFlux 1.1
import "./views"
import "./actions"
import "./middlewares"

Window {
    visible: true
    title: "Photo Album"
    width: 640
    height: 480

    MiddlewareList {
        applyTarget: AppActions

        ImagePickerMiddleware {
        }

        NavigationMiddleware {
            stack: stack
        }
    }

    StackView {
        id: stack
        anchors.fill: parent
    }

}

