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
    property bool halfDivided: false
    property int imgVerticalMargins: 0

    id: itemTopMenu1
    anchors.fill: parent
    width: parent.width
    height: parent.height
    Item{
        id: itemTopMenu1Img
        height: parent.height
        width: halfDivided? (parent.width/2-defMargin):(parent.width/3-defMargin)
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: defMargin
        anchors.topMargin: imgVerticalMargins
        anchors.bottomMargin: imgVerticalMargins
        Image{
            source: img
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
        Item{
            height: parent.height
            width: parent.width*2
            y: -parent.height/20


            TextFit{
                txt: imgText
                col: "#d4d4d4"
                transform: Scale{
                    xScale: 0.5
                }
            }
        }
    }
    Item{
        id: itemTopMenu1Text
        height: parent.height
        width: halfDivided? (parent.width/2-defMargin):( (parent.width/3)*2 - defMargin )
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: defMargin

        Item{
            id: itemTopMenu1Textline
            height: parent.height/3
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
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
