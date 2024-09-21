import QtQuick 6.4
import QuickFlux 1.1

Item {

    objectName: "DispatcherTests";

    property var messages: new Array

    AppListener {
        onDispatched: {
            messages.push([type, message]);
        }
    }
}
