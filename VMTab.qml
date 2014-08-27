import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0

// import my script command C++ class library
import Scripts 1.0

ColumnLayout {
    id: mainLayout
    //anchors.centerIn: parent
    //Layout.fillWidth: true
    anchors.fill: parent
    anchors.margins: 5 // edge around the outer margin of Layout object
    //spacing: 5 // spacing between objects within Layout

    // create an instance of my C++ Scripts class AdminScript
    // must be inside Layout because in a TabView?
    AdminScript {
        id: vmCommand
        command: ""
        output: ""
        status: 0
    }

    RowLayout {
        //anchors.fill: parent
        //anchors.centerIn: parent
        //spacing: 20
        Layout.fillWidth: true
//        Layout.fillHeight: true

        Text {
            text: "Command:"
        }
        TextField {
            id: vmInputTxt
            Layout.fillWidth: true
            //width: 100
            placeholderText: "Type command here"
            onAccepted: {
                vmCommand.command = text;
                vmCommand.runCommand();
            }
        }
        Button{
            id: vmRunButton
            text: "Run"
            onClicked: {
                vmCommand.command = vmInputTxt.getText(0,vmInputTxt.length);
                vmCommand.runCommand();
            }
        }
    }

    RowLayout {
        //anchors.fill: parent
        //anchors.centerIn: parent
        //spacing: 20

        Text {
            text: "Status:"
        }
        Text {
            id: vmProgressTxt
            text: vmCommand.status
        }
        ProgressBar {
            id: vmProgressBar
            minimumValue: 0
            maximumValue: 100
            orientation: Qt.Horizontal
            value: vmCommand.status
        }
    }

    GroupBox {
        title: qsTr("Output")
        Layout.fillWidth: true
        Layout.fillHeight: true

        RowLayout {
            anchors.fill: parent

            TextArea {
                id: vmOutputTxt
                text: vmCommand.output
                readOnly: true
                Layout.minimumHeight: 30
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }
}

