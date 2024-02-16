import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.VirtualKeyboard


Item {
    id: itemPageSettings

    property bool passwordPopUpVisivble: false

    anchors.fill: parent
    z: 3
    MouseArea{
    anchors.fill: parent
    onClicked: focus = true

        Rectangle{
        id: pageSettingsRect
        anchors.fill: parent
        radius: defMargin*2
        color: colorMenuBg
        anchors.margins: defMargin*2

            Image {
                id: imageButtonGazSetup
                source: "img/wrench.svg"
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: height/10
                height: parent.height / 15
                width: height

                fillMode: Image.PreserveAspectFit
                sourceSize.width: width
                sourceSize.height: height

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        itemPageSettings.passwordPopUpVisivble = true
                    }
                }

            }

            Item { // alarm list
                id: itemAlarmList
                anchors.left: parent.left
                anchors.top: parent.top
                height: parent.height/3
                width: parent.width*0.7

                AlarmList {
                    id: alarmList
                    anchors.fill: parent
                }
            }

            Item { // acknowledge button
                id: itemCheck
                anchors.right: parent.right
                anchors.top: parent.top
                height: itemAlarmList.height
                width: parent.width * 0.3

                Rectangle{
                    id: checkBackground
                    anchors.fill: parent
                    anchors.margins: defMargin*2
                    color: "dimgray"
                    visible: checkMouseArea.pressed
                }

                Image {
                    id: imageCheck
                    anchors.fill: parent
                    anchors.margins: height * 0.25
                    source: "img/check.svg"
                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: width
                    sourceSize.height: height
                }

                MouseArea{
                    id: checkMouseArea
                    anchors.fill: parent
                    onClicked: {
                        appmanager.onClickAck()
                    }
                }
            }

            Item{
                id: itemBottom
                anchors.left: parent.left
                anchors.top: itemAlarmList.bottom
                width: parent.width
                height: parent.height - itemAlarmList.height

                Item{ // left side
                    id: itemParametersLeftSide
                    width: parent.width/2
                    anchors{
                        top: parent.top
                        left: parent.left
                        bottom: parent.bottom
                    }
                    Item {
                        id: itemParameter1
                        width: parent.width
                        height: parent.height/2
                        anchors.top: parent.top
                        anchors.left: parent.left

                        Label{
                            id: labelParameter1
                            color: "#ffffff"
                            text: "Overheat temperature"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: setpointField1.top
                            anchors.bottomMargin: font.pixelSize / 3
                            font.pixelSize: itemBottom.height / 14
                        }

                        SetpointField {
                            id: setpointField1
                            width: parent.width / 2
                            height: itemBottom.height / 7
                            anchors.centerIn: parent

                            minVal: 0
                            maxVal: 999
                            units: "°C"

                            value: appmanager.temperatureOverheatSP
                            onSetValue: (value) => appmanager.onSetTemperatureOverheat(value)
                        }
                    }

                    Item {
                        id: itemParameter2
                        width: parent.width
                        height: parent.height/2
                        anchors.top: itemParameter1.bottom
                        anchors.left: parent.left

                        Label{
                            id: labelParameter2
                            color: "#ffffff"
                            text: "Cooller speed"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: setpointField2.top
                            anchors.bottomMargin: font.pixelSize / 3
                            font.pixelSize: itemBottom.height / 14
                        }

                        SetpointField {
                            id: setpointField2
                            width: parent.width / 2
                            height: itemBottom.height / 7
                            anchors.centerIn: parent

                            minVal: 0
                            maxVal: 100
                            units: "%"

                            value: appmanager.coollerSpeed
                            onSetValue: (value) => appmanager.onSetCoollerSpeed(value)
                        }
                    }


                }

                Item{ // right side
                    id: itemParametersRightSide
                    width: parent.width/2
                    anchors{
                        top: parent.top
                        right: parent.right
                        bottom: parent.bottom
                    }

                    Item {
                        id: itemParameter3
                        width: parent.width
                        height: parent.height/2
                        anchors.top: parent.top
                        anchors.left: parent.left

                        Label{
                            id: labelParameter3
                            color: "#ffffff"
                            text: "Minimal exhaustion pressure"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: setpointField3.top
                            anchors.bottomMargin: font.pixelSize / 3
                            font.pixelSize: itemBottom.height / 14
                        }

                        SetpointField {
                            id: setpointField3
                            width: parent.width / 2
                            height: itemBottom.height / 7
                            anchors.centerIn: parent

                            minVal: 0
                            maxVal: 999
                            units: "Pa"

                            value: appmanager.dPminSP
                            onSetValue: (value) => appmanager.onDPminSP(value)
                        }
                    }

                    Item {
                        id: itemParameter4
                        width: parent.width
                        height: parent.height/2
                        anchors.top: itemParameter3.bottom
                        anchors.left: parent.left

                        Column{
                            anchors.fill: parent
                            anchors.leftMargin: defMargin*2
                            spacing: itemBottom.height / 14
                            Label{
                                id: labelParameter4_1
                                color: "#ffffff"
                                text: "Temperature in<BR>electric cabinet = " + appmanager.temperatureBox.toFixed(1) + " °C"
                                anchors.left: parent.left
                                font.pixelSize: itemBottom.height / 14
                            }
                            Label{
                                id: labelParameter4_2
                                color: "#ffffff"
                                text: "Working time " + appmanager.workTime + " h"
                                anchors.left: parent.left
                                font.pixelSize: itemBottom.height / 14
                            }
                        }

                    }

                }




            }

        }

        /// blur background for password popup
        FastBlur {
            anchors.fill: pageSettingsRect
            source: pageSettingsRect
            radius: 16
            visible: itemPageSettings.passwordPopUpVisivble

            MouseArea{
                anchors.fill: parent
                onClicked:{
                    focus = true
                    itemPageSettings.passwordPopUpVisivble = false
                }
            }
        }

        DropShadow {
            anchors.fill: rectanglePasswordPopUp
            source: rectanglePasswordPopUp
            horizontalOffset: rectanglePasswordPopUp.width/50
            verticalOffset: rectanglePasswordPopUp.width/50
            radius: 8.0
            samples: 17
            color: "#aa000000"
            visible: itemPageSettings.passwordPopUpVisivble
        }

        Rectangle{
            id: rectanglePasswordPopUp
            x: Math.round((parent.width - width) / 2)
            y: Math.round((parent.height - height) / 2)
            height: parent.height / 2
            width: parent.width / 2
            color: "#404040"
            border.color: "gray"
            border.width: 2
            radius: defMargin*2

            visible: itemPageSettings.passwordPopUpVisivble

            onVisibleChanged:{
                textFieldPassword.text = ""
                labelWronPassword.visible = false
            }

            function pressOk(){
                if (textFieldPassword.text === "123"){
                    itemPageSettings.passwordPopUpVisivble = false
                    pageSettingsGazRect.visible = true
                } else {
                    labelWronPassword.visible = true
                }
            }

            MouseArea{
                anchors.fill: parent
                onClicked: focus = true
            }

            Item{
                anchors.fill: parent

                Label{
                    width: parent.width
                    anchors.top: parent.top
                    anchors.topMargin: parent.height / 10
                    horizontalAlignment: Text.AlignHCenter
                    text: "Enter access code"
                    color: "#d4d4d4"
                    font.pixelSize: rectanglePasswordPopUp.height / 9
                }

                Label{
                    id: labelWronPassword
                    anchors.bottom: textFieldPassword.top
                    anchors.bottomMargin: height/5
                    visible: false
                    text: "Wrong code!!!"
                    color: "red"
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: rectanglePasswordPopUp.height / 10
                }

                TextField{
                    id: textFieldPassword
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width * 0.7
                    height: rectanglePasswordPopUp.height / 5
                    inputMethodHints: Qt.ImhDigitsOnly
                    font.pixelSize: height*0.7
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    echoMode: TextInput.Password
                    onAccepted: rectanglePasswordPopUp.pressOk()
                }

                Row{
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height / 10
                    width: parent.width
                    spacing: (width - btnCancel.width*2)/3
                    leftPadding: spacing
                    Button{
                        id: btnCancel
                        text: "CANCEL"
                        font.pixelSize: height*0.5
                        width: rectanglePasswordPopUp.width / 3
                        height: rectanglePasswordPopUp.height / 5
                        onClicked: {
                            itemPageSettings.passwordPopUpVisivble = false
                            textFieldPassword.text = ""
                        }

                    }
                    Button{
                        id: btnOk
                        text: "OK"
                        font.pixelSize: height*0.5
                        width: rectanglePasswordPopUp.width / 3
                        height: rectanglePasswordPopUp.height / 5
                        onClicked: rectanglePasswordPopUp.pressOk()
                    }
                }

            }


        }


        /// Hidden settings for gaz valve
        Rectangle{
            id: pageSettingsGazRect
            anchors.fill: parent
            radius: defMargin*2
            color: colorMenuBg
            anchors.margins: defMargin*2
            visible: false

            onVisibleChanged: {
                if(visible === true) mouseAreaGazSettings.focus = true
            }

            MouseArea{
                id: mouseAreaGazSettings
                anchors.fill: parent
                onClicked: focus = true

                Item{
                    id: itemGazSettingsTop
                    width: parent.width
                    height: parent.height / 6

                    Label{
                        text: "Start value"
                        anchors.right: setpointFieldGazStart.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: parent.height * 0.3
                        font.pixelSize: parent.height * 0.3
                        color: "#d4d4d4"
                    }
                    SetpointField {
                        id: setpointFieldGazStart
                        width: parent.width / 4
                        height: parent.height * 0.6
                        anchors.centerIn: parent

                        minVal: 0
                        maxVal: 100
                        units: "%"

                        value: appmanager.gazStartLevel
                        onSetValue: (value) => appmanager.onSetGazStartLevel(value)
                    }

                    Button{
                        text: "X"
                        anchors.right: parent.right
                        anchors.top: parent.top
                        height: parent.height / 2
                        width: height
                        font.pixelSize: height * 0.8
                        onClicked: pageSettingsGazRect.visible = false
                    }
                }
                Grid{
                    anchors.top: itemGazSettingsTop.bottom
                    columns: 2

                    SetpointLabelLeft {
                        label: "Value 1"
                        width: pageSettingsGazRect.width / 2
                        height: pageSettingsGazRect.height / 6
                        value: appmanager.gazConfig[0]
                        onSetValue: (value) => appmanager.onSetGazConfig(0, value)
                    }

                    SetpointLabelLeft {
                        label: "Value 6"
                        width: pageSettingsGazRect.width / 2
                        height: pageSettingsGazRect.height / 6
                        value: appmanager.gazConfig[5]
                        onSetValue: (value) => appmanager.onSetGazConfig(5, value)
                    }

                    SetpointLabelLeft {
                        label: "Value 2"
                        width: pageSettingsGazRect.width / 2
                        height: pageSettingsGazRect.height / 6
                        value: appmanager.gazConfig[1]
                        onSetValue: (value) => appmanager.onSetGazConfig(1, value)
                    }

                    SetpointLabelLeft {
                        label: "Value 7"
                        width: pageSettingsGazRect.width / 2
                        height: pageSettingsGazRect.height / 6
                        value: appmanager.gazConfig[6]
                        onSetValue: (value) => appmanager.onSetGazConfig(6, value)
                    }

                    SetpointLabelLeft {
                        label: "Value 3"
                        width: pageSettingsGazRect.width / 2
                        height: pageSettingsGazRect.height / 6
                        value: appmanager.gazConfig[2]
                        onSetValue: (value) => appmanager.onSetGazConfig(2, value)
                    }

                    SetpointLabelLeft {
                        label: "Value 8"
                        width: pageSettingsGazRect.width / 2
                        height: pageSettingsGazRect.height / 6
                        value: appmanager.gazConfig[7]
                        onSetValue: (value) => appmanager.onSetGazConfig(7, value)
                    }

                    SetpointLabelLeft {
                        label: "Value 4"
                        width: pageSettingsGazRect.width / 2
                        height: pageSettingsGazRect.height / 6
                        value: appmanager.gazConfig[3]
                        onSetValue: (value) => appmanager.onSetGazConfig(3, value)
                    }

                    SetpointLabelLeft {
                        label: "Value 9"
                        width: pageSettingsGazRect.width / 2
                        height: pageSettingsGazRect.height / 6
                        value: appmanager.gazConfig[8]
                        onSetValue: (value) => appmanager.onSetGazConfig(8, value)
                    }

                    SetpointLabelLeft {
                        label: "Value 5"
                        width: pageSettingsGazRect.width / 2
                        height: pageSettingsGazRect.height / 6
                        value: appmanager.gazConfig[4]
                        onSetValue: (value) => appmanager.onSetGazConfig(4, value)
                    }

                    SetpointLabelLeft {
                        label: "Value 10"
                        width: pageSettingsGazRect.width / 2
                        height: pageSettingsGazRect.height / 6
                        value: appmanager.gazConfig[9]
                        onSetValue: (value) => appmanager.onSetGazConfig(9, value)
                    }

                }
            }
        }

    }
}
