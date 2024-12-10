import QtQuick
import Manager.Application

ListView {
    id: control
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.margins: 30
    width: 320

    spacing: 5

    z: Infinity // Global value in QML
    interactive: false

    model: ListModel {id: model}

    Connections {
        target: ApplicationManager

        function onCreateToastNotification(title, body, type, duration)
        {
            model.insert(0, {
                                title,
                                body,
                                type,
                                duration
                            });
        }
    }

    function remove(index)
    {
        model.remove(index);
    }

    displaced: Transition {
        NumberAnimation {
            properties: "y"
            easing.type: Easing.InOutQuad
        }
    }

    delegate: ToastItem {
        width: control.width
        toastTitle: model.title
        toastBody: model.body
        toastType: model.type
        toastDuration: model.duration * 1000

        onSelfDestroy: (index) => {
            control.remove(index);
        }
    }
}
