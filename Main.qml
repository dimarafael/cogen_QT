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

    property bool btnSt: false
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
                }

                Item{
                    id: itemCrackTimer
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemTimer.bottom
                    anchors.margins: width/20
                    anchors.topMargin: - height/5
                    height: parent.height/10

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

                Item{
                    id: itemStartButton
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemCrackTimer.bottom
                    height: parent.height/10

                    MenuButton {
                        textColor: colorText
                        imageSource: "img/play.svg"
                        buttonText: "START"
                        onClicked: {
                            console.log("Button START clicked")
                            btnSt = ! btnSt
                        }
                        st: btnSt
                    }

                }
                Item{
                    id: itemCrackButton
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemStartButton.bottom
                    anchors.topMargin: -2
                    height: parent.height/10

                    MenuButton {
                        textColor: colorText
                        imageSource: "img/Coffee_Bean.svg"
                        buttonText: "CRACK"
                        onClicked: {
                            console.log("Button CRACK clicked")
                        }
                        st: false
                    }

                }
                Item {
                    id: itemCrackButtonToDrumButton
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemCrackButton.bottom
                    height: parent.height/100
                }
                Item{
                    id: itemDrumButton
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemCrackButtonToDrumButton.bottom
                    height: parent.height/10

                    MenuButton {
                        textColor: colorText
                        imageSource: "img/drum.svg"
                        buttonText: "DRUM"
                        onClicked: {
                            console.log("Button DRUM clicked")
                        }
                        st: false
                    }

                }
                Item{
                    id: itemFireButton
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemDrumButton.bottom
                    height: parent.height/10
                    anchors.topMargin: -2

                    MenuButton {
                        textColor: colorText
                        imageSource: "img/fire.svg"
                        buttonText: "FIRE"
                        onClicked: {
                            console.log("Button FIRE clicked")
                        }
                        st: false
                    }

                }
                Item{
                    id: itemMixerButton
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemFireButton.bottom
                    height: parent.height/10
                    anchors.topMargin: -2

                    MenuButton {
                        textColor: colorText
                        imageSource: "img/mixer.svg"
                        buttonText: "MIXER"
                        onClicked: {
                            console.log("Button MIXER clicked")
                        }
                        st: false
                    }

                }
                Item{
                    id: itemCoolerButton
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemMixerButton.bottom
                    height: parent.height/10
                    anchors.topMargin: -2

                    MenuButton {
                        textColor: colorText
                        imageSource: "img/cooler.svg"
                        buttonText: "COOLER"
                        onClicked: {
                            console.log("Button COOLER clicked")
                        }
                        st: false
                    }

                }
                Item {
                    id: itemCoolerButtonToSettings
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemCoolerButton.bottom
                    height: parent.height/100
                }
                Item{
                    id: itemSettingsButton
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: itemCoolerButtonToSettings.bottom
                    height: parent.height/10

                    Image {
                        source: "img/gear.svg"
                        anchors.fill: parent
                        anchors.margins: height/5
                        sourceSize.width: parent.width
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.log("Button SETTINGS clicked")
                        }
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
