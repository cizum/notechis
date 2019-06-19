import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: root

    property int winner: -1
    property int megaWinner: -1
    property int nbAlone
    property int totalTime: 0
    property int pointsLimit: 10
    property int safetime: 400

    signal pointsUpdate(var points)
    signal terminateGame(string name)

    onTerminateGame: {
        serpents.clearAll()
        keyscontrols.stateGame = 0
    }

    KeysControls {
        id: keyscontrols
    }

    Rectangle {
        id: night

        color: "black"
        anchors.fill: parent
        visible: opacityMask.visible
    }

    Item {
        id: graphics

        width: parent.width
        height: parent.height

        property real nextX: -1
        property real nextY: -1
        property bool isAlone: false

        Binding {
            when: graphics.isAlone
            target: graphics
            property: "x"
            value: root.xArea()
        }

        Binding {
            when: graphics.isAlone
            target: graphics
            property: "y"
            value: root.yArea()
        }

        SequentialAnimation {
            id: xyAnim

            ParallelAnimation {
                NumberAnimation { target: graphics; property: "x"; to: (graphics.isAlone === 0 ? 0 : graphics.nextX); duration: 50; easing.type: "InOutQuad" }
                NumberAnimation { target: graphics; property: "y"; to: (graphics.isAlone === 0 ? 0 : graphics.nextY); duration: 50; easing.type: "InOutQuad" }
            }
            ScriptAction { script: graphics.isAlone = (root.nbAlone > 0) }
        }

        Rectangle {
            id: background

            color: "#101010"
            anchors.fill: parent
        }

        Text {
            anchors.centerIn: parent
            text: "NOTECHIS"
            font.pixelSize: 150
            color: "#111111"
        }

        Bonus {
            id: bonus

            anchors.fill: parent
        }

        Ligne {
            id: ligne

            w: root.width
            h: root.height
            visible: false
        }

        Image {
            id: img

            source: "image://provider/0"
            cache: false
        }

        Serpents {
            id: serpents

            anchors.fill: parent
        }

        Rectangle {
            id: bords

            color: "transparent"
            border.color: "#606060"
            anchors.fill: parent
        }

        visible: !opacityMask.visible
    }

    Mask {
        id: mask

        serpentsID: serpents
        visible: false
    }

    OpacityMask {
        id: opacityMask

        source: graphics
        maskSource: mask
        width: parent.width
        height: parent.height
        x: graphics.x
        y: graphics.y
        visible: {
            for (var i = 0; i < serpents.count(); i++)
                if (serpents.get(i).lampe)
                    return true
            return false
        }
    }

    Text {
        anchors.centerIn: parent
        text: {
            if (root.winner !== -1) {
                if (root.pointsLimit - serpents.get(root.winner).points <= 5)
                    return "Focus " + serpents.get(root.winner).name + " !!!"
                return serpents.get(root.winner).name + " est chaud !"
            } else {
                return ""
            }
        }
        font.pixelSize: 70
        anchors.verticalCenterOffset: 200
        color: "black"
        visible: root.winner !== -1
        style: Text.Outline
        styleColor: root.winner !== -1 ? serpents.get(root.winner).mainColor : "black"
        opacity: 0.8
    }

    Timer {
        id: timer

        interval: 15
        running: true
        repeat: true
        onTriggered: {
            root.totalTime += interval
            switch (keyscontrols.stateGame) {
                case 0:
                    //DEMARRAGE
                    break
                case 1:
                    //PAUSE
                    break
                case 2:
                    //GAMELIFE
                    root.update()
                    break
                case 3:
                    //GAMEDEAD
                    break
                case 4:
                    //OPTIONS
                    break
                case 5:
                    //RESTART
                    root.restartGame(false)
                    break
                case 6:
                    //GAMEWIN
                    root.terminateGame(serpents.get(root.megaWinner).usageName)
                    break
            }
        }
    }

    function initializeGame(players) {
        keyscontrols.stateGame = 0
        var points = []
        megaWinner = -1
        for (var i = 0; i < players.length; i++) {
            serpents.addElement(Math.random() * parent.width, Math.random() * parent.height, players[i][0], players[i][1])
            serpents.get(i).number = i
            serpents.get(i).points = 0
            serpents.get(i).rgba = players[i][2]
            serpents.get(i).keys = [String.fromCharCode(keyscontrols.keys[i][0]), String.fromCharCode(keyscontrols.keys[i][1])]
            points.push(0)
        }
        pointsLimit = serpents.count() * 10 - 10
        pointsUpdate(points)
        restartGame()
    }

    function update() {
        img.source = ""
        root.isTouchingMatrice()
        root.isTouchingBonus()
        root.tracerLigne()
        root.genererBonus()
        root.isWinner()
        img.source = "image://provider/0"
    }

    function isTouchingMatrice() {
        var area = 3
        var ix = 0
        var jy = 0
        var nbDeaths = 0
        for (var s = 0; s < serpents.count(); s++) {
            if (serpents.get(s).vivant && serpents.get(s).invincible === 0 && !serpents.get(s).hole) {
                area = serpents.get(s).taille / 2
                for (var i = -area; i <= area; i++) {
                    for (var j = -area; j <= area; j++) {
                        if (Math.sqrt(i * i + j * j) <= area && serpents.get(s).vivant) {
                            ix = Math.round(serpents.getXC(s) + i)
                            jy = Math.round(serpents.getYC(s) + j)
                            if (ix <= 0 || ix >= (root.width - 1) || jy <= 0 || jy >= (root.height - 1)) {
                                serpents.get(s).kill()
                                root.deathScore(s)
                                nbDeaths++
                            }
                            else if (ligne.matrice[ix + jy * root.width][1] > 0) {
                                if ((ligne.matrice[ix + jy * root.width][1] !== (s + 1)) || (ligne.matrice[ix + jy * root.width][0] < (root.totalTime - safetime))) {
                                    serpents.get(s).kill()
                                    root.deathScore(s)
                                    nbDeaths++
                                }
                            }
                        }
                    }
                }
            }
        }
        if (nbDeaths > 1) {
            console.log("BISOU")
        }
    }

    function isTouchingBonus() {
        var area = 3
        var ix = 0
        var jy = 0
        for (var b = 0; b < bonus.count(); b++) {
            if (bonus.getActif(b)) {
                for (var s = 0; s < serpents.count(); s++) {
                    if (serpents.get(s).vivant) {
                         if (Math.abs(serpents.getXC(s) - bonus.getXC(b)) < 25 && Math.abs(serpents.getYC(s) - bonus.getYC(b)) < 25) {
                             assignPower(s, bonus.getType(b))
                             bonus.kill(b)
                         }
                    }
                }
            }
        }
    }

    function basile() {
        var moveBasile = [1,0,0,0]
        if (serpents.get(0).x < 100) {
            if (serpents.get(0).y > root.height / 2)
                moveBasile[3] = 1
            else
                moveBasile[1] = 1
        }
        else if (serpents.get(0).x > root.width - 100) {
            if (serpents.get(0).y > root.height / 2)
                moveBasile[1] = 1
            else
                moveBasile[3] = 1
        }
        else if (serpents.get(0).y < 100) {
            if (serpents.get(0).x > root.width / 2)
                moveBasile[3] = 1
            else
                moveBasile[1] = 1
        }
        else if (serpents.get(0).y > root.height - 100) {
            if (serpents.get(0).x > root.width / 2)
                moveBasile[1] = 1
            else
                moveBasile[3] = 1
        }
        keyscontrols.movePlayers[0] = moveBasile
    }

    function tracerLigne() {
        for (var s = 0; s < serpents.count(); s++) {
            if (serpents.get(s).vivant) {
                serpents.get(s).update(keyscontrols.movePlayers[s])
                if (serpents.get(s).invincible === 0)
                    ligne.addElement(serpents.get(s), root.totalTime)
            }
        }
    }
    function genererBonus() {
        if (Math.random() < 0.005)
            bonus.randomElement()
    }

    function isWinner() {
        var nbVivants = serpents.count()
        var kenLeSurvivant = 0
        var maxScore = 0
        for (var i = 0; i < serpents.count(); i++) {
            if (serpents.get(i).vivant)
                kenLeSurvivant = i
            else
                nbVivants--
            if (serpents.get(i).points >= pointsLimit && serpents.get(i).points > maxScore) {
                maxScore = serpents.get(i).points
                root.megaWinner = i
            }
        }
        if (nbVivants === 1) {
            winner = kenLeSurvivant
            restarter.start()
        }
        else if (nbVivants === 0){
            winner = -1
            restarter.start()
        }
    }

    function assignPower(serpent, type) {
        var s2 = 0
        switch(type) {
        case 0:
            for (s2 = 0; s2 < serpents.count(); s2++) {
                if (s2 !== serpent)
                    serpents.get(s2).power(0)
            }
            break
        case 1:
            serpents.get(serpent).power(1)
            break
        case 2:
            for (s2 = 0; s2 < serpents.count(); s2++) {
                serpents.get(s2).power(2)
            }
            break
        case 3:
            for (s2 = 0; s2 < serpents.count(); s2++) {
                if (s2 !== serpent)
                    serpents.get(s2).power(3)
            }
            break
        case 4:
            serpents.get(serpent).power(4)
            break
        case 5:
            serpents.get(serpent).power(5)
            break
        case 6:
            serpents.get(serpent).power(6)
            break
        case 7:
            for (s2 = 0; s2 < serpents.count(); s2++) {
                if (s2 !== serpent)
                    serpents.get(s2).power(7)
            }
            break;
        case 8:
            serpents.get(serpent).power(8)
            break
        }
    }

    function restartGame() {
        for (var s = 0; s < serpents.count(); s++) {
            serpents.get(s).initialize(root.width, root.height)
            keyscontrols.movePlayers[s] = [1, 0, 0, 0]
        }
        root.winner = -1
        bonus.clearAll()
        ligne.clearAll()
        ligne.initialize()
        impix.clear()
        root.totalTime = 0
        if (megaWinner >= 0)
            keyscontrols.stateGame = 6
        else
            keyscontrols.stateGame = 2
    }

    function xArea() {
        var xtmp = 0
        var div = 0
        for (var s = 0; s < serpents.count(); s++) {
             if (serpents.get(s).alone > 0) {
                 xtmp += serpents.get(s).x
                 div++
             }
        }
        if (div > 0) {
            xtmp = xtmp / div
            xtmp = -xtmp + root.width / 2
        }
        nbAlone = div
        return xtmp
    }
    function yArea() {
        var ytmp = 0
        var div = 0
        for (var s = 0; s < serpents.count(); s++) {
             if (serpents.get(s).alone > 0) {
                 ytmp += serpents.get(s).y
                 div++
             }
        }
        if (div > 0) {
            ytmp = ytmp / div
            ytmp = -ytmp + root.height / 2
        }

        nbAlone = div
        return ytmp
    }

    function deathScore(s) {
        var points = []
        for (var i = 0; i < serpents.count(); i++) {
            if (i !== s && serpents.get(i).vivant)
                serpents.get(i).points++
            points.push(serpents.get(i).points)
        }
        pointsUpdate(points)
    }

    Timer {
        id: restarter

        interval: 3000
        onTriggered: root.restartGame(false)
    }

    onNbAloneChanged: {
        if (root.nbAlone > 0) graphics.isAlone = false
        graphics.nextX = xArea()
        graphics.nextY = yArea()
        xyAnim.start()
    }
}

