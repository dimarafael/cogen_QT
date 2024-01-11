import QtQuick
import QtQuick.Window
import QtQuick.Layouts
//import QtQuick.VirtualKeyboard
import QtQuick.Controls
import Qt5Compat.GraphicalEffects


Item {
    property string textColor: "#ffffff"
    property string buttonText: "BUTTON"
    property string button2Text: "BUTTON"
    property string imageSource: ""
    property string image2Source: ""

    property bool st: false
    property bool st2: false

    signal clicked

    anchors.fill: parent
    id: itemRoot

    Item{
        anchors.fill: parent
        clip: true
        Rectangle{
            anchors.fill: parent
            anchors.leftMargin: -2
            anchors.rightMargin: -4
            border.color: textColor
            border.width: 2
            color: mouseArea.pressed? "dimgray":'transparent'
        }
        Image {
            id: iconImage
            source: st2? image2Source:imageSource
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: height/5
            height: parent.height/2
            sourceSize.width: parent.width
            fillMode: Image.PreserveAspectFit
        }
        Item{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: height/5
            anchors.bottomMargin: height/5
            height: parent.height/3
            TextFit{
                id: textButon
                txt: st2? button2Text:buttonText
                col: textColor
            }
            Glow{
                anchors.fill: textButon
                source: textButon
                radius: 18
                samples: 37
                color: "#aa00ff00"
                visible: st
            }
        }
        MouseArea{
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                itemRoot.clicked()
                focus = true
            }
        }

        Glow{
            anchors.fill: iconImage
            source: iconImage
            radius: 18
            samples: 37
            color: "#aa00ff00"
            spread: 0.5
            visible: st
        }

    }
}
