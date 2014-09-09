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
            /*
        RowLayout {
                Label { text: qsTr("Command:") }
                Text {
                    id: statusBarCommand
                    Layout.minimumWidth: 200
                    text: vmCommand.command
                }
                Label { text: qsTr("Elapsed Time:") }
                Text {
                    id: statusBarElapsedTime
                    Layout.minimumWidth: 100
                    text: vmCommand.elapsedTime
                }
            }
            */
        }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: {
                    // I'd like to call closing() signal
                    // but cannot declare a CloseEvent object!
                    // do this instead
                    closeDialog.open();
                    //closing(close);
                    //Qt.quit();
                }
            }
        }
        Menu {
            title: qsTr("Tools")
            MenuItem {
                text: qsTr("VM")
                //onTriggered: Qt.quit();
            }
            MenuItem {
                text: qsTr("Backup")
                //onTriggered: Qt.quit();
            }
            MenuItem {
                text: qsTr("Sync")
                //onTriggered: Qt.quit();
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

    // Tabview can access objects here

    // create an instance of my C++ Scripts class AdminScript
    // now created dynamically for each in-flight command

    /*
        AdminScript {
        id: vmCommand
        command: ""
        detached: false
        output: ""
        status: 0
        running: false
        startTime: ""
        elapsedTime: ""
    }
    */

    // monospaced font for input and output
    FontLoader { id: fixedFont; name: "Liberation Mono" }

    // split view to show command+output above status list of running commands
    SplitView {
        id: splitLayout
        anchors.fill: parent
        orientation: Qt.Vertical

        // details pane for single command
        Rectangle {
            height: 200
            Layout.minimumHeight: 300
            Layout.fillHeight: true
            color: "lightgray"
            TabView {
                anchors.fill: parent
                Component.onCompleted: {
                    addTab(qsTr("VM"), Qt.createComponent("VMTab.qml"))
                    addTab(qsTr("Backup"), Qt.createComponent("BackupTab.qml"))
                    addTab(qsTr("Sync"), Qt.createComponent("SyncTab.qml"))
                    addTab(qsTr("Scratch"), Qt.createComponent("Scratch.qml"))
                    addTab(qsTr("Inline"), tab3)
                }
                Component {
                    id: tab3
                    Rectangle {color: "blue"}
                }
            }
        }

        // list of status for each running command
        Rectangle {
            height: 200
            color: "white"
        }
    }

    MessageDialog {
        id: aboutDialog
        title: qsTr("About")
        icon: StandardIcon.Information
        text: qsTr("Admin Tools. Useful tools for my systems.\n" +
                   "Line 2\n" +
                   "Line 3")
        onAccepted: {
            console.log("About dialog closing...")
            close()
        }
    }

    // intercept closing event and prompt user
    // usually caused by user clicking X window button
    onClosing: {
        console.log("Closing");
        close.accepted = false; // close object is passed as parameter to signal
        onTriggered: closeDialog.open();
    }

    MessageDialog {
        id: closeDialog
        title: qsTr("Closing...")
        icon: StandardIcon.Warning
        //standardButtons: StandardButton.Ok | StandardButton.Cancel
        standardButtons: StandardButton.Yes | StandardButton.No
        text: qsTr("Do you really want to exit?")
        informativeText: qsTr("You should not terminate long-running scripts. " +
                              "Nasty things could happen!")
        onYes: {
            console.log("User chose to close...")
            // first close down Script objects
            // to terminate threads and scripts properly
            //vmCommand.stopCommand();
            // now exit application cleanly
            Qt.quit();
            close()
        }
        onNo: {
            console.log("User chose not to close...")
            // just go back to application window
            close()
        }
        onRejected: {
            // user clicked X window button
            console.log("User clicked X window button")
            // just go back to application window
            close()
        }
    }
}
