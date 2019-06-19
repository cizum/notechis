import QtQuick 2.12
import "../scripts/createElement.js" as Logic

Item {
    id: root

    function setX(id, x) {
        root.children[id].x = x
    }

    function setY(id, y) {
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

    function getXC(id) {
        return root.children[id].xC
    }

    function getYC(id) {
        return root.children[id].yC
    }

    function getType(id) {
        return root.children[id].type
    }

    function getActif(id) {
        return root.children[id].actif
    }

    function count() {
        return root.children.length
    }

    function clear(id) {
        root.children[id].destroy()
    }

    function kill(id) {
        root.children[id].kill()
    }

    function clearAll() {
        for (var i = 0; i < count(); i++)
            clear(i)
    }

    function addElement(x, y, type){
        if (x >= 0 && y >= 0){
            Logic.createElementBonus("../components/BonusElement", x, y, type)
        }
    }

    function randomElement() {
        var t = Math.floor(Math.random() * 9)
        addElement(20 + Math.random() * (root.width - 40), 20 + Math.random() * (root.height - 40), t)
    }
}
