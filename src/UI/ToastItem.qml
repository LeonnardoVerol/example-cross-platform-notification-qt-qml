import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material // https://doc.qt.io/qt-6/qtquickcontrols-material.html

Pane {
    id: control

    opacity: 0
    padding: 0

    readonly property real fadeTime: 300

    property string toastTitle: ""
    property string toastBody: ""
    property int toastType: 0
    property int toastDuration: 5000

    signal selfDestroy(int index);

    /*
      Material.ExtraSmallScale - equivalent to radius: 4
      Material.SmallScale - equivalent to radius: 8
      Material.MediumScale - equivalent to radius: 12
      Material.LargeScale - equivalent to radius: 16
      Material.ExtraLargeScale - equivalent to radius: 20
    */
    Material.roundedScale: Material.ExtraSmallScale

    enum ToastTypes {
        Custom = -1,
        NoneOrDefault = 0,
        Information,
        Warning,
        Critical
    }

    Component.onCompleted: {
        control.toastDuration = toastDuration;
        animation.start();
    }

    states: [
        State {
            when: control.toastType === ToastItem.ToastTypes.Custom
            PropertyChanges { target: control; Material.background: Material.color(Material.Green, Material.Shade100) }
            PropertyChanges { target: durationBar; color: Material.color(Material.Green, Material.Shade900) }
            PropertyChanges { target: textTitle; color: Material.color(Material.Green, Material.Shade900) }
            PropertyChanges { target: textBody; color: "black" }
        },
        State {
            when: control.toastType === ToastItem.ToastTypes.NoneOrDefault
            PropertyChanges { target: control; Material.background: Material.color(Material.Blue, Material.Shade100) }
            PropertyChanges { target: durationBar; color: Material.color(Material.Blue, Material.Shade900) }
            PropertyChanges { target: textTitle; color: Material.color(Material.Blue, Material.Shade900) }
            PropertyChanges { target: textBody; color: "black" }
        },
        State {
            when: control.toastType === ToastItem.ToastTypes.Information
            PropertyChanges { target: control; Material.background: Material.color(Material.Blue, Material.Shade100) }
            PropertyChanges { target: durationBar; color: Material.color(Material.Blue, Material.Shade900) }
            PropertyChanges { target: textTitle; color: Material.color(Material.Blue, Material.Shade900) }
            PropertyChanges { target: textBody; color: "black" }
        },
        State {
            when: control.toastType === ToastItem.ToastTypes.Warning
            PropertyChanges { target: control; Material.background: Material.color(Material.Orange, Material.Shade100) }
            PropertyChanges { target: durationBar; color: Material.color(Material.Orange, Material.Shade900) }
            PropertyChanges { target: textTitle; color: Material.color(Material.Orange, Material.Shade900) }
            PropertyChanges { target: textBody; color: "black" }
        },
        State {
            when: control.toastType === ToastItem.ToastTypes.Critical
            PropertyChanges { target: control; Material.background: Material.color(Material.Red, Material.Shade100) }
            PropertyChanges { target: durationBar; color: Material.color(Material.Red, Material.Shade900) }
            PropertyChanges { target: textTitle; color: Material.color(Material.Red, Material.Shade900) }
            PropertyChanges { target: textBody; color: "black" }
        }
    ]

    ColumnLayout {
        anchors.fill: parent

        ColumnLayout {
            id: container
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 16
            Layout.bottomMargin: 0

            Text {
                id: textTitle
                font.pointSize: 12
                font.bold: true

                Layout.preferredWidth: control.width - (container.Layout.margins * 2)
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                text: control.toastTitle
            }

            Text {
                id: textBody
                font.pointSize: 12

                Layout.preferredWidth: control.width - (container.Layout.margins * 2)
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                text: control.toastBody
            }
        }

        Item {

            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Rectangle {
            id: durationBar
            Layout.preferredWidth: control.width
            Layout.alignment: Qt.AlignLeft
            Layout.preferredHeight: 4
            bottomLeftRadius: 4
            bottomRightRadius: 4
        }
    }

    SequentialAnimation {
        id: animation

        NumberAnimation {
            target: control
            properties: "opacity"
            to: 0.9
            duration: control.fadeTime
        }

        NumberAnimation {
            target: durationBar
            properties: "width"
            from: control.width
            to: 0
            duration: control.toastDuration
        }

        NumberAnimation {
            target: control
            properties: "opacity"
            to: 0
            duration: control.fadeTime
        }

        onFinished: {
            control.selfDestroy(index);
        }
    }
}
