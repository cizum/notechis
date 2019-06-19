import QtQuick 2.12

Item {
    id: root

    width: root.parent.parent.taille + root.num * 6 + 15
    height: root.parent.parent.taille + root.num * 6 + 15
    anchors.centerIn: parent

    property bool active: true
    property int num: 0
    property int type: 0

    Timer {
        id: powerTimer

        interval: 1000
        onTriggered: root.endPower()
    }

    Component.onCompleted: {
        active = true
        switch (type) {
        case 0:
            powerTimer.interval = 4000
            root.parent.parent.tailleValue = root.parent.parent.tailleValue + 1
            break
        case 1:
            powerTimer.interval = 4000
            root.parent.parent.tailleValue = root.parent.parent.tailleValue - 1
            break
        case 2:
            powerTimer.interval = 8000
            root.parent.parent.aec = true
            break
        case 3:
            powerTimer.interval = 4000
            root.parent.parent.vitesse = root.parent.parent.vitesse / 2
            root.parent.parent.vitesseAngulaire = root.parent.parent.vitesseAngulaire / 2
            break
        case 4:
            powerTimer.interval = 4000
            root.parent.parent.vitesse = root.parent.parent.vitesse * 2
            root.parent.parent.vitesseAngulaire = root.parent.parent.vitesseAngulaire * 2
            break
        case 5:
            powerTimer.interval = 5000
            root.parent.parent.invincible = root.parent.parent.invincible + 1
            break
        case 6:
            powerTimer.interval = 4000
            root.parent.parent.lampe = true
            break
        case 7:
            powerTimer.interval = 4000
            root.parent.parent.inversion = root.parent.parent.inversion + 1
            break
        case 8:
            powerTimer.interval = 3000
            root.parent.parent.alone = root.parent.parent.alone + 1
            break
        }
        powerTimer.restart()
    }

    function endPower(){
        if (!active)
            return
        powerTimer.stop()
        switch (type) {
        case 0:
            root.parent.parent.tailleValue = root.parent.parent.tailleValue - 1
            break
        case 1:
            root.parent.parent.tailleValue = root.parent.parent.tailleValue + 1
            break
        case 2:
            root.parent.parent.aec = false
            break
        case 3:
            root.parent.parent.vitesse = root.parent.parent.vitesse * 2
            root.parent.parent.vitesseAngulaire = root.parent.parent.vitesseAngulaire * 2
            break
        case 4:
            root.parent.parent.vitesse = root.parent.parent.vitesse / 2
            root.parent.parent.vitesseAngulaire = root.parent.parent.vitesseAngulaire / 2
            break
        case 5:
            root.parent.parent.invincible = root.parent.parent.invincible - 1
            break
        case 6:
            root.parent.parent.lampe = false
            break
        case 7:
            root.parent.parent.inversion = root.parent.parent.inversion - 1
            break
        case 8:
            root.parent.parent.alone = root.parent.parent.alone - 1
            break
        }
        active = false;
        root.destroy()
    }
}

