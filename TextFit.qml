import QtQuick
import QtQuick.Controls

Text{
    property string txt: ""
    property string col: "#ffffff"

    text: txt
    color: col
    anchors.fill: parent
    width: parent.width
    height: parent.height
    font.pointSize: 50
    minimumPointSize: 2
    fontSizeMode: Text.Fit
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
