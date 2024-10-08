import QtQuick 6.4
import QuickFlux 1.1
import QtQuick.Dialogs 6.4
import "../actions"
import "../stores"

Middleware {

    property RootStore store: MainStore

    property var mainWindow: null

    function dispatch(type, message) {
        if (type === ActionTypes.startApp) {
            mainWindow.visible = true;
            return;
        }
        next(type, message);
    }

    Connections {
        target: mainWindow
        onClosing: {
            // You may inject a hook to forbid closing or save data if necessary
            console.log("closing");
        }
    }

}
