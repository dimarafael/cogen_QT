import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import com.dna.AlarmListModel


Item{
    id:alarmList

    readonly property var alarmsMessages: [
        "Coffee temperature: overheat",
        "Coffee temperature: sensor alarm",
        "Extraction temperature: overheat",
        "Extraction temperature: sensor alarm",
        "Differential pressure sensor alarm",
        "Drum: no contactor feedback",
        "Drum: no frequency converter feedback",
        "Drum: frequency converter alarm",
        "Smoke extractor: no frequency converter feedback",
        "Smoke extractor: frequency converter alarm",
        "Cooler: no frequency converter feedback",
        "Cooler: frequency converter alarm",
        "Emergency button pressed",
        "Power alarm",
        "Fire controller alarm",
        "Stirrer: no contactor feedback",
        "No differential pressure in smoke extractor",
        "Cooling",
        "Smoke extractor: circuit breaker",
        "Cooler: circuit breaker",
        "Drum: circuit breaker",
        "Stirrer: circuit breaker",
        "Alarm 22",
        "Alarm 23",
        "Alarm 24",
        "Alarm 25",
        "Alarm 26",
        "Alarm 27",
        "Alarm 28",
        "Alarm 29",
        "Alarm 30",
        "Alarm 31"
    ]

    function getAlarmText(almNumber){
        if (almNumber < alarmsMessages.length) return alarmsMessages[almNumber]
        else return "Alarm" + almNumber
    }

    Rectangle{
        id: rectangleAlarmList
        anchors.fill: parent
        // radius: defMargin*2
        anchors.margins: defMargin*2
        color: colorText

        ListView{
            id: listView
            anchors.fill: parent
            anchors.margins: defMargin*2
            clip: true
            ScrollBar.vertical: ScrollBar { }

            MouseArea {
                anchors.fill: parent
                onClicked: listView.forceActiveFocus();
            }

            model: AlarmListModel
            delegate:   Text{
                id: delegate
                required property int alarmNumber
                color: "darkred"
                font.pixelSize: listView.height/8
                text: getAlarmText(delegate.alarmNumber)
            }
        }

    }

    // InnerShadow{
    //     anchors.fill: rectangleAlarmList
    //     source: rectangleAlarmList
    //     horizontalOffset: 2
    //     verticalOffset: 2
    //     radius: 3.0
    //     samples: 17
    //     spread: 0.1
    //     color: "#000000"
    // }


}
