import QtQuick 2.12
import "qrc:/scripts/createElement.js" as Logic

Item {
    id: root

    function setX(id,x){
        root.children[id].xC = x
    }

    function setY(id,y){
        root.children[id].yC = y
    }

    function get(id) {
        return root.children[id]
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

    function getColor(id) {
        return root.children[id].mainColor
    }

    function count() {
        return root.children.length
    }

    function clear(id) {
        root.children[id].destroy()
    }

    function clearAll() {
        for (var i = 0; i < count(); i++)
            clear(i)
    }

    function addElement(x, y, color, name) {
        if (x >= 0 && y >= 0) {
            Logic.createElementProp("qrc:/components/Serpent", {"xC": x,"yC": y, "mainColor": color, "name": name})
        }
    }
}
