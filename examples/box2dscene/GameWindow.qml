/**
 * Copyright (C) 2012 by INdT
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 * @author Rodrigo Goncalves de Oliveira <rodrigo.goncalves@openbossa.org>
 * @author Roger Felipe Zanoni da Silva <roger.zanoni@openbossa.org>
 */

QuasiGame {
    id: game

    width: 800
    height: 600

    currentScene: scene

    QuasiPhysicsScene {
        id: scene

        width: parent.width
        height: parent.height

        entities: [
            QuasiBody {
                id: mouseItem

                width: 60
                height: 60

                friction: 0.3 + Math.random() * 1.0
                density: 5 + Math.random() * 10
                restitution: 0.6 + Math.random() * 1.0
                sleepingAllowed: false

                Rectangle {
                    color: "green"
                    anchors.fill: parent
                }

                x: 200
                y: 160
            },
            QuasiMouseJoint {
                target: mouseItem
            },
            QuasiBody {
                id: ground

                bodyType: Quasi.StaticBodyType

                width: 790
                height: 1

                friction: 0.3
                density: 50
                restitution: 0.6

                Rectangle {
                    color: "green"
                    anchors.fill: parent
                }

                x: 0
                y: 500
            }
        ]
    }

    Component {
        id: bodyComponent

        QuasiBody {
            width: 10 + Math.random() * 90
            height:10 + Math.random() * 90

            x: Math.random() * scene.width
            y: 200 + Math.random() * -scene.height


            friction: 0.3
            density: 5
            restitution: 0.6
            sleepingAllowed: false

            Rectangle {
                anchors.fill: parent

                color: "red"
            }
        }
    }

    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: scene.createEntity(bodyComponent)
    }

    Component.onCompleted: {
        for (var i = 0; i < 10; i++) {
            scene.createEntity(bodyComponent)
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: scene.createEntity(bodyComponent)
    }
}