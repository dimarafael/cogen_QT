import QtQuick

Item {
    anchors.fill: parent
    width: parent.width
    height: parent.height
    property string textColor: "#ffffff"
    property bool isRunning: false

    property date startDate

    signal started()
    signal stoped()

    function startTimer(){
        timer1s.start()
        isRunning = true
        started()
        startDate = new Date()
    }
    function stopTimer(){
        timer1s.stop()
        isRunning = false
        stoped()
    }
    function resetTimer(){
        textTime.text = "00:00"
    }

    Text{
        id:textTime
        text: "00:00"
        color: textColor
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
        }
    }
}
