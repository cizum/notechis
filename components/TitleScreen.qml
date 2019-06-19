import QtQuick 2.12
import "Text"

Rectangle {
    id: root

    width: 1280
    height: 720
    color: "#101010"
    visible: opacity !== 0

    signal endTitle()

    Behavior on opacity { NumberAnimation { duration: 400 } }
    Behavior on scale { NumberAnimation { duration: 400 } }

    TextLettersAnimated {
        id: title

        text: "notechis"
        anchors.centerIn: parent
        fontPixelSize: 140
    }

    Timer {
        running: true
        interval: 2500
        onTriggered: {
            root.opacity = 0
            root.scale = 100
            root.endTitle()
        }
    }
}

