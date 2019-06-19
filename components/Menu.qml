import QtQuick 2.12
import QtGraphicalEffects 1.0
import "Text"

Rectangle {
    id: root

    width: 1280
    height: 720
    color: "#101010"
    opacity: 0
    visible: opacity !== 0

    property var players: []
    property int nbSerpents: 2

    signal start(var players)

    Behavior on opacity { NumberAnimation { duration: 500 } }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            root.nbSerpents = (root.nbSerpents + 1) % 7
            if (root.nbSerpents < 2)
                root.nbSerpents = 2
            root.createPlayers(root.nbSerpents)
        }
    }

    Text {
        id: nSerpentsText

        anchors.horizontalCenter: parent.horizontalCenter
        y: 150
        font.pixelSize: 80
        color: "#bbbbbb"
        text: root.nbSerpents + " joueurs"
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: nSerpentsText.bottom
        font.pixelSize: 15
        color: "#808080"
        text: "Cliquez (presque) n'importe où pour changer le nombre"
    }

    Row {
        anchors.centerIn: parent
        spacing: 20

        Repeater {
            model: root.currentPlayers

            Item {
                width: 140
                height: 110

                Rectangle {

                    width: 9
                    height: 9
                    radius: 5
                    border.color: color
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 10 * (Math.cos((angle + 40 * index) * Math.PI / 180))
                    anchors.horizontalCenterOffset: 20 * (Math.sin((angle + 40 * index) * Math.PI / 180))
                    color: colorP

                    property int angle: 0

                    SequentialAnimation on angle{

                        running: root.visible
                        loops: Animation.Infinite
                        NumberAnimation { from: 360; to: 0; duration: 1000 }
                    }
                }

                Rectangle{
                    id: cadre

                    anchors.fill: parent
                    color: "transparent"
                    border.color: "#909090"
                    antialiasing: true
                    smooth: true

                    transform: Rotation {
                        origin.x: cadre.height / 2
                        origin.y: 0
                        axis { x: 0.3; y: 1; z: 0 }
                        angle: cadre.agl + 40 * index
                    }

                    property int agl: 0

                    SequentialAnimation on agl {
                        running: root.visible
                        loops: Animation.Infinite

                        NumberAnimation { from: 0; to: 360; duration: 1000 }
                    }

                    Text {
                        anchors.bottom:parent.bottom
                        anchors.bottomMargin: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: parent.border.color
                        text: nameP
                        font.pixelSize: 18
                    }
                }
            }
        }
    }

    MouseArea{
        id: validButton

        anchors.horizontalCenter: parent.horizontalCenter
        y: 500
        width: 510
        height: 120
        hoverEnabled: true
        onEntered: startText.color = "#ffffff"
        onExited: startText.color = "#eeaa00"

        Text {
            id: startText

            anchors.centerIn: parent
            font.pixelSize: 100
            text: "C'est parti !"
            color: "#eeaa00"
            Behavior on color { ColorAnimation { duration: 200 } }
        }

        onClicked: {
            root.start(root.players)
            validButton.enabled = false
        }
    }

    property var playerColorModel: [
        ["#3366ff", ["Schtroumpf", "Leonardo", "Sonic","Carapuce", "M&M's Bleu", "Tristesse"], 4281558783],
        ["red", ["Flash", "Raphael", "Hellboy", "M&M's Rouge", "Super Meat Boy", "Colère"], 4294901760],
        ["#00ff00", ["Hulk", "Franklin", "Yoda", "Yoshi", "Piccolo", "The Mask"], 4278255360],
        ["yellow", ["Moutarde", "Bob l'éponge", "Maya", "M&M's Jaune", "Pikachu", "Pacman"], 4294967040],
        ["#ff6600", ["Michelangelo", "Salamèche", "Kenny", "Casimir", "Naruto", "Simba"], 4294927872],
        ["#9900ff", ["Violette", "Donatello", "Waluigi","Spyro", "Freezer", "Joker"], 4288217343],
        ["#cc6699", ["Madrange", "Fleury Michon", "Marque Repère", "Herta", "Tradilège", "Cochonou"], 4291585689]
    ]
    property ListModel currentPlayers : ListModel {}

    function createPlayers(n) {
        players = []
        currentPlayers.clear()
        var couleurs = [false,false,false,false,false,false,false]
        var c = 0
        for (var i = 0; i < n; i++){
            c = Math.floor(Math.random() * playerColorModel.length)
            while (couleurs[c]){
                c = Math.floor(Math.random() * playerColorModel.length)
            }
            couleurs[c] = true
            var clr = playerColorModel[c][0]
            var name = playerColorModel[c][1][Math.floor(Math.random() * 6)]
            players.push([clr, name, playerColorModel[c][2]])
            currentPlayers.append({"colorP": clr, "nameP": name})
        }
    }

    onVisibleChanged: {
        if (visible) {
            createPlayers(nbSerpents)
            validButton.enabled = true
        }
    }
}

