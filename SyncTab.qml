import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0

// import my script command C++ class library
import Scripts 1.0

ColumnLayout {
    anchors.fill: parent
    //width: 320; height: 480; color: "steelblue"

    AdminScript {
        id: oneJob
        command: "ls -al"
    }

    Text {
            id: myText
            text: "Hello there"
            color: "#dd44ee"
        }

    ScriptList {
        id: commandList
        scripts: [
            AdminScript { command: "dir please"; detached: false },
            AdminScript { command: "ls -l"; detached: true },
            AdminScript { command: "dir please no" ; detached: false }
        ]
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
            onClicked: {
                console.log("Hello");
                //console.log("command: %1".arg(commandList[0].command));
                console.log("Command: %1".arg(commandList));
                console.log("List 0: %1".arg(commandList.scripts[0]));
                console.log("List 0: %1".arg(commandList.scripts[0].command));
                console.log("Command: %1".arg(oneJob.command));
                //Qt.quit();
            }
        }
    }


    ListModel {
        id: commandListModel
        ListElement { name: "Alice" }
        ListElement { name: "Bob" }
        ListElement { name: "Jane" }
        ListElement { name: "Harry" }
        ListElement { name: "Wendy" }
    }


    Component {
        id: commandListDelegate
        Text {
            text: model.name;
            //text: model.modelData.command;
            //font.pixelSize: 24
        }
    }

    Component {
        id: commandListDelegate2
        Text {
            //text: model.name;
            text: model.modelData.command;
            //font.pixelSize: 24
        }
    }

    RowLayout {
        //id: rowLayout
        //anchors.fill: parent

        ListView {
            anchors.fill: parent
            model: commandListModel
            //model: commandList
            delegate: commandListDelegate
            //delegate: commandListDelegate2
        }
    }
/*
    ScriptListModel {
        id: commandListModel2
        ListElement { command: "dir please" }
        ListElement { command: "ls -l" }
        ListElement { command: "dir please no" }
//        ListElement { command: "dir please"; detached: false }
//        ListElement { command: "ls -l"; detached: true }
//        ListElement { command: "dir please no" ; detached: false }
    }
*/
    RowLayout {
        //id: rowLayout
        //anchors.fill: parent

        ListView {
            anchors.fill: parent
            model: ScriptListModel { id: myModel }
            delegate: Text {
                //text: model.display
//                text: model.command + model.detached
                //text: model.command
                //text: model.detached
//                text: model.command + model.detached + model.startTime + model.elapsedTime
                //text: model.command + model.detached + model.startTime + model.elapsedTime + model.status + model.running
                text: model.command + model.detached + model.startTime + model.elapsedTime + model.status + model.running + model.output
            }

            Component.onCompleted: {
                console.log(myModel.count) // 5
                console.log(myModel.get(0)) // 1
                console.log(myModel.get(0).command) // 1
            }
        }
    }

    RowLayout {
        //id: rowLayout
        //anchors.fill: parent

        ListView {
            anchors.fill: parent
//            model: myText // { id: myModel2 }
//            model: commandList // { id: myModel2 }
            model: oneJob // { id: myModel2 }
            delegate: Text {
//                text: model.color
                text: model.command
//                text: model.detached
            }
/*
            Component.onCompleted: {
                console.log(myModel2.count) // 5
                console.log(myModel2.get(0)) // 1
                console.log(myModel2.get(0).command) // 1
            }
*/
        }
    }
}
