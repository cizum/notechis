import QtQuick 2.12

Item {
    id: root
    objectName: "keysControls"

    focus: true

    //stateGame : START/0 PAUSE/1 GAMELIFE/2 GAMEDEAD/3 OPTIONS/4 RESTART/5
    property int stateGame: 0
    property int previousStateGame: 0
    property var movePlayer0: [1, 0, 0, 0]
    property var movePlayer1: [1, 0, 0, 0]
    property var movePlayer2: [1, 0, 0, 0]
    property var movePlayer3: [1, 0, 0, 0]
    property var movePlayer4: [1, 0, 0, 0]
    property var movePlayer5: [1, 0, 0, 0]

    property var movePlayers: [movePlayer0, movePlayer1, movePlayer2, movePlayer3, movePlayer4, movePlayer5]

    property var keys1: [Qt.Key_Q, Qt.Key_S]
    property var keys2: [Qt.Key_Left, Qt.Key_Right]
    property var keys3: [Qt.Key_L, Qt.Key_M]
    property var keys4: [Qt.Key_2, Qt.Key_3]
    property var keys5: [Qt.Key_V, Qt.Key_B]
    property var keys6: [Qt.Key_5, Qt.Key_6]

    property var keys: [keys1, keys2, keys3, keys4, keys5, keys6]

    Keys.onPressed: {
        if (!event.isAutoRepeat) {
            switch (stateGame) {
                case 0:
                    break;
                case 1:
                    break;
                case 2:
                    pressKeys(event)
                    break;
                case 3:
                    break;
                case 4:
                    break;
                case 6:
                    break;
            }
        }
    }
    Keys.onReleased: {
        if (!event.isAutoRepeat) {
            switch (stateGame) {
                case 0:
                    break;
                case 1:
                    break;
                case 2:
                    releaseKeys(event)
                    break;
                case 3:
                    break;
                case 4:
                    break;
            }
        }
    }

    function resetVariables() {
        movePlayer0 = [0, 0, 0, 0]
        movePlayer1 = [0, 0, 0, 0]
        movePlayer2 = [0, 0, 0, 0]
        movePlayer3 = [0, 0, 0, 0]
    }

    function pressKeys(event) {
        for (var k = 0; k < keys.length; k++) {
            if (event.key === keys[k][0]) {
                movePlayers[k][1] = 1
            }
            else if (event.key === keys[k][1]) {
                movePlayers[k][3] = 1
            }
            movePlayers[k][0] = 1
            movePlayers[k][2] = 0
        }
    }
    function releaseKeys(event) {
        for (var k = 0; k < keys.length; k++) {
            if (event.key === keys[k][0]) {
                movePlayers[k][1] = 0
            }
            else if (event.key === keys[k][1]) {
                movePlayers[k][3] = 0
            }
            movePlayers[k][0] = 1
            movePlayers[k][2] = 0
        }
    }
}
