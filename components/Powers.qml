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

    function kill(id) {
        root.children[id].endPower()
    }

    function killAll() {
        for (var i = 0; i < count(); i++)
            kill(i)
    }

    function addElement(x, y, type) {
        if (x >= 0 && y >= 0) {
            Logic.createElementProp("qrc:/components/PowerElement",
                                    { "x": x, "y": y, "type": type, "num": root.count() })
        }
    }
}
