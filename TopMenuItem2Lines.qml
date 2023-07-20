import QtQuick
import QtQuick.Window
import QtQuick.Layouts
//import QtQuick.VirtualKeyboard
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item{
    id: root
    property string text1: "000"
    property string text2: "AAA"
    property string txtCol: "red"
    property string img: ""

    anchors.fill: parent
    width: parent.width
    height: parent.height
    Item{
        id: itemTopMenu1Img
        height: parent.height
        width: parent.width/3-defMargin
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: defMargin
        Image{
            source: img
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
    }
    Item{
        id: itemTopMenu1Text
        height: parent.height
        width: (parent.width/3)*2 - defMargin
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: defMargin
        Item{
            id: itemTopMenu1Textline1
            height: parent.height/4
            anchors.top: parent.top
            anchors.left: parent.lef
            anchors.right: parent.right
        }
        Item{
            id: itemTopMenu1Textline2
            height: parent.height/3
            width: parent.width
            anchors.top: itemTopMenu1Textline1.bottom
            anchors.left: parent.lef
            anchors.right: parent.right
            TextFit{
                txt: text1
                col: txtCol
                horizontalAlignment: Text.AlignLeft
                font.bold: true
            }
        }
        Item{
            id: itemTopMenu1Textline3
            height: parent.height/4
            width: parent.width
            anchors.top: itemTopMenu1Textline2.bottom
            anchors.left: parent.lef
            anchors.right: parent.right
            anchors.topMargin: -defMargin
            TextFit{
                txt: text2
                col: txtCol
                horizontalAlignment: Text.AlignLeft
                font.bold: true
            }
        }
    }
}
