import QtQuick
import QtQuick.Window
import QtQuick.Layouts
//import QtQuick.VirtualKeyboard
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtCharts

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Cogen")

    readonly property int defMargin: window.width/200
    readonly property string colorMenuBg: "#404040"
    readonly property string colorText: "#d4d4d4"
    readonly property string colorAir: "#2563eb"
    readonly property string colorProduct: "#e11d48"
    readonly property string colorROR: "#ca8a04"

    property bool btnSt: false
    //Background
    Rectangle{
        anchors.fill: parent
        color: "black"
    }

    Item{
        id: itemLeft
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

                Stopwatch{
                    id: stopwatchMain
                    textColor: colorText
                    onStarted: {
                        appmanager.startTrendlog(chartView.series("temperatureSmoke"),
                                                 chartView.series("temperatureProduct"),
                                                 chartView.series("temperatureROR"))
                        stopwatchCrack.resetTimer()
                    }
                    onStoped: {
                        appmanager.stopTrendlog()
                        stopwatchCrack.stopTimer()
                    }
                    onTrig59s: {
                        var x = Math.round(chartView.series("temperatureSmoke").count / 60) + 1
                        chartXAxis.max = new Date(1970, 0, 1, 1, x, 0, 0)
                    }
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
                    Stopwatch{
                        id: stopwatchCrack
                        textColor: colorText
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
                        stopwatchMain.isRunning?stopwatchMain.stopTimer():stopwatchMain.startTimer()

                    }
                    st: stopwatchMain.isRunning
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
                        if(stopwatchMain.isRunning){
                            stopwatchCrack.startTimer()
                        }
                    }
                    st: stopwatchCrack.isRunning
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
                        appmanager.onClickButtonDrum()
                    }
                    st: appmanager.buttonDrum
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
                        appmanager.onClickButtonFire()
                    }
                    st: appmanager.buttonFire
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
                        appmanager.onClickButtonMixer()
                    }
                    st: appmanager.buttonMixer
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
                        appmanager.onClickButtonCooler()
                    }
                    st: appmanager.buttonCooler
                }

            }
            // space between buttons
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

    Item{
        id: itemRight
        anchors.left: itemLeft.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        Item{
            id: itemTopMenu
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
                Item{
                    id: itemTopMenu1
                    height: parent.height
                    width: parent.width/6
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    TopMenuItem2Lines {
                        txtCol:  colorAir
//                        text1: appmanager.temperatureSmoke.toFixed(0)+"°C"
                        text1: Math.round(appmanager.temperatureSmoke)+"°C"
                        text2: "AIR"
                        img: "img/air.svg"
                    }
                }
                Item{
                    id: itemTopMenu2
                    height: parent.height
                    width: parent.width/6
                    anchors.top: parent.top
                    anchors.left: itemTopMenu1.right
                    anchors.bottom: parent.bottom
                    TopMenuItem2Lines {
                        txtCol:  colorProduct
                        text1: Math.round(appmanager.temperatureProduct)+"°C"
                        text2: "BEANS"
                        img: "img/Coffee_Bean.svg"
                    }
                }
                Item{
                    id: itemTopMenu3
                    height: parent.height
                    width: parent.width/6
                    anchors.top: parent.top
                    anchors.left: itemTopMenu2.right
                    anchors.bottom: parent.bottom
                    TopMenuItem1Lines {
                        txtCol:  colorROR
                        text1: appmanager.temperatureROR.toFixed(1)+"°C"
                        imgText: "RoR"
                    }
                }
                Item{
                    id: itemTopMenu4
                    height: parent.height
                    width: parent.width/6
                    anchors.top: parent.top
                    anchors.left: itemTopMenu3.right
                    anchors.bottom: parent.bottom
                    TopMenuItem1Lines {
                        txtCol:  "#16a34a"
                        text1: appmanager.gazPreset
                        img: "img/fire.svg"
                    }
                }
                Item{
                    id: itemTopMenu5
                    height: parent.height
                    width: parent.width/6
                    anchors.top: parent.top
                    anchors.left: itemTopMenu4.right
                    anchors.bottom: parent.bottom
                    TopMenuItem2Lines {
                        txtCol:  "#ea580c"
                        text1: Math.round(appmanager.drumSP)
                        text2: "rpm"
                        img: "img/drum.svg"
                    }
                }
                Item{
                    id: itemTopMenu6
                    height: parent.height
                    width: parent.width/6
                    anchors.top: parent.top
                    anchors.left: itemTopMenu5.right
                    anchors.bottom: parent.bottom
                    TopMenuItem2Lines {
                        txtCol:  "#9333ea"
                        text1: Math.round(appmanager.fanSP)+"%"
                        text2: Math.round(appmanager.dP)+"Pa"
                        img: "img/fan.svg"
                    }
                }
            }

        }

        Item{
            id: itemMainPlace
            anchors.top: itemTopMenu.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: defMargin

            Rectangle{
                id: rectangleMainContent
                anchors.fill: parent
                color: colorMenuBg
                radius: defMargin*2

                Item {
                    anchors.fill: parent


                    ChartView {
                        id: chartView
                        anchors.fill: parent
                        antialiasing: true
                        backgroundColor: "transparent"
                        legend.visible: false

                        DateTimeAxis {
                           id: chartXAxis
                           min: new Date(1970, 0, 1, 1, 0, 0, 0) // 00:00
                           max: new Date(1970, 0, 1, 1, 1, 0, 0) // 01:00
                           format: "mm:ss"
                           tickCount: 7
                           labelsColor: colorText
                           gridVisible: true
                           lineVisible: true
                        }


                        ValueAxis {
                            id: chartYAxis
                            min: 0
                            max: 300
                            labelsColor: colorText
                        }
                        ValueAxis {
                            id: chartYAxisROR
                            min: 0
                            max: 20
                            labelsColor: colorText
                        }

                        SplineSeries {
                            name: "temperatureSmoke"
                            axisY: chartYAxis
                            axisX: chartXAxis
                            color: colorAir
                            width: 3
                        }

                        SplineSeries {
                            name: "temperatureProduct"
                            axisY: chartYAxis
                            axisX: chartXAxis
                            color: colorProduct
                            width: 3
                        }

                        SplineSeries {
                            name: "temperatureROR"
                            axisYRight: chartYAxisROR
                            axisX: chartXAxis
                            color: colorROR
                            width: 3
                        }
                    }

                }

            }

        }



    }

    //PopUp Modbus connection error
    Item{
        id: itemPopUpConnectionError
        anchors.fill: parent
        visible: !appmanager.isModbusConnected

        Rectangle{
            id: rectanglePopUpConnectionError
            anchors.centerIn: parent
            width: window.width/3
            height: window.height/4
            color: colorText
            border.color: "red"
            border.width: 2
            radius: defMargin*2
            Item{
                anchors.fill: parent
                anchors.margins: defMargin*2
                TextFit{
                    txt: "Connection error!"
                    col: "red"
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
