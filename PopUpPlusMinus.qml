import QtQuick

Item {
    id: root
    property alias color: rectBackground.color
    property alias radius: rectBackground.radius

    signal minusClicked()
    signal plusClicked()

    onVisibleChanged: {
        if(root.visible) timer.restart()
    }


    Rectangle{
        id: rectBackground
        anchors.fill: parent

            Rectangle{
                id: buttonMinus
                color: mouseAreaMinus.pressed? "dimgray":"black"
                height: parent.height - parent.radius*2
                width: (parent.width-parent.radius*3)/2
                radius: parent.radius
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.radius
                TextFit{
                    txt:"-"
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
                height: parent.height - parent.radius*2
                width: (parent.width-parent.radius*3)/2
                radius: parent.radius
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: parent.radius
                TextFit{
                    txt:"+"
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

    Timer{
        id: timer
        interval: 3000
        repeat: false
        onTriggered: {
            root.visible=false
        }
    }

}