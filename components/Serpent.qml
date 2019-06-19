import QtQuick 2.12
import QtMultimedia 5.0

Item {
    id: root

    width: taille
    height: taille
    x: xC - width / 2
    y: yC - height / 2

    property color usageColor: aec ? clr : mainColor
    property color clr: clrs[color_id]
    property color mainColor:"#0050ff"
    property var rgba: 0
    property var usageRgba: aec ? aecColor : rgba
    property var aecColor: clrs[color_id]

    property var clrs:["red", "orange",
                       "yellow", "#00ff00",
                       "blue", "indigo",
                       "violet"]
    property int color_id: 0

    property string name: ""
    property string usageName: vivant ? name : "RIP " + name

    property int taille: tailles[tailleValue]
    property var tailles: [1, 3 , 5 , 9 , 19, 37, 73, 145]
    property int tailleValue: 3

    property real xC: 0
    property real yC: 0
    property real oldX: -1
    property real oldY: -1

    property int angle: 0
    property bool moving: moveLeft || moveRight || moveUp || moveDown

    property bool vivant: true
    property int vie: 100
    property bool startWaiter: false
    property bool indications: false

    property bool aec: false
    property bool lampe: false
    property int invincible: 0
    property int inversion: 0
    property int alone: 0
    property int number: -1

    property double vitesse: 2
    property double vitesseAngulaire: 3

    property int moveLeft: 0
    property int moveRight: 0
    property int moveUp: 0
    property int moveDown: 0

    property int points: 0

    property var keys: ["", ""]
    property bool hole:false

    Timer {
        id: aecTimer

        interval: 100
        repeat: true
        running: root.aec
        onTriggered: root.color_id = (root.color_id + 1) % 7
    }

    Rectangle {
        anchors.fill: parent
        color: root.mainColor
        radius: root.taille / 2
        border.color: "#aaaaaa"
        visible: root.vivant
    }

    Rectangle {
        anchors.centerIn: parent
        width: 9
        height: 9
        color: root.mainColor
        radius: 5
        visible: !root.vivant
    }

    Powers {
        id: powers

        anchors.centerIn: parent
    }

    Item {
        width: 50
        height: 2
        visible: root.indications
        rotation: root.angle
        anchors.centerIn: parent

        Rectangle {
            anchors.fill: parent
            anchors.leftMargin: 40
            color: root.usageColor

            Text{
                anchors.centerIn: parent
                color: root.usageColor
                font.pixelSize: 16
                text: (root.keys[0].charCodeAt(0) === 18 ? "←" : root.keys[0]) + "   " + (root.keys[1].charCodeAt(0) === 20 ? "→" : root.keys[1])
                rotation: 90
            }
        }
    }

    SmallExplosion{
        id: explosion

        color: root.usageColor
    }

    function initialize(areaWidth, areaHeight) {
        resetPower()
        vivant = true
        xC = 100 + Math.random() * (areaWidth - 200)
        yC = 100 + Math.random() * (areaHeight - 200)
        angle = 180 + 180 * Math.atan2((xC - areaWidth / 2), (yC - areaHeight / 2)) / Math.PI
        startWait()
        invicibleTemporary()
    }

    function startWait() {
        startWaiter = true
        resetStartWait.restart()
    }

    Timer{
        id: resetStartWait

        interval: 2000
        onTriggered: root.startWaiter = false
    }

    function invicibleTemporary() {
        indications = true
        if (!resetInvincible.running)
            invincible = invincible + 1
        resetInvincible.restart()
    }

    Timer {
        id: resetInvincible
        interval: 4000
        onTriggered: {
            root.invincible = root.invincible - 1
            root.indications = false
        }
    }

    function resetPower() {
        powers.killAll()
    }

    onVivantChanged: {
        if (!vivant) {
            resetPower()
            explosion.run()
        }
    }

    function power(type) {
        powers.addElement(0, 0, type)
    }

    Timer{
        id:holeTimer
        running: false
        interval: 200
        onTriggered: root.hole = false
    }
    function startHole(duration) {
        hole = true
        holeTimer.interval = duration
        holeTimer.restart()
    }

    function explode() {
        explosion.run()
    }

    function kill() {
        root.vivant = false
    }

    function turnLeft() {
        root.angle = root.angle - root.vitesseAngulaire

    }
    function turnRight() {
        root.angle = root.angle + root.vitesseAngulaire
    }

    function nextX(){
        return xC + (moveUp - moveDown) * vitesse * Math.cos(Math.PI * root.angle / 180)
    }

    function nextY(){
        return yC + (moveUp - moveDown) * vitesse * Math.sin(Math.PI * root.angle / 180)
    }

    function move() {
        if (vivant){
            if (nextX() > root.parent.width)
                xC = 0
            else if (nextX() < 0)
                xC = root.parent.width
            else {
                if (xC !== nextX())
                    oldX = xC
                xC = nextX()
            }

            if (nextY() > root.parent.height) {
                yC = 0
            } else if(nextY() < 0) {
                yC = root.parent.height
            } else {
                if (yC !== nextY())
                    oldY = yC
                yC = nextY()
            }
        }
    }

    function angleAccessible(a) {
        var zone = Math.floor(a / 90)
        return zone * 90
    }

    function nextCX() {
        return xC + (moveUp - moveDown) * (vitesse * 0.7) * Math.cos(Math.PI * angleAccessible(root.angle) / 180)
    }

    function nextCY() {
        return yC + (moveUp - moveDown) * (vitesse * 0.7) * Math.sin(Math.PI * angleAccessible(root.angle) / 180)
    }

    function moveC() {
        if (vivant) {
            xC = nextCX()
            yC = nextCY()
        }
    }

    function angleAccessible2(a) {
        var zone = Math.ceil(a / 90)
        return zone * 90
    }

    function nextDX() {
        return xC + (moveUp - moveDown) * (vitesse * 0.7) * Math.cos(Math.PI * angleAccessible2(root.angle) / 180)
    }
    function nextDY() {
        return yC + (moveUp - moveDown) * (vitesse * 0.7) * Math.sin(Math.PI * angleAccessible2(root.angle) / 180)
    }
    function moveD() {
        if (vivant) {
            xC = nextDX()
            yC = nextDY()
        }
    }

    function randomRobotName() {
        var a = String.fromCharCode(Math.round(65 + Math.random() * (90 - 65)))
        var b = Math.round(Math.random()*9).toString()
        var c = String.fromCharCode(Math.round(65 + Math.random() * (90 - 65)))
        var d = Math.round(Math.random() * 9).toString()
        return a + b + "-" + c + d
    }

    function updateMove(moveList) {
        moveUp = moveList[0]
        moveLeft = moveList[1]
        moveDown = moveList[2]
        moveRight = moveList[3]

        if (inversion % 2 === 1) {
            if (moveRight)
                root.turnLeft()
            if (moveLeft)
                root.turnRight()
        } else {
            if (moveLeft)
                root.turnLeft()
            if (moveRight)
                root.turnRight()
        }
        root.move()
    }

    function update(moveList) {
        if (!startWaiter)
            root.updateMove(moveList)
    }
}
