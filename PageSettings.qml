import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.VirtualKeyboard


Item {
    property var inputItem: InputContext.priv.inputItem

    id: itemPageSettings
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

                        // Rectangle{
                        //     anchors.fill: parent
                        //     color: "blue"
                        // }
                        Column{
                            anchors.fill: parent
                            anchors.leftMargin: defMargin*2
                            spacing: itemBottom.height / 14
                            Label{
                                id: labelParameter4_1
                                color: "#ffffff"
                                text: "Temperature in<BR>electric cabinet = " + appmanager.temperatureBox + " °C"
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

    }
}
