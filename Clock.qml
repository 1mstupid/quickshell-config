import QtQuick
import Quickshell

// Date + 12-hour time with seconds, with a calendar on click.
BarModule {
    id: root

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    label: Qt.formatDateTime(clock.date, "ddd MMM d")
           + "  "
           + Qt.formatDateTime(clock.date, "h:mm:ss AP")

    onClicked: calendar.visible = !calendar.visible

    CalendarPopup {
        id: calendar
        anchorItem: root
    }
}
