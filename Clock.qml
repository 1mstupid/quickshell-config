import QtQuick
import Quickshell

Item {
    id: root

    implicitWidth: row.implicitWidth + 16
    implicitHeight: 15

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    // Hover pill behind the content
    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: Qt.alpha(Theme.accent, 0)
        Behavior on color { ColorAnimation { duration: 150 } }
    }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 5

        // Hour and minute
        Text {
            id: timeText
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatDateTime(clock.date, "h:mm:ss")
            font.family: Theme.font
            font.pixelSize: 12
            font.bold: true
            color: Theme.fg
        }

        // Blinking colon: dims every other second
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: ":"
            font.family: Theme.font
            font.pixelSize: 12
            font.bold: true
            color: Theme.accent
            opacity: clock.date.getSeconds() % 2 ? 0.2 : 1
            Behavior on opacity { NumberAnimation { duration: 300 } }
        }

        // Meridiem, dimmed and smaller
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatDateTime(clock.date, "AP")
            font.family: Theme.font
            font.pixelSize: 11
            font.bold: true
            font.letterSpacing: 1
            color: Qt.alpha(Theme.accent, 0.8)
        }

        // Thin divider
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 1
            height: 9
            color: Qt.alpha(Theme.fg, 0.2)
        }

        // Date
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatDateTime(clock.date, "ddd dd MMM").toUpperCase()
            font.family: Theme.font
            font.pixelSize: 7
            font.letterSpacing: 1.5
            color: Qt.alpha(Theme.fg, mouse.containsMouse ? 0.9 : 0.55)
            Behavior on color { ColorAnimation { duration: 150 } }
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: calendar.visible = !calendar.visible
    }

}
