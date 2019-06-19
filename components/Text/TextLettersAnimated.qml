import QtQuick 2.12
import "createElement.js" as Creator

Item {
    id: root

    property string text: ""
    property color color: "white"
    property int fontPixelSize: 120
    property string fontFamily: "JackInput"
    property int letterSpacing: 5

    width: lettersRow.width
    height: lettersRow.height

    Row {
        id: lettersRow

        spacing: root.letterSpacing
    }

    Component.onCompleted: {
        for (var i = 0; i < root.text.length; i++) {
            Creator.createElement("TextBasic.qml", lettersRow)
            lettersRow.children[i].opacity = 0
            lettersRow.children[i].text = root.text[i]
            lettersRow.children[i].font.pixelSize = root.fontPixelSize
            lettersRow.children[i].font.family = root.fontFamily
        }
        runAnimTimer.start()
    }

    Timer {
        id: runAnimTimer

        interval: 500
        onTriggered: {
            for (var i = 0; i < root.text.length; i++){
                lettersRow.children[i].tap(100 * i)
            }
        }
    }

    function clear() {
        for (var i = 0; i < lettersRow.children.length; i++)
            lettersRow.children[i].destroy()
    }

    function run() {
        for (var i = 0; i < root.text.length; i++){
            lettersRow.children[i].opacity = 0
            lettersRow.children[i].text = root.text[i]
            lettersRow.children[i].font.pixelSize = root.fontPixelSize
            lettersRow.children[i].font.family = root.fontFamily
        }
        runAnimTimer.restart()
    }
}
