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

    implicitWidth: notch.width
    implicitHeight: notch.height

    exclusiveZone: notch.collapsedHeight

    color: "transparent"
    visible: Theme.barStateReady

    mask: Region { item: notch }

    Item {
        id: notch

        readonly property real chamfer: 18
        readonly property real collapsedWidth: 220
        readonly property real collapsedHeight: Theme.effectiveBarHeight
        readonly property real expandedHeight: 390

        width: collapsedWidth
        height: root.expanded ? expandedHeight : collapsedHeight

        Behavior on height {
            NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
        }

        Shape {
            anchors.fill: parent

            ShapePath {
                fillColor: Qt.alpha(Theme.bg, 0.92)
                strokeColor: Qt.alpha(Theme.accent, 0.6)
                strokeWidth: 1

                startX: 0; startY: 0
                PathLine { x: notch.width;                 y: 0 }
                PathLine { x: notch.width;                 y: notch.height - notch.chamfer }
                PathLine { x: notch.width - notch.chamfer; y: notch.height }
                PathLine { x: notch.chamfer;               y: notch.height }
                PathLine { x: 0;                           y: notch.height - notch.chamfer }
            }
        }

        RowLayout {
            id: bar

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: 6
                leftMargin: 12
                rightMargin: 12
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
                Volume {}
                Launcher {}
                Tray {}
                Commands {}
            }
        }
    }
}
