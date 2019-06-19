import QtQuick 2.12

Item {
    id:root
    objectName: "classement"

    property var players: []
    property var points: []

    Text {
        text: "Objectif :  " + (root.players.length - 1) * 10 +  " ou plus"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: scoreColumn.top
        anchors.bottomMargin: 30
        font.pixelSize: 25
        color: "white"
    }

    Column{
        id: scoreColumn

        spacing: 5
        anchors.centerIn: parent

        Repeater{
            model: classement

            Rectangle{
                width: index === 0 ? 260 : 250
                height: index === 0 ? 55 : 50
                color: index === 0? "#101010" : "#151515"
                border.color: index === 0 ? "#707070" : "#aaaaaa"
                border.width: index === 0 ? 3 : 1
                anchors.horizontalCenter: scoreColumn.horizontalCenter

                Rectangle{
                    width: 33
                    height: 33
                    radius: 17
                    color: clr
                    anchors.verticalCenter: parent.verticalCenter
                    x: 10

                    Text {
                        anchors.centerIn: parent
                        text: score
                        color: "black"
                        font.bold: true
                        font.pixelSize: 24
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    x: 55
                    text: name
                    color: index === 0 ? "white" : "#bbbbbb"
                    font.pixelSize: 24
                }
            }

        }
    }

    ListModel{
        id: classement
    }

    function organize(){
        classement.clear()
        var cls = []
        for (var i = 0; i < players.length; i++)
            cls.push([points[i],players[i]])
        cls.sort(function(a, b) {
            return b[0] - a[0];
        })
        for (i = 0; i < players.length; i++)
            classement.append({"score": cls[i][0], "name": cls[i][1][1], "clr": cls[i][1][0]})

    }
}

