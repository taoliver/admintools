import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0

// import my script command C++ class library
import Scripts 1.0

ColumnLayout {
    id: mainLayout
    //anchors.centerIn: parent
    anchors.fill: parent
    //spacing: 20

    // create an instance of my C++ Scripts class AdminScript
    AdminScript {
                id: vmCommand
                command: ""
                output: ""
                status: 0
                }

    RowLayout {
                   id: rowLayout
                   //anchors.fill: parent
                   TextField {
                       placeholderText: "This wants to grow horizontally"
                       Layout.fillWidth: true
                   }
                   Button {
                       text: "Button"
                   }
               }
    RowLayout {
                   id: rowLayout2
                   anchors.fill: parent
                   TextField {
                       placeholderText: "This wants to grow horizontally"
                       Layout.fillWidth: true
                   }
                   Button {
                       text: "Button"
                   }
               }
    RowLayout {
        //anchors.fill: parent
        //anchors.centerIn: parent
        //spacing: 20

        Text {
            text: "Command:"
        }
        TextField {
            id: vmInputTxt
            width: 100
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

    RowLayout {
        //anchors.fill: parent
        //anchors.centerIn: parent
        //spacing: 20

        Text {
            text: "Output:"
        }
        TextArea {
            id: vmOutputTxt
            text: vmCommand.output
            readOnly: true
            //width: 300
            //height: 200
            Layout.minimumHeight: 30
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
    GroupBox {
        title: qsTr("Package selection")
        Column {
            //spacing: 2
            CheckBox {
                text: qsTr("Update system")
            }
            CheckBox {
                text: qsTr("Update applications")
            }
            CheckBox {
                text: qsTr("Update documentation")
            }
        }
    }


}

