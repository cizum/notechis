import QtQuick 2.12
import QtMultimedia 5.0
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 50
    height: 50
    x: xC - width / 2
    y: yC - height / 2
    visible: actif

    property real xC: 0
    property real yC: 0

    //0=big 1=fin 2=ARCENCIEL 3=lent 4=rapide 5=volant 6=lampe 7=inversion 8=recentrage
    property int type:0
    property var colors: ["#ff0000", "#00cc00", "#1099ee", "#ff0000", "#00cc00", "#00cc00", "#00bb00", "#ff0000", "#ff0000"]
    property bool actif: true
    signal  kill()

    Rectangle {
        id: background

        color: root.colors[root.type]
        border.color: "white"
        border.width: 2
        anchors.fill: parent
        radius: 25
        opacity: 0.8
    }

    Image {
        id: picto

        anchors.centerIn: parent
        source: {
            switch (root.type) {
            case 0:
                return ""
            case 1:
                return ""
            case 2:
                return "../images/aec.png"
            case 3:
                return "../images/lent.png"
            case 4:
                return "../images/rapide.png"
            case 5:
                return ""
            case 6:
                return "../images/lampe.png"
            case 7:
                return "../images/inversion.png"
            case 8:
                return ""
            }
        }
    }

    Rectangle {
        id: volant

        anchors.centerIn: parent
        color: "white"
        width: parent.width / 4
        height: width
        radius: width / 2
        visible: root.type === 5
    }

    Rectangle {
        id: fin

        anchors.centerIn: parent
        color: "white"
        width: parent.width / 1.5
        height: 2
        visible: root.type === 1
        rotation: 20
    }

    Rectangle {
        id: epais

        anchors.centerIn: parent
        color: "white"
        width: parent.width / 1.5
        height: 15
        visible: root.type===0
        rotation: 20
    }

    Rectangle {
        id: recentrage

        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -5
        anchors.verticalCenterOffset: -5
        color: "transparent"
        border.color: "white"
        width: 20
        height: 20
        visible: root.type === 8

        Rectangle {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 10
            anchors.verticalCenterOffset: 10
            color: "transparent"
            border.color: "white"
            width: 20
            height: 20
        }
    }

    onKill:{
        actif = false
    }
}

