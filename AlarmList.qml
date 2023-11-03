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

    ListView{
//        width: parent.width
//        height: parent.height/4
        anchors.fill: parent
        ScrollBar.vertical: ScrollBar { }

//        model: almListModel
        model: AlarmListModel
        delegate:   Text{
            id: delegate
            required property int alarmNumber
            color: "white"
            text: getAlarmText(delegate.alarmNumber)
        }

    }
}
