import QtQuick
import QtQuick.Window
import QtQuick.Layouts
//import QtQuick.VirtualKeyboard
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item{
    property string text1: "000"
    property string txtCol: "red"
    property string img: ""
    property string imgText: ""

    id: itemTopMenu1
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
        TextFit{
            txt: imgText
            col: "#d4d4d4"
//            font.bold: true
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
            height: parent.height/3
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
    }
}
