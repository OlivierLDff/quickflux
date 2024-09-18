import QtQuick 6.4
import QuickFlux 1.1
import "../stores"
import "../actions"

DelegateModel {

    model: MainStore.todo.model

    filterOnGroup: MainStore.userPrefs.showCompletedTasks ? "" : "nonCompleted"

    groups: [
        DelegateModelGroup {
            name: "nonCompleted"
            includeByDefault: true
        }
    ]

    delegate: TodoItem {
        id:item
        uid: model.uid
        title: model.title
        checked: model.done

        Component.onCompleted: {
            item.VisualDataModel.inNonCompleted = Qt.binding(function() { return !model.done})
        }
    }
}

