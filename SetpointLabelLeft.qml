import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.VirtualKeyboard


Item{
    id: root
    width: 150
    height: 50
    property real value;
    property string label: ""
    signal setValue(real value);

    Label{
        text: root.label
        anchors.right: setpointField.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: parent.height * 0.3
        font.pixelSize: parent.height * 0.3
        color: "#d4d4d4"
    }
    SetpointField {
        id: setpointField
        width: parent.width / 2
        height: parent.height * 0.6
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: parent.height / 2

        minVal: 0
        maxVal: 100
        units: "%"

        value: root.value
        onSetValue: (value) => root.setValue(value)
    }
}
