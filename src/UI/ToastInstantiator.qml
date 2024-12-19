import QtQuick
import Manager.Application

ListView {
    id: control
    width: 320

    spacing: 5

    z: Infinity // Global value in QML
    interactive: false

    model: ListModel { id: listModel }

    Connections {
        target: ApplicationManager

        function onCreateToastNotification(title, body, type, duration)
        {
            listModel.append({
                                title,
                                body,
                                type,
                                duration
                            });
        }
    }

    function remove(index)
    {
        listModel.remove(index);
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

        Connections {
            target: listModel

            function onCountChanged()
            {
                nextInLine();
            }
        }
    }
}
