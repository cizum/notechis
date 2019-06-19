import QtQuick 2.12

Text {
    id: root

    color: "red"
    style: Text.Outline
    styleColor: "#eeab00"
    transform: Rotation { origin.x: 0; origin.y: 0; axis { x: 1; y: 0; z: 0 } angle: 10 }

    signal tap(int delay)

    onTap: {
        delayTimer.interval = delay
        delayTimer.start()
    }

    Timer {
        id: delayTimer

        onTriggered: {
            root.opacity = 1
            mixAnim.start()
        }
    }

    Text {
        id: txt

        anchors.horizontalCenter: parent.horizontalCenter
        color: "#ff8000"
        text: parent.text
        font: parent.font
        scale: 1.15
        opacity: 0.1
        z: -1
        visible: parent.opacity !== 0
        y: -parent.y
    }

    ParallelAnimation {
        id: tapAnim

        NumberAnimation { target: root; property: "scale"; from: 1.3; to: 1; duration: 200; }
        ColorAnimation { target: root; property: "color"; from: "#eeab00"; to: "#aa5000"; duration: 200 }
    }

    ParallelAnimation {
        id: waveAnim

        NumberAnimation { target: root; property: "y"; from: -100; to: 0; duration: 200 }
        ColorAnimation { target: root; property: "color"; from: "#eeab00"; to: "#aa5000"; duration: 200 }
    }

    ParallelAnimation {
        id: mixAnim

        NumberAnimation { target: root; property: "y"; from: -45; to: 0; duration: 200 }
        NumberAnimation { target: root; property: "scale"; from: 1.3; to: 1; duration: 200}
        SequentialAnimation {
            ColorAnimation { target: root; property: "color"; from: "#303030"; to: "#eeab00"; duration: 200 }
            PauseAnimation { duration: 100 }
            ColorAnimation { target: root; property: "color"; from: "#eeab00"; to: "black"; duration: 200 }
        }
    }
}
