import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import Scripts 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Admin Tools")

    statusBar: StatusBar {
            RowLayout {
                Label { text: "Command:" }
                Text {id: statusBarCommand}
                Label { text: "Status:" }
                Text {id: statusBarStatus}
            }
        }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: qsTr("Tools")
            MenuItem {
                text: qsTr("VM")
                onTriggered: Qt.quit();
            }
            MenuItem {
                text: qsTr("Backup")
                onTriggered: Qt.quit();
            }
            MenuItem {
                text: qsTr("Sync")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: qsTr("Help")
            MenuItem {
                text: qsTr("About")
                onTriggered: aboutDialog.open();
            }
        }
    }

    TabView {
        anchors.fill: parent
        Component.onCompleted: {
            addTab("VM", Qt.createComponent("VMTab.qml"))
            addTab("Backup", Qt.createComponent("BackupTab.qml"))
            addTab("Sync", Qt.createComponent("SyncTab.qml"))
            addTab("Inline", tab3)
        }
        Component {
            id: tab3
            Rectangle {color: "blue"}
        }
    }
/*
    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        anchors.margins: margin
        GroupBox {
            id: rowBox
            title: "Row layout"
            Layout.fillWidth: true

            RowLayout {
                id: rowLayout
                anchors.fill: parent
                TextField {
                    placeholderText: "This wants to grow horizontally"
                    Layout.fillWidth: true
                }
                Button {
                    text: "Button"
                }
            }
        }

        GroupBox {
            id: gridBox
            title: "Grid layout"
            Layout.fillWidth: true

            GridLayout {
                id: gridLayout
                rows: 3
                flow: GridLayout.TopToBottom
                anchors.fill: parent

                Label { text: "Line 1" }
                Label { text: "Line 2" }
                Label { text: "Line 3" }

                TextField { }
                TextField { }
                TextField { }

                TextArea {
                    text: "This widget spans over three rows in the GridLayout.\n"
                        + "All items in the GridLayout are implicitly positioned from top to bottom."
                    Layout.rowSpan: 3
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }
        TextArea {
            id: t3
            text: "This fills the whole cell"
            Layout.minimumHeight: 30
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
*/
    MessageDialog {
        id: aboutDialog
        title: qsTr("Admin Tools - About")
        text: qsTr("Admin Tools. Useful tools for my systems. \n\
                    Line 2 \n\
                    Line 3 ")
        onAccepted: {
            console.log("About dialog closing...")
            close()
        }
    }
}
