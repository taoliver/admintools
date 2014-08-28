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

    // fixed font for command input and output
    //FontLoader { id: fixedFont; name: "Monospace" }
    FontLoader { id: fixedFont; name: "Liberation Mono" }

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
            font.family: fixedFont.name;
            //width: 100
            placeholderText: "Type command here"
            onAccepted: {
                vmCommand.command = text;
                vmCommand.runCommand();
                vmStartButton.enabled = false;
                vmStopButton.enabled = true;
            }
        }
        Button{
            id: vmStartButton
            text: "Start"
            onClicked: {
                vmCommand.command = vmInputTxt.getText(0,vmInputTxt.length);
                vmCommand.runCommand();
                vmStartButton.enabled = false;
                vmStopButton.enabled = true;
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
        Button{
            id: vmStopButton
            text: "Stop"
            enabled: false
            onClicked: {
                vmCommand.stopCommand();
                vmStopButton.enabled = false;
                vmStartButton.enabled = true;
            }
        }
        Button{
            id: vmClearButton
            text: "Clear"
            onClicked: {
                vmCommand.output = "";
            }
        }
    }

    RowLayout {
        //anchors.fill: parent
        //anchors.centerIn: parent
        //spacing: 20

        Text {
            text: "Start time:"
        }
        Text {
            id: vmStartTime
            Layout.minimumWidth: 200
            text: vmCommand.startTime
        }
        Text {
            text: "Elapsed time:"
        }
        Text {
            id: vmElapsedTime
            Layout.minimumWidth: 100
            text: vmCommand.elapsedTime
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
                font.family: fixedFont.name;
                readOnly: true
                Layout.minimumHeight: 30
                Layout.fillHeight: true
                Layout.fillWidth: true
                property int oldContentHeight: 0;
                property int oldContentY: 0;
                onTextChanged: {
                    console.log("Changed");
                    var ch = vmOutputTxt.flickableItem.contentHeight;
                    var vh = vmOutputTxt.flickableItem.height;
                    var cy = vmOutputTxt.flickableItem.contentY;
                    if ((ch > vh) &&
                            (oldContentY == oldContentHeight-vh) &&
                            (cy == ch-vh)) {
                        var cy = ch-vh;
                        vmOutputTxt.flickableItem.contentY = cy;
                    }
                    else {
                        //var cy = vmOutputTxt.flickableItem.contentY;
                        var cy = vmOutputTxt.flickableItem.contentY;
                        //var cy = oldContentY;
                        //vmOutputTxt.flickableItem.contentY = cy;
                    }
                    console.log(oldContentY,oldContentHeight,cy,ch);
                    oldContentY = cy;
                    oldContentHeight = ch;
                    //console.log("length");
                    //console.log(vmOutputTxt.flickableItem.contentY);
                    //console.log(vmOutputTxt.flickableItem.height);
                    //console.log(vmOutputTxt.flickableItem.contentHeight);
                    //console.log(oldContentY,oldContentHeight,cy,ch);
                    //console.log(vmOutputTxt.cursorPosition);
                    //console.log(vmCommand.output.length);
                }
            }
        }
    }
}

