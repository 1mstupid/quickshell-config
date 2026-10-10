import QtQuick

Item {
    id: root

    signal clicked()

    implicitWidth: 24
    implicitHeight: 24

    Text {
        anchors.centerIn: parent
        text: "[ ]"
        font.family: Theme.font
        font.pixelSize: 12
        color: mouse.containsMouse ? Theme.accent : Theme.fg
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
