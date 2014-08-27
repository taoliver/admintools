import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0
import Scripts 1.0

Rectangle {
    width: 100
    height: 62

    AdminScript {
                id: vmCommand
                command: "A command"
                output: "the output"
                status: 0
                }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Row {
            //anchors.centerIn: parent
            spacing: 20

            Text {
                text: "Command:"
            }
            TextField {
                id: vmInputTxt
                width: 100
                placeholderText: "Type command here"
                onAccepted: {
                    //vmOutput.text = text;
                    vmCommand.command = text;
                    vmCommand.runCommand();
                }
            }
            Button{
                id: vmRunButton
                text: "Run"
                onPressedChanged: {
                    vmCommand.command = vmInputTxt.getText(0,vmInputTxt.length);
                    vmCommand.runCommand();
                }
            }
        }

        Row {
            //anchors.centerIn: parent
            spacing: 20

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

        Row {
            //anchors.centerIn: parent
            spacing: 20

            Text {
                text: "Output:"
            }
            TextArea {
                id: vmOutputTxt
                text: vmCommand.output
                readOnly: true
                width: 100
                height: 62
            }
        }

    }

    Text {
           anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 20 }
           text: "Use Help if you're in trouble"
       }
}
