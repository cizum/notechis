import QtQuick 2.12

Item {
    id: root

    width: 1280
    height: 720
    opacity: 0
    visible: opacity !== 0
    Behavior on opacity { NumberAnimation { duration: 500 } }

    property string winName: "Personne"
    signal askForRestart

    Text{
        text: root.winName + " victorieux dans la victoire !"
        width: 800
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        anchors.centerIn: parent
        font.pixelSize: 80
        color: "#ffffff"
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            root.opacity = 0
            root.askForRestart()
        }
    }
}

