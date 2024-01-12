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
            Item{
                id: itemBottom
                anchors.left: parent.left
                anchors.top: itemAlarmList.bottom
                width: parent.width
                height: parent.height - itemAlarmList.height


                SetpointField {
                    id: txt1
                    width: parent.width / 4
                    height: parent.height / 7
                    anchors.verticalCenter: parent.verticalCenter

                    minVal: 0
                    maxVal: 999
                    units: "°C"

                    value: appmanager.temperatureOverheatSP
                    // onSetValue: appmanager.onSetTemperatureOverheat(value)
                    onSetValue: (value) => appmanager.onSetTemperatureOverheat(value)
                }


            }

        }

    }
}
