import QtQuick 6.4
import QuickFlux 1.1

Middleware {

    filterFunctionEnabled: true

    property var stack;

    function navigateTo(message) {
        stack.push(message.item,message.properties);
    }

    function navigateBack(message) {
        stack.pop();
    }
}
