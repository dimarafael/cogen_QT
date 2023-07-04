import QtQuick
import QtQuick.Window
import QtQuick.Layouts
//import QtQuick.VirtualKeyboard
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Cogen")

    property int defMargin: window.width/200
    property string colorMenuBg: "#404040"
    property string colorText: "#d4d4d4"

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

                Item{
                    id: itemLogo
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: width/20
                    anchors.topMargin: height/2
                    height: parent.height/20

                    Image {
                        id: imageLogo
                        source: "img/logo.svg"
                        anchors.fill: parent
                        sourceSize.width: parent.width
                        fillMode: Image.PreserveAspectFit
                    }


//                    Rectangle{
//                        anchors.fill: parent
//                        border.color: "blue"
//                        border.width: 1
//                        color: 'transparent'
//                    }
                }

                Item{
                    id: itemTimer
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemLogo.bottom
                    anchors.margins: width/20
                    height: parent.height/10

                    TextFit {
                        txt: "00:00"
                        col: colorText
                    }

//                    Rectangle{
//                        anchors.fill: parent
//                        border.color: "red"
//                        border.width: 1
//                        color: 'transparent'
//                    }
                }

                Item{
                    id: itemCrackTimer
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemTimer.bottom
                    anchors.margins: width/20
                    anchors.topMargin: - height/5
                    height: parent.height/10

                    Rectangle{
                        anchors.fill: parent
                        border.color: "green"
                        border.width: 1
                        color: 'transparent'

                        Image {
                            id: imageCrackTimer
                            source: "img/Coffee_Bean.svg"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            width: parent.width/4
                            sourceSize.width: parent.width
                            fillMode: Image.PreserveAspectFit
                        }
                        Item{
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: imageCrackTimer.right
                            anchors.right: parent.right
                            anchors.leftMargin: width/10
                            TextFit {
                                txt: "00:00"
                                col: colorText
                            }
                        }



                    }


                    Rectangle{
                        anchors.fill: parent
                        border.color: "green"
                        border.width: 1
                        color: 'transparent'
                    }
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
