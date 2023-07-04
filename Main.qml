import QtQuick
import QtQuick.Window
import QtQuick.Layouts
//import QtQuick.VirtualKeyboard
import QtQuick.Controls

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Cogen")

    property int defMargin: window.width/200
    property string colorMenuBg: "#404040"

    Rectangle{
        anchors.fill: parent
        color: "black"
    }

    RowLayout{
        id: layoutRowMain
        anchors.fill: parent

        ColumnLayout{
            id: columnLayoutLeft
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: defMargin
            anchors.topMargin: defMargin
            anchors.bottomMargin: defMargin
            width: window.width/10


            Rectangle{
                id: rectangleLeftMenuCliper
                color: 'transparent'
                anchors.fill: parent
                clip: true

                Rectangle{
                    id: rectangleLeftMenuRounded
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: rectangleLeftMenuCliper.width + radius
                    color: colorMenuBg
                    radius: defMargin*2
                }

                Rectangle{
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    height: parent.height/10
                    color: "red"

                }
            }
        }

        ColumnLayout{
            id: columnLayoutRight
            anchors.left: columnLayoutLeft.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            RowLayout{
                id: rowLayoutTopMenu
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: window.height/6
                anchors.topMargin: defMargin
                anchors.leftMargin: defMargin
                anchors.rightMargin: defMargin

                Rectangle{
                    id: rectangleTopMenuContent
                    anchors.fill: parent
                    color: colorMenuBg
                    radius: defMargin*2
                }

            }

            Rectangle{
                id: rectangleMainPlace
                anchors.top: rowLayoutTopMenu.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: defMargin
                color: 'transparent'

                Rectangle{
                    id: rectangleMainContent
                    anchors.fill: parent
                    color: colorMenuBg
                    radius: defMargin*2
                }

            }



        }

    }



//    InputPanel {
//        id: inputPanel
//        z: 99
//        x: 0
//        y: window.height
//        width: window.width

//        states: State {
//            name: "visible"
//            when: inputPanel.active
//            PropertyChanges {
//                target: inputPanel
//                y: window.height - inputPanel.height
//            }
//        }
//        transitions: Transition {
//            from: ""
//            to: "visible"
//            reversible: true
//            ParallelAnimation {
//                NumberAnimation {
//                    properties: "y"
//                    duration: 250
//                    easing.type: Easing.InOutQuad
//                }
//            }
//        }
//    }
}
