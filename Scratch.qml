import QtQuick 2.0

Rectangle {
    anchors.fill: parent
    //width: 320; height: 480; color: "steelblue"

    ListView {
        anchors.fill: parent
        model: Qt.fontFamilies()

        delegate: Item {
            height: 40; width: ListView.view.width
            Text {
                anchors.centerIn: parent
                text: modelData
                font.family: modelData
                font.pixelSize: 20
                //color: "white"
            }
        }
    }
}
