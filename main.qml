import QtQuick 2.12
import QtQuick.Window 2.2
import "components"

Window {
    id: root

    width: 1280
    height: 720
    visible: true
    color: "#101010"

    Item {
        id: container

        width: 1280
        height: 720
        anchors.centerIn: parent
        transform: Scale {
            xScale: root.width / container.width
            yScale: root.height / container.height
            origin.x: container.width / 2
            origin.y: container.height / 2
        }

        GameArea {
            id: gameArea

            anchors.fill: parent
            anchors.leftMargin: 300
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            anchors.rightMargin: 5
            clip: true
            visible: false

            onPointsUpdate: {
                classement.points = points
                classement.organize()
            }
            onTerminateGame: {
                megaWinnerScreen.winName = name
                megaWinnerScreen.opacity = 1
            }
        }

        Rectangle {
            id: gameBorder

            anchors.fill: gameArea
            color: "transparent"
            border.color: "#909090"
            border.width: 2
            visible: gameArea.visible
        }

        Classement {
            id: classement

            width: 300
            height: parent.height
            visible: false
        }

        MegaWinnerScreen {
            id: megaWinnerScreen

            anchors.fill: gameArea
            onAskForRestart: menu.opacity = 1
        }

        Menu {
            id: menu

            onStart: {
                classement.players = players
                gameArea.initializeGame(players)
                menu.opacity = 0
                gameArea.visible = true
                classement.visible = true
            }
        }

        TitleScreen {
            id: titleScreen

            onEndTitle: menu.opacity = 1
        }
    }
}

