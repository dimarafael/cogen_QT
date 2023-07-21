import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property alias color: rectBackground.color
    property alias radius: rectBackground.radius

    signal minusClicked()
    signal plusClicked()
    signal minus10Clicked()
    signal plus10Clicked()

    onVisibleChanged: {
        if(root.visible) timer.restart()
    }


    Rectangle{
        id: rectBackground
        anchors.fill: parent

        Item{
            id:line1
            height: parent.height/2
            width: parent.width
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
            }

            Rectangle{
                id: buttonMinus
                color: mouseAreaMinus.pressed? "dimgray":"black"
                height: parent.height - rectBackground.radius*2
                width: (parent.width-rectBackground.radius*3)/2
                radius: rectBackground.radius
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: rectBackground.radius
                TextFit{
                    txt:"-1"
                    col:rectBackground.color
                }
                MouseArea{
                    id: mouseAreaMinus
                    anchors.fill: parent
                    onClicked: {
                        root.minusClicked()
                        timer.restart()
                    }
                }
            }

            Rectangle{
                id: buttonPlus
                color: mouseAreaPlus.pressed? "dimgray":"black"
                height: parent.height - rectBackground.radius*2
                width: (parent.width-rectBackground.radius*3)/2
                radius: rectBackground.radius
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: rectBackground.radius
                TextFit{
                    txt:"+1"
                    col:rectBackground.color
                }
                MouseArea{
                    id: mouseAreaPlus
                    anchors.fill: parent
                    onClicked:{
                        root.plusClicked()
                        timer.restart()
                    }
                }
            }

        }

        Item{
            id:line2
            height: parent.height/2
            width: parent.width
            anchors{
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            Rectangle{
                id: buttonMinus10
                color: mouseAreaMinus10.pressed? "dimgray":"black"
                height: parent.height - rectBackground.radius*2
                width: (parent.width-rectBackground.radius*3)/2
                radius: rectBackground.radius
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: rectBackground.radius
                TextFit{
                    txt:"-10"
                    col:rectBackground.color
                }
                MouseArea{
                    id: mouseAreaMinus10
                    anchors.fill: parent
                    onClicked: {
                        root.minus10Clicked()
                        timer.restart()
                    }
                }
            }

            Rectangle{
                id: buttonPlus10
                color: mouseAreaPlus10.pressed? "dimgray":"black"
                height: parent.height - rectBackground.radius*2
                width: (parent.width-rectBackground.radius*3)/2
                radius: rectBackground.radius
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: rectBackground.radius
                TextFit{
                    txt:"+10"
                    col:rectBackground.color
                }
                MouseArea{
                    id: mouseAreaPlus10
                    anchors.fill: parent
                    onClicked:{
                        root.plus10Clicked()
                        timer.restart()
                    }
                }
            }

        }

    }

    Timer{
        id: timer
        interval: 3000
        repeat: false
        onTriggered: {
            root.visible=false
        }
    }

    DropShadow {
        anchors.fill: rectBackground
        source: rectBackground
        horizontalOffset: root.width/30
        verticalOffset: root.width/30
        radius: 8.0
        samples: 17
        color: "#aa000000"
    }

}
