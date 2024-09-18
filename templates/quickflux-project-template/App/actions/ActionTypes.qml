pragma Singleton
import QtQuick 2.0
import QuickFlux 1.1

KeyTable {
    // Call it when the initialization is finished.
    // Now, it is able to start and show the application
    property string startApp

    // Call it to quit the application
    property string quitApp
}
