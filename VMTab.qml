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
    property bool detached: false
    property string vm: ""
    //property var currentCommand: AdminScript
    property AdminScript currentCommand
    // declare javascript array of AdminScript objects for now
    // cannot get AdminScript objects as model in ListElement working?
    // so use index into array as model in ListElement instead!
    //property var commandList: AdminScript[5]
    property int cnt
    //property var c2: AdminScript
    //property list<AdminScript> commandList
    // declare list of running scripts
    property ScriptList commandList
    property string currentCommandText: ""
    property int currentCommandIndex: 0
    //property list<string> stringList
    //property string currentString: ""

    // choose running command to display or New command
    RowLayout {
        //anchors.fill: parent
        //anchors.centerIn: parent
        //spacing: 20
        Layout.fillWidth: true
//        Layout.fillHeight: true

        Text {
            text: "Show existing command:"
        }
        // top combobox
        // list of already in-flight commands
        // a command and output and all associated objects/state
        //   deleted by user on clicking Delete button when command pane is shown
        // selecting existing command shows command and output pane
        ComboBox {
            id: cbRunningCommand
            Layout.fillWidth: true
            currentIndex: 0
            model: ListModel // { id: runningCommands }
            { id: runningCommands
            ListElement { txt: "Test"; command: 0 }
            ListElement { txt: "Test2"; command: 1 }
            }
            onCurrentIndexChanged: {
                /*if (runningCommands.count != 0) {
                    //currentCommandText = cbRunningCommand.runningCommands.get(currentIndex).text;
                    currentCommandText = cbRunningCommand.get(currentIndex).text;
                    currentCommandIndex = cbRunningCommand.runningCommands.get(currentIndex).command;
                    currentCommand = commandList[currentCommandIndex];
                }*/
                //console.log(commandList[0].);
                currentCommand = commandList[0];
                //command = cbRunningCommandItems.get(currentIndex).str;
            }
            onAccepted: {
                //vmCommand.runCommand();
                //vmStartButton.enabled = false;
                //vmStopButton.enabled = true;
            }
        }

        Button{
            id: vmShowButton
            text: "Show"
            onClicked: {
                //var command = cbCommand.cbCommandItems.get(currentIndex).str;
                //var vm = cbVm.cbVmItems.get(currentIndex).str;
                //vmCommand.command = "echo " + command + " " + vm;
                //currentCommandText = cbRunningCommand.runningCommands.get(cbRunningCommand.currentIndex).text;
                //currentCommandIndex = cbRunningCommand.runningCommands.get(cbRunningCommand.currentIndex).command;
                //currentCommand = commandList[currentCommandIndex];
                //vmCommand.command = command + " " + vm;
                //vmCommand.runCommand();
                //vmStartButton.enabled = false;
                //vmStopButton.enabled = true;
            }
        }
    }

    RowLayout {
        //anchors.fill: parent
        //anchors.centerIn: parent
        //spacing: 20
        Layout.fillWidth: true
//        Layout.fillHeight: true

        Text {
            text: "Start new command:"
        }
        // New displays second combobox to create new command
        //   when vmStartButton is pressed for new command
        //   new adminscript object is created for command
        //   and data added to commandList for display via 1st combobox
        //   command titles numbered to keep unique? eg <1>
        ComboBox {
            id: cbNewCommand
            Layout.fillWidth: true
            currentIndex: 0
            model: ListModel {
                id: cbNewCommandItems
                ListElement { text: "Test"; str: "/home/oliver/projects/vm/test %1"; detached: false }
                ListElement { text: "Test2"; str: "/home/oliver/projects/vm/test2 %1"; detached: false }
                ListElement { text: "Test3"; str: "/home/oliver/projects/vm/test3 %1"; detached: false }
                ListElement { text: "Test4"; str: "/home/oliver/projects/vm/test4 %1"; detached: false }
                ListElement { text: "Start"; str: "echo sudo virsh start %1"; detached: false }
                ListElement { text: "Shutdown"; str: "echo sudo virsh shutdown %1"; detached: false }
                ListElement { text: "Save"; str: "echo sudo virsh save %1"; detached: false }
                ListElement { text: "Restore"; str: "echo sudo virsh restore %1"; detached: false }
                ListElement { text: "Backup"; str: "echo sudo /home/oliver/projects/vm/vmbackup %1"; detached: false }
                //ListElement { text: "View"; str: "echo virt-viewer -r -z 75 -c qemu:///system"; detached: true }
                //ListElement { text: "View"; str: "nohup virt-viewer -r -z 75 -c qemu:///system %1 \&"; detached: false }
                //ListElement { text: "View"; str: "virt-viewer -r -z 75 -c qemu:///system %1"; detached: true }
                //ListElement { text: "View"; str: "nohup virt-viewer -r -z 75 -c qemu:///system %1"; detached: true }
            }
            onCurrentIndexChanged: {
                command = cbNewCommandItems.get(currentIndex).str;
                detached = cbNewCommandItems.get(currentIndex).detached;
            }
            onAccepted: {
                //vmCommand.runCommand();
                //vmStartButton.enabled = false;
                //vmStopButton.enabled = true;
            }
        }

        ComboBox {
            id: cbVm
            Layout.fillWidth: true
            currentIndex: 0
            model: ListModel {
                id: cbVmItems
                ListElement { text: "None"; str: "" }
                ListElement { text: "Win"; str: "win3" }
                ListElement { text: "Zentyal"; str: "zentyal" }
                ListElement { text: "Ubuntu-rpi"; str: "ubuntu-rpi" }
            }
            onCurrentIndexChanged: {
                vm = cbVmItems.get(currentIndex).str;
            }
            onAccepted: {
                //vmCommand.runCommand();
                //vmStartButton.enabled = false;
                //vmStopButton.enabled = true;
            }
        }

        Button{
            id: vmStartButton
            text: "Start"
            //enabled: //! vmCommand.running
            onClicked: {
                //var command = cbCommand.cbCommandItems.get(currentIndex).str;
                //var vm = cbVm.cbVmItems.get(currentIndex).str;
                //vmCommand.command = "echo " + command + " " + vm;
                //vmCommand.command = command + " " + vm;
                // create new AdminScript object for new command
                // add to List
                //if (cbRunningCommand.runningCommands.find(currentText) === -1) {
                //var newCommand = AdminScript;
                //stringList
                commandList
                commandList[cnt].command = command.arg(vm);
                commandList[cnt].detached = detached;
                //var newCommand = AdminScript;
                //newCommand.command = command.arg(vm);
                //newCommand.detached = detached;
                //cbRunningCommand.runningCommands.append(
                //commandList[cnt] = newCommand;
                runningCommands.append(
                    { "text": newCommand.command, "command": cnt }
                );
                cnt = cnt+1;
                cbRunningCommand.runningCommands.currentIndex = cbRunningCommand.runningCommands.find(newCommand.command);
                //         }
                //vmCommand.command = command.arg(vm);
                //vmCommand.detached = detached;
                //vmCommand.runCommand();
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
            text: currentCommand.status
        }
        ProgressBar {
            id: vmProgressBar
            minimumValue: 0
            maximumValue: 100
            orientation: Qt.Horizontal
            value: currentCommand.status
        }
        Button{
            id: vmStopButton
            text: "Stop"
            //enabled: currentCommand.running
            onClicked: {
                currentCommand.stopCommand();
            }
        }
        Button{
            id: vmClearButton
            text: "Clear"
            tooltip:"This is an interesting tool tip"
            onClicked: {
                currentCommand.output = "";
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
            text: currentCommand.startTime
        }
        Text {
            text: "Elapsed time:"
        }
        Text {
            id: vmElapsedTime
            Layout.minimumWidth: 100
            text: currentCommand.elapsedTime
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
                text: currentCommand.output
                font.family: fixedFont.name;
                readOnly: true
                Layout.minimumHeight: 30
                Layout.fillHeight: true
                Layout.fillWidth: true
                property int oldContentHeight: 0;
                property int oldContentY: 0;
                onTextChanged: {
                    //console.log("Changed");
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
                    //console.log(oldContentY,oldContentHeight,cy,ch);
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

