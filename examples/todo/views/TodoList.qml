import QtQuick 6.4
import QuickFlux 1.1
import QtQuick.Controls 6.4
import QtQuick.Layouts 6.4
import "../stores"

ScrollView {
    ListView {
        anchors.fill: parent

        model: TodoVisualModel {
            id: visualModel
        }
    }
}

