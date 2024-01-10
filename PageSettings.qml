import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects


Item {
    id: itemPageSettings
    anchors.fill: parent
    z: 3





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

            TextField{
                width: parent.width / 4
                height: parent.height / 8
                // inputMask: "000"
                // validator: IntValidator {}
                inputMethodHints: Qt.ImhDigitsOnly
            }
        }

    }
}
