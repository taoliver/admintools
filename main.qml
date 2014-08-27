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
