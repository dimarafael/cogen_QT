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

            Item {
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

            Item {
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
                        height: parent.height/3
                        anchors.top: parent.top
                        anchors.left: parent.left

                        Label{
                            id: labelParameter1
                            color: "#ffffff"
                            text: "Overheat temperature"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: itemBottom.height / 10
                        }

                        SetpointField {
                            id: setpointField1
                            width: parent.width / 2
                            height: itemBottom.height / 7
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: labelParameter1.bottom

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
                        height: parent.height/3
                        anchors.top: itemParameter1.bottom
                        anchors.left: parent.left

                        Label{
                            id: labelParameter2
                            color: "#ffffff"
                            text: "Drum speed"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: itemBottom.height / 10
                        }

                        SetpointField {
                            id: setpointField2
                            width: parent.width / 2
                            height: itemBottom.height / 7
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: labelParameter2.bottom

                            minVal: 0
                            maxVal: 999
                            units: "rpm"

                            value: appmanager.temperatureOverheatSP
                            onSetValue: (value) => appmanager.onSetTemperatureOverheat(value)
                        }
                    }

                    Item {
                        id: itemParameter3
                        width: parent.width
                        height: parent.height/3
                        anchors.top: itemParameter2.bottom
                        anchors.left: parent.left

                        Label{
                            id: labelParameter3
                            color: "#ffffff"
                            text: "Cooller speed"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: itemBottom.height / 10
                        }

                        SetpointField {
                            id: setpointField3
                            width: parent.width / 2
                            height: itemBottom.height / 7
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: labelParameter3.bottom

                            minVal: 0
                            maxVal: 999
                            units: "%"

                            value: appmanager.temperatureOverheatSP
                            onSetValue: (value) => appmanager.onSetTemperatureOverheat(value)
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
                        id: itemParameter4
                        width: parent.width
                        height: parent.height/3
                        anchors.top: parent.top
                        anchors.left: parent.left

                        Label{
                            id: labelParameter4
                            color: "#ffffff"
                            text: "Smoke extractor speed"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: itemBottom.height / 10
                        }

                        SetpointField {
                            id: setpointField4
                            width: parent.width / 2
                            height: itemBottom.height / 7
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: labelParameter4.bottom

                            minVal: 0
                            maxVal: 999
                            units: "%"

                            value: appmanager.temperatureOverheatSP
                            onSetValue: (value) => appmanager.onSetTemperatureOverheat(value)
                        }
                    }

                    Item {
                        id: itemParameter5
                        width: parent.width
                        height: parent.height/3
                        anchors.top: itemParameter4.bottom
                        anchors.left: parent.left

                        Label{
                            id: labelParameter5
                            color: "#ffffff"
                            text: "Minimal exhaustion pressure"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: itemBottom.height / 10
                        }

                        SetpointField {
                            id: setpointField5
                            width: parent.width / 2
                            height: itemBottom.height / 7
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: labelParameter5.bottom

                            minVal: 0
                            maxVal: 999
                            units: "°C"

                            value: appmanager.temperatureOverheatSP
                            onSetValue: (value) => appmanager.onSetTemperatureOverheat(value)
                        }
                    }

                }




            }

        }

    }
}
