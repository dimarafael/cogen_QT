import QtQuick
import QtQuick.Window
import QtQuick.Layouts
//import QtQuick.VirtualKeyboard
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    property string textColor: "#ffffff"
    property string buttonText: "BUTTON"
    property string imageSource: ""
    property bool st: false

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
            color: 'transparent'
        }
        Image {
            source: imageSource
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
                txt: buttonText
                col: st? "#0f0":textColor
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                itemRoot.clicked()
            }
        }
    }
}
