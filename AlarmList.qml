import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects


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

    Connections{
        target: appmanager
        function onAlmIntListChanged(){
            almListModel.clear()
            appmanager.almIntList.forEach((almItem)=>{
                almListModel.append({"val":alarmsMessages[almItem]})
            })
        }
    }

    ListModel{
        id: almListModel
    }

    ListView{
        width: pageSettingsRect.width
        height: pageSettingsRect.height/4
        ScrollBar.vertical: ScrollBar { }

        model: almListModel
        delegate:   Text{
            color: "white"
            text: modelData
        }

    }
}
