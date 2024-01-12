import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtCharts

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: "Cogen"

    readonly property int defMargin: window.width/200
    readonly property string colorMenuBg: "#404040"
    readonly property string colorText: "#d4d4d4"
    readonly property string colorAir: "#2563eb"
    readonly property string colorProduct: "#e11d48"
    readonly property string colorROR: "#ca8a04"

    readonly property real minDrunSpeed: 1
    readonly property real maxDrunSpeed: 100

    property bool btnSt: false

    property int chartStartHours: 0
    Component.onCompleted:
        if(Qt.platform.os === "windows"){
            chartStartHours = 1
        }

    // Fire PopUp component creation
    property var popUpFire: null
    function showPopUpFire(){
        destroyPopUpDrumSpeed()
        destroyPopUpFanSpeed()
        if(popUpFire == null){
            popUpFire = Qt.createComponent("PopUpPlusMinus.qml").createObject(itemTopMenu4, {"x":0, "y":0})
            if(popUpFire != null){
                popUpFire.anchors.top = itemTopMenu4.bottom
                popUpFire.anchors.horizontalCenter = itemTopMenu4.horizontalCenter
                popUpFire.color = colorText
                popUpFire.radius = defMargin*2
                popUpFire.width = itemRight.width/4
                popUpFire.height = itemTopMenu.height
                popUpFire.minusClicked.connect(()=>{
                    if(appmanager.gazPreset>1) appmanager.onSetFireLevel(appmanager.gazPreset-1)
                                               })
                popUpFire.plusClicked.connect(()=>{
                    if(appmanager.gazPreset<9) appmanager.onSetFireLevel(appmanager.gazPreset+1)
                                               })
                popUpFire.close.connect(destroyPopUpFire)
            }
        }
    }
    function destroyPopUpFire(){
        if(popUpFire !== null){
            popUpFire.destroy()
            popUpFire = null
        }
    }

    // Drum Speed PopUp component creation
    property var popUpDrumSpeed: null
    function showPopUpDrumSpeed(){
        destroyPopUpFire()
        destroyPopUpFanSpeed()
        if(popUpDrumSpeed == null){
            popUpDrumSpeed = Qt.createComponent("PopUpPlusMinus10.qml").createObject(itemTopMenu5, {"x":0, "y":0})
            if(popUpDrumSpeed != null){
                popUpDrumSpeed.anchors.top = itemTopMenu5.bottom
                popUpDrumSpeed.anchors.horizontalCenter = itemTopMenu5.horizontalCenter
                popUpDrumSpeed.color = colorText
                popUpDrumSpeed.radius = defMargin*2
                popUpDrumSpeed.width = itemRight.width/4
                popUpDrumSpeed.height = itemTopMenu.height*2
                popUpDrumSpeed.minusClicked.connect(()=>{
                    if(appmanager.drumSP>minDrunSpeed) appmanager.onSetDrumSpeed(appmanager.drumSP-1)
                                               })
                popUpDrumSpeed.plusClicked.connect(()=>{
                    if(appmanager.drumSP<maxDrunSpeed) appmanager.onSetDrumSpeed(appmanager.drumSP+1)
                                               })
                popUpDrumSpeed.minus10Clicked.connect(()=>{
                    if(appmanager.drumSP>minDrunSpeed+10) appmanager.onSetDrumSpeed(appmanager.drumSP-10)
                    else appmanager.onSetDrumSpeed(minDrunSpeed)
                                               })
                popUpDrumSpeed.plus10Clicked.connect(()=>{
                    if(appmanager.drumSP<maxDrunSpeed-10) appmanager.onSetDrumSpeed(appmanager.drumSP+10)
                    else appmanager.onSetDrumSpeed(maxDrunSpeed)
                                               })
                popUpDrumSpeed.close.connect(destroyPopUpDrumSpeed)
            }
        }
    }
    function destroyPopUpDrumSpeed(){
        if(popUpDrumSpeed !== null){
            popUpDrumSpeed.destroy()
            popUpDrumSpeed = null
        }
    }

    // Fan Speed PopUp component creation
    property var popUpFanSpeed: null
    function showPopUpFanSpeed(){
        destroyPopUpFire()
        destroyPopUpDrumSpeed()
        if(popUpFanSpeed == null){
            popUpFanSpeed = Qt.createComponent("PopUpPlusMinus10.qml").createObject(itemTopMenu6, {"x":0, "y":0})
            if(popUpFanSpeed != null){
                popUpFanSpeed.anchors.top = itemTopMenu6.bottom
                popUpFanSpeed.anchors.right = itemTopMenu6.right
                popUpFanSpeed.color = colorText
                popUpFanSpeed.radius = defMargin*2
                popUpFanSpeed.width = itemRight.width/4
                popUpFanSpeed.height = itemTopMenu.height*2
                popUpFanSpeed.minusClicked.connect(()=>{
                    if(appmanager.fanSP>minDrunSpeed) appmanager.onSetFanSpeed(appmanager.fanSP-1)
                                               })
                popUpFanSpeed.plusClicked.connect(()=>{
                    if(appmanager.fanSP<maxDrunSpeed) appmanager.onSetFanSpeed(appmanager.fanSP+1)
                                               })
                popUpFanSpeed.minus10Clicked.connect(()=>{
                    if(appmanager.fanSP>minDrunSpeed+10) appmanager.onSetFanSpeed(appmanager.fanSP-10)
                    else appmanager.onSetFanSpeed(minDrunSpeed)
                                               })
                popUpFanSpeed.plus10Clicked.connect(()=>{
                    if(appmanager.fanSP<maxDrunSpeed-10) appmanager.onSetFanSpeed(appmanager.fanSP+10)
                    else appmanager.onSetFanSpeed(maxDrunSpeed)
                                               })
                popUpFanSpeed.close.connect(destroyPopUpFanSpeed)
            }
        }
    }
    function destroyPopUpFanSpeed(){
        if(popUpFanSpeed !== null){
            popUpFanSpeed.destroy()
            popUpFanSpeed = null
        }
    }

    // Settings Page
    property var pageSettings: null
    function showPageSettings(){
        if(pageSettings == null){
            pageSettings = Qt.createComponent("PageSettings.qml").createObject(rectangleMainContent)
        }
    }
    function destroyPageSettings(){
        if(pageSettings !== null){
            pageSettings.destroy()
            pageSettings = null
        }
    }

    //Background
    Rectangle{
        anchors.fill: parent
        color: "black"
    }

    //Background RED for alarm state display
    Rectangle{
        id: backgroundAlarm
        anchors.fill: parent
        color: "red"
        opacity: 0
        SequentialAnimation{
            running: appmanager.alarmState
            loops: Animation.Infinite
            OpacityAnimator{
                target: backgroundAlarm
                from: 0
                to: 1
                duration: 1000
            }
            OpacityAnimator{
                target: backgroundAlarm
                from: 1
                to: 0
                duration: 1000
            }
        }
    }

    MouseArea{
        id: content
        width: window.width
        height: window.height
        onClicked: focus = true

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
                        sourceSize.width: width
                        sourceSize.height: height
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
    //                        chartXAxis.max = new Date(1970, 0, 1, chartStartHours, 1, 0, 0) // 01:00
                        }
                        onStoped: {
                            appmanager.stopTrendlog()
                            stopwatchCrack.stopTimer()
                        }
    //                    onTrig59s: {
    //                        var x = Math.round(chartView.series("temperatureSmoke").count / 60) + 1
    //                        chartXAxis.max = new Date(1970, 0, 1, chartStartHours, x, 0, 0)
    //                    }
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
                        image2Source: "img/stop.svg"
                        buttonText: "START"
                        button2Text: "STOP"
                        onClicked: {
                            stopwatchMain.isRunning?stopwatchMain.stopTimer():stopwatchMain.startTimer()

                        }
                        st2: stopwatchMain.isRunning
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
    //                    st: stopwatchCrack.isRunning
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
                    Rectangle{
                        anchors.fill: parent
                        color: "dimgray"
                        visible: mouseAreaSettinsButton.pressed
                    }

                    Image {
                        source: "img/gear.svg"
                        anchors.fill: parent
                        anchors.margins: height/5
                        sourceSize.width: parent.width
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea{
                        id: mouseAreaSettinsButton
                        anchors.fill: parent
                        onClicked: {
                            console.log("Button SETTINGS clicked")
                            if(pageSettings == null)    showPageSettings()
                            else    destroyPageSettings()
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
                z:2
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
    //                        halfDivided: true
                        }
                    }
                    Item{
                        id: itemTopMenu4
                        height: parent.height
                        width: parent.width/6
                        anchors.top: parent.top
                        anchors.left: itemTopMenu3.right
                        anchors.bottom: parent.bottom

                        Rectangle{
                            anchors.fill: parent
                            color:"dimgray"
                            visible: mouseAreaTopMenu4.pressed
                        }

                        TopMenuItem1Lines {
                            txtCol:  "#16a34a"
                            text1: appmanager.gazPreset
                            img: "img/fire.svg"
                            imgVerticalMargins: parent.height/5
    //                        halfDivided: true
                        }
                        MouseArea{
                            id: mouseAreaTopMenu4
                            anchors.fill: parent
                            onClicked: {
                                if(popUpFire !== null) window.destroyPopUpFire()
                                else window.showPopUpFire()
                                focus = true
                            }
                        }

                    }

                    Item{
                        id: itemTopMenu5
                        height: parent.height
                        width: parent.width/6
                        anchors.top: parent.top
                        anchors.left: itemTopMenu4.right
                        anchors.bottom: parent.bottom
                        Rectangle{
                            anchors.fill: parent
                            color:"dimgray"
                            visible: mouseAreaTopMenu5.pressed
                        }
                        TopMenuItem2Lines {
                            txtCol:  "#ea580c"
                            text1: Math.round(appmanager.drumSP)
                            text2: "rpm"
                            img: "img/drum.svg"
                        }
                        MouseArea{
                            id: mouseAreaTopMenu5
                            anchors.fill: parent
                            onClicked: {
                                if(popUpDrumSpeed !== null) window.destroyPopUpDrumSpeed()
                                else window.showPopUpDrumSpeed()
                                focus = true
                            }
                        }
                    }

                    Item{
                        id: itemTopMenu6
                        height: parent.height
                        width: parent.width/6
                        anchors.top: parent.top
                        anchors.left: itemTopMenu5.right
                        anchors.bottom: parent.bottom
                        Item{
                            anchors.fill: parent
                            visible: mouseAreaTopMenu6.pressed
                            clip: true
                            Rectangle{
                                anchors.right: parent.right
                                anchors.top: parent.top
                                width: parent.width + defMargin*2
                                height: parent.height
                                color:"dimgray"
                                radius: defMargin*2
                            }
                        }
                        TopMenuItem2Lines {
                            txtCol:  "#9333ea"
                            text1: Math.round(appmanager.fanSP)+"%"
                            text2: Math.round(appmanager.dP)+"Pa"
                            img: "img/fan.svg"
                        }
                        MouseArea{
                            id: mouseAreaTopMenu6
                            anchors.fill: parent
                            onClicked: {
                                if(popUpFanSpeed !== null) window.destroyPopUpFanSpeed()
                                else window.showPopUpFanSpeed()
                                focus = true
                            }
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
                z:1
                Rectangle{
                    id: rectangleMainContent
                    anchors.fill: parent
                    color: colorMenuBg
                    radius: defMargin*2

                    Item {
                        anchors.fill: parent
                        z:2

                        ChartView {
                            id: chartView
                            anchors.fill: parent
                            antialiasing: true
                            backgroundColor: "transparent"
                            legend.visible: false

                            DateTimeAxis {
                               id: chartXAxis
                               min: new Date(1970, 0, 1, chartStartHours, 0, 0, 0) // 00:00
    //                           max: new Date(1970, 0, 1, chartStartHours, 1, 0, 0) // 01:00
                               max: new Date(1970, 0, 1, chartStartHours, 20, 0, 0) // 01:00
                               format: "mm:ss"
                               tickCount: 5
                               labelsColor: colorText
                               gridVisible: true
                               lineVisible: true
                            }


                            ValueAxis {
                                id: chartYAxis
                                min: 0
                                max: 300
                                labelsColor: colorText
                                tickCount: 7
                                minorTickCount: 4
                            }
                            ValueAxis {
                                id: chartYAxisROR
                                min: 0
                                max: 30
                                labelsColor: colorROR
                                tickCount: 7
                            }

                            SplineSeries {
                                id: cahrtTempSmoke
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
    }

    InputPanel{
        id: inputPanel
        z: 100
        y: yPositionWhenHidden
        x: 0
        width: parent.width

        property real yPositionWhenHidden: window.height
        property real yPositionOfFocusedElement: 0
        property real heightOfFocusedElement: 0

        states: State {
                name: "visible"
                when: inputPanel.active
                PropertyChanges {
                    target: inputPanel
                    y: inputPanel.yPositionWhenHidden - inputPanel.height
                }
                PropertyChanges {
                    target: content
                    y: inputPanel.yPositionOfFocusedElement + inputPanel.heightOfFocusedElement+10 < window.height - inputPanel.height ?
                           0
                         :
                           -(inputPanel.height - (window.height - inputPanel.yPositionOfFocusedElement) + inputPanel.heightOfFocusedElement+10)
                }
                StateChangeScript{
                    script:{
                        inputPanel.yPositionOfFocusedElement = window.activeFocusItem.mapToItem(window, 0, 0).y
                        inputPanel.heightOfFocusedElement = window.activeFocusItem.height
                    }
                }
            }

        transitions: Transition {
            id: inputPanelTransition
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
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
        DropShadow {
            anchors.fill: rectanglePopUpConnectionError
            source: rectanglePopUpConnectionError
            horizontalOffset: rectanglePopUpConnectionError.width/30
            verticalOffset: rectanglePopUpConnectionError.width/30
            radius: 8.0
            samples: 17
            color: "#aa000000"
        }

    }

}
