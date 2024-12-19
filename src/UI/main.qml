import QtQuick
import QtQuick.Controls
import Manager.Application

ApplicationWindow {
    id: applicationWindow
    width: 640
    minimumWidth: 320
    height: 580
    minimumHeight: 580
    visible: true
    title: Qt.application.name

    Form {
        anchors.fill: parent
    }

    Connections {
        target: ApplicationManager

        function onShowNormal()
        {
            applicationWindow.showNormal();
        }

        function onQuit()
        {
            applicationWindow.close();
        }
    }

    ToastInstantiator {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 30
    }
}
