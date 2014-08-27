import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.0
/*
Rectangle {
    width: 100
    height: 62

    Text {
        text: qsTr("Hello Tim")
        anchors.centerIn: parent
    }

}
*/
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
