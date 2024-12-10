import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import Manager.Application

Item {
    id: control
    Material.accent: Material.Green

    function isMobile()
    {
        // https://doc.qt.io/qt-6/qml-qtqml-qt.html#platform-prop
        const mobileTypes = ["ios", "android"];
        return mobileTypes.includes(Qt.platform.os);
    }

    function isDesktop()
    {
        // Check docs for a better-suited approach
        return !control.isMobile();
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        uniformCellSizes: false
        clip: true

        GroupBox {
            Layout.fillWidth: true
            title: qsTr("App Icon")

            RowLayout {
                anchors.fill: parent

                Label {
                    Layout.preferredWidth: 100
                    text: qsTr("Icon:")
                }

                ComboBox {
                    id: comboBox
                    Layout.fillWidth: true
                    textRole: "text"
                    valueRole: "icon"
                    model: ListModel {
                        ListElement { text: qsTr("Heart"); icon: "qrc:/images/heart.png" }
                        ListElement { text: qsTr("Bad"); icon: "qrc:/images/bad.png" }
                        ListElement { text: qsTr("Trash"); icon: "qrc:/images/trash.png" }
                    }

                    delegate: ItemDelegate {
                        width: comboBox.width
                        RowLayout {
                            spacing: 12
                            anchors.fill: parent
                            anchors.leftMargin: 12

                            Image {
                                source: model.icon
                                sourceSize.width: width
                                sourceSize.height: height
                                width: 24
                                height: 24
                            }

                            Text {
                                text: model.text
                                font.pixelSize: 12
                            }

                            Item {
                                Layout.fillWidth: true
                            }
                        }
                    }

                    contentItem: RowLayout {
                        spacing: 12
                        anchors.fill: parent
                        anchors.leftMargin: 12

                        Image {
                            source: comboBox.model.get(comboBox.currentIndex).icon
                            sourceSize.width: width
                            sourceSize.height: height
                            width: 24
                            height: 24
                            visible: comboBox.currentIndex >= 0
                        }

                        Text {
                            text: comboBox.model.get(comboBox.currentIndex).text
                            font.pixelSize: 16
                        }

                        Item {
                            Layout.fillWidth: true
                        }
                    }

                    onActivated: {
                        ApplicationManager.iconSource = comboBox.currentValue;
                    }
                }
            }
        }

        GroupBox {
            Layout.fillHeight: true
            Layout.fillWidth: true
            title: qsTr("Message")

            ColumnLayout {
                anchors.fill: parent

                RowLayout {
                    visible: control.isDesktop()

                    Label {
                        text: qsTr("Type:")
                        Layout.preferredWidth: 100
                    }

                    ComboBox {
                        id: comboBoxType
                        Layout.fillWidth: true
                        implicitContentWidthPolicy: ComboBox.WidestText
                        textRole: "text"
                        valueRole: "value"

                        model: ListModel {
                            ListElement { text: qsTr("None or Default"); value: 0 }
                            ListElement { text: qsTr("Information"); value: 1 }
                            ListElement { text: qsTr("Warning"); value: 2 }
                            ListElement { text: qsTr("Critical"); value: 3 }
                            ListElement { text: qsTr("Custom Icon"); value: -1 }
                        }

                        onActivated: {
                            ApplicationManager.notificationType = comboBoxType.currentValue;
                        }
                    }
                }

                RowLayout {
                    visible: control.isMobile()

                    Label {
                        text: qsTr("Notification ID:")
                        Layout.preferredWidth: 100
                    }

                    SpinBox {
                        value: ApplicationManager.notificationId
                        Layout.fillWidth: true
                        to: 99
                        from: 1
                        editable: true

                        ToolTip.visible: hovered
                        ToolTip.text: qsTr("Notifications with same ID will be replaced")

                        onValueChanged: ApplicationManager.notificationId = value;
                    }
                }

                RowLayout {
                    visible: control.isDesktop()

                    Label {
                        text: qsTr("Duration (sec):")
                        Layout.preferredWidth: 100
                    }

                    SpinBox {
                        value: ApplicationManager.notificationDuration
                        Layout.fillWidth: true
                        to: 20
                        from: 1
                        editable: true

                        ToolTip.visible: hovered
                        ToolTip.text: qsTr("Some systems might ignore this option")

                        onValueChanged: ApplicationManager.notificationDuration = value;
                    }
                }

                RowLayout {
                    Label {
                        text: qsTr("Title")
                        Layout.preferredWidth: 100
                    }

                    TextField {
                        text: ApplicationManager.notificationTitle
                        Layout.fillWidth: true

                        onEditingFinished: {
                            ApplicationManager.notificationTitle = text;
                        }
                    }
                }

                RowLayout {
                    Label {
                        text: qsTr("Body")
                        Layout.preferredWidth: 100
                    }

                    TextArea {
                        text: ApplicationManager.notificationBody
                        wrapMode: Text.Wrap
                        Layout.minimumHeight: 100
                        Layout.fillWidth: true

                        onEditingFinished: {
                            ApplicationManager.notificationBody = text;
                        }
                    }
                }

                Button {
                    text: qsTr("Trigger Notification")
                    font.pointSize: 12
                    bottomPadding: 20
                    rightPadding: 25
                    leftPadding: 25
                    topPadding: 20
                    Layout.fillWidth: true
                    highlighted: true

                    /*
                      Material.ExtraSmallScale - equivalent to radius: 4
                      Material.SmallScale - equivalent to radius: 8
                      Material.MediumScale - equivalent to radius: 12
                      Material.LargeScale - equivalent to radius: 16
                      Material.ExtraLargeScale - equivalent to radius: 20
                    */
                    Material.roundedScale: Material.SmallScale

                    onClicked: ApplicationManager.triggerNotification()
                }
            }
        }
    }
}
