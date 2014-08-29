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
    property string command: ""
    property string vm: ""

    RowLayout {
        //anchors.fill: parent
        //anchors.centerIn: parent
        //spacing: 20
        Layout.fillWidth: true
//        Layout.fillHeight: true

        Text {
            text: "Command:"
        }
        ComboBox {
            id: cbCommand
            Layout.fillWidth: true
            currentIndex: 1
            model: ListModel {
                id: cbCommandItems
                ListElement { text: "Start"; str: "sudo virsh start" }
                ListElement { text: "Shutdown"; str: "sudo virsh shutdown" }
                ListElement { text: "Save"; str: "sudo virsh save" }
                ListElement { text: "Restore"; str: "sudo virsh restore" }
                ListElement { text: "Backup"; str: "sudo /home/oliver/projects/vm/vmbackup" }
                ListElement { text: "View"; str: "virt-viewer -r -z 75 -c qemu:///system" }
            }
            onCurrentIndexChanged: {
                command = cbCommandItems.get(currentIndex).str;
            }
            onAccepted: {
                vmCommand.runCommand();
                vmStartButton.enabled = false;
                vmStopButton.enabled = true;
            }
        }

        ComboBox {
            id: cbVm
            Layout.fillWidth: true
            currentIndex: 1
            model: ListModel {
                id: cbVmItems
                ListElement { text: "Win"; str: "win3" }
                ListElement { text: "Zentyal"; str: "zentyal" }
                ListElement { text: "Ubuntu-rpi"; str: "ubuntu-rpi" }
            }
            onCurrentIndexChanged: {
                vm = cbVmItems.get(currentIndex).str;
            }
            onAccepted: {
                vmCommand.runCommand();
                vmStartButton.enabled = false;
                vmStopButton.enabled = true;
            }
        }

        Button{
            id: vmStartButton
            text: "Start"
            onClicked: {
                //var command = cbCommand.cbCommandItems.get(currentIndex).str;
                //var vm = cbVm.cbVmItems.get(currentIndex).str;
                //vmCommand.command = "echo " + command + " " + vm;
                vmCommand.command = command + " " + vm;
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
            tooltip:"This is an interesting tool tip"
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
                        (oldContentY == cy)) {
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

