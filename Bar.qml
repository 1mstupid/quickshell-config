import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: root

    property var modelData
    screen: modelData
    property bool expanded: false

    anchors { top: true }

    readonly property real topGap: 8

    implicitWidth: pill.width
    implicitHeight: pill.height + topGap

    exclusiveZone: topGap + pill.collapsedHeight

    color: "transparent"
    visible: Theme.barStateReady

    mask: Region { item: pill }

    Item {
        id: pill

        readonly property real radius: height / 2
        readonly property real collapsedWidth: 220
        readonly property real collapsedHeight: Theme.effectiveBarHeight
        readonly property real expandedHeight: 390

        x: 0
        y: root.topGap
        width: collapsedWidth
        height: root.expanded ? expandedHeight : collapsedHeight

        Behavior on height {
            NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
        }

        Behavior on width {
            NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
        }

        Rectangle {
            anchors.fill: parent
            radius: Math.min(width, height) / 2
            color: Qt.alpha(Theme.bg, 0.92)
            border.color: Qt.alpha(Theme.accent, 0.6)
            border.width: 1
        }

        RowLayout {
            id: bar

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: 6
                leftMargin: 16
                rightMargin: 16
            }
            height: 15
            spacing: 12

            Clock {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        Item {
            id: dashboard

            anchors {
                top: bar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: 12
            }
            opacity: root.expanded ? 1 : 0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation { duration: 90 }
            }

            Grid {
                anchors.fill: parent
                columns: 3
                spacing: 8
            }
        }
    }
}
