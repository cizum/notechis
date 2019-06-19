import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: root
    anchors.fill: parent

    property var serpentsID

    Repeater {
        model: root.serpentsID.count()

        RadialGradient {
            width: root.serpentsID.get(index).lampe ? 300 : 150
            height: root.serpentsID.get(index).lampe ? 300 : 150
            x: root.serpentsID.get(index).xC - width/2
            y: root.serpentsID.get(index).yC - width/2
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#ddffffff" }
                GradientStop { position: 0.4; color: "#ddffffff" }
                GradientStop { position: 0.5; color: "transparent" }
            }
        }
    }
}
