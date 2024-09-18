pragma Singleton
import QtQuick 6.4
import "../actions"

Item {
    property ListModel photoModel : ListModel {}

    function add(url) {
        photoModel.append({ url: url });
    }
}

