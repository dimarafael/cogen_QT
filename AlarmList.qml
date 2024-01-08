import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import com.dna.AlarmListModel


Item{
    id:alarmList

    readonly property var alarmsMessages: [
        "Message 1",
        "Message 2",
        "Message 3",
        "Message 4",
        "Message 5",
        "Message 6",
        "Message 7",
        "Message 8",
        "Message 9",
        "Message 10",
        "Message 11"
    ]

    function getAlarmText(almNumber){
        if (almNumber < alarmsMessages.length) return alarmsMessages[almNumber]
        else return "Alarm" + almNumber
    }

    Rectangle{
        id: rectangleAlarmList
        anchors.fill: parent
        radius: defMargin*2
        anchors.margins: defMargin*2
        color: colorText

        ListView{
    //        width: parent.width
    //        height: parent.height/4
            anchors.fill: parent
            anchors.margins: defMargin*2
            clip: true
            ScrollBar.vertical: ScrollBar { }

    //        model: almListModel
            model: AlarmListModel
            delegate:   Text{
                id: delegate
                required property int alarmNumber
                color: "darkred"
                font.pixelSize: rectangleAlarmList.height/7
                text: getAlarmText(delegate.alarmNumber)
            }

        }
    }

    InnerShadow{
        anchors.fill: rectangleAlarmList
        source: rectangleAlarmList
        // horizontalOffset: root.width/30
        // verticalOffset: root.width/30
        horizontalOffset: 2
        verticalOffset: 2
        radius: 3.0
        samples: 17
        spread: 0.1
        color: "#000000"
    }


}
