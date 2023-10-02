import QtQuick

Item {
    id: root
    anchors.fill: parent
    width: parent.width
    height: parent.height
    property alias textColor: textTime.color
    property bool isRunning: false

    property date startDate

    signal started()
    signal stoped()
    signal trig59s()

    function startTimer(){
        timer1s.start()
        root.isRunning = true
        root.started()
        root.startDate = new Date()
    }
    function stopTimer(){
        timer1s.stop()
        root.isRunning = false
        root.stoped()
    }
    function resetTimer(){
        textTime.text = "00:00"
    }

    Text{
        id:textTime
        text: "00:00"
        color: "#ffffff"
        anchors.fill: parent
        width: parent.width
        height: parent.height
        font.pointSize: 50
        minimumPointSize: 2
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Timer{
        id: timer1s
        interval: 1000
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            textTime.text = Qt.formatTime(new Date(new Date() - startDate),"mm:ss")
//            if(Qt.formatTime(new Date(new Date() - startDate),"ss") === "59") root.trig59s()
        }
    }
}
