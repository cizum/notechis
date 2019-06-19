import QtQuick 2.12
import "../scripts/createElement.js" as Logic

Item {
    id: root

    property int w: 1280
    property int h: 720

    function setX(id, x){
        root.children[id].x = x
    }

    function setY(id,y) {
        root.children[id].y = y
    }

    function setXY(id, x, y) {
        setX(id, x)
        setY(id, y)
    }

    function getX(id) {
        return root.children[id].x
    }

    function getY(id) {
        return root.children[id].y
    }

    function setV(id, v) {
        root.children[id].vitesse = v
    }

    function getV(id) {
        return root.children[id].vitesse
    }

    function getPlayer(id) {
        return root.children[id].player
    }

    function count() {
        return cnt
    }

    function clear(id) {
        root.children[id].destroy()
    }

    function clearAll() {
        cnt = 0;
    }

    function addElement(player, time) {
        if (player.oldX >= 0 && player.oldY >= 0) {
            root.randomHole(player)
            if (!player.hole) {
                root.drawArea(player, time)
            }
        }
    }

    function randomHole(player) {
        var r = Math.random()
        if (r < 0.007 && !player.hole) {
            player.startHole((player.taille / 9) * (150 + 20000 * r))
        }
    }

    function drawArea(player, time) {
        var ix = 0
        var jy = 0
        var area = Math.floor(player.taille / 2)
        for (var i = -area; i <= area; i++){
            for (var j = -area; j <= area; j++) {
                if (root.racinetest(i, j, area)) {
                    ix = Math.round(player.oldX + i)
                    jy = Math.round(player.oldY + j)
                    if (ix >= 0 && ix < root.w && jy >= 0 && jy < root.h) {
                        root.setIt(ix, jy, player)
                        cnt++
                        matrice[ix + jy * root.w] = [time ,player.number + 1]
                    }
                }
            }
        }
    }

    function racinetest(i, j, area) {
        return Math.sqrt(i * i + j * j) <= area
    }

    function setIt(ix, jy, player) {
        impix.setPixel(ix, jy, player.usageRgba)
    }

    property int cnt: 0
    property var matrice: []

    function initialize() {
        for (var i = 0; i < root.w * root.h; i++)
            matrice[i] = [0, 0]
    }
}
