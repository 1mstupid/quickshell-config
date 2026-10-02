import QtQuick
import Quickshell

// Floating pill bar. Under mango this remains a wlr-layer-shell panel;
// the compositor reserves the panel's effective height.
PanelWindow {
    id: root

    property var modelData
    screen: modelData

    anchors {
        top: true
        left: true
        right: true
    }

    // Extra height gives the pill room to breathe around its contents.
    implicitHeight: Theme.effectiveBarHeight + 12

    color: "transparent"
    visible: Theme.barStateReady

    Rectangle {
        id: panel

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom

            leftMargin: 8
            rightMargin: 8
            topMargin: 6
            bottomMargin: 6
        }

        radius: height / 2

        color: Qt.alpha(Theme.bg, 0.85)

        border {
            width: 1
            color: Qt.alpha(Theme.accent, 0.25)
        }

        Behavior on color {
            ColorAnimation {
                duration: 400
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: 400
            }
        }

        // Right-click empty bar = layout/tweaks picker.
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.RightButton

            onClicked: layoutBtn.pickerVisible =
                !layoutBtn.pickerVisible
        }

        Row {
            id: leftCluster

            anchors {
                left: parent.left
                leftMargin: 12
                verticalCenter: parent.verticalCenter
            }

            spacing: 8

            Launcher {}
            Tags {}
        }

        Title {
            anchors.verticalCenter: parent.verticalCenter

            readonly property real gapL:
                leftCluster.x + leftCluster.width + 24

            readonly property real gapR:
                rightCluster.x - 24

            width: Math.max(
                0,
                Math.min(implicitWidth, gapR - gapL)
            )

            x: Math.max(
                gapL,
                Math.min(
                    (parent.width - width) / 2,
                    gapR - width
                )
            )

            visible: width > 40
        }

        Row {
            id: rightCluster

            anchors {
                right: parent.right
                rightMargin: 12
                verticalCenter: parent.verticalCenter
            }

            spacing: 6

            Metrics {}
            Volume {}
            Tray {}
            Clock {}
            Commands {}
        }
    }
}
