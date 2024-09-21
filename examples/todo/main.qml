import QtQuick 6.4
import QtQuick.Window 6.4
import QtQuick.Layouts 6.4
import QuickFlux 1.1
import "./views"
import "./middlewares"
import "./actions"

Item {

    MiddlewareList {
        applyTarget: AppActions

        SystemMiddleware {
            mainWindow: mainWindow
        }

        DialogMiddleware {
        }
    }

    MainWindow {
        id: mainWindow
    }
}

