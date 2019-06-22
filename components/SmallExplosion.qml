import QtQuick 2.12
import QtQuick.Particles 2.12

Item {
    id: root

    property color color: "#00ff00"

    ParticleSystem {
        id: particles

        anchors.fill: parent

        ImageParticle {
            source: "qrc:/images/particule.png"
            alpha: 0
            color: root.color
            colorVariation: 0.4
        }

        Emitter {
            id: burstEmitter

            emitRate: 100
            lifeSpan: 200
            enabled: false
            size: 2
            endSize: 0
            sizeVariation: 8
            velocity: CumulativeDirection {
                AngleDirection { magnitude: 150; angleVariation: 360 }
                AngleDirection { magnitude: 300; angle: 80; angleVariation: 10 }
                AngleDirection { magnitude: 300; angle: 260; angleVariation: 10 }
            }
        }
    }

    function run(){
        burstEmitter.burst(200)
    }
}
