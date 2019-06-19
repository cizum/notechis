import QtQuick 2.12

Item{
    id: root

    property string color: "black"
    property int player: 0
    property int taille: 9

    Rectangle {
        width: root.taille
        height: root.taille
        radius: root.taille / 2
        anchors.centerIn: parent
        color:root.color
    }
}


