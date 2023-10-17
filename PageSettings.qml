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

        AlarmList {
            id: alarmList
            anchors.fill: parent
        }
    }
}
