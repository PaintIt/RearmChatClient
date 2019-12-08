import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

ItemDelegate {

    property string _icon
    property string _text
    property string _markerColor: ""
    property int _counter: 0
    property bool _isActive: false

    id: myButton
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter
    focusPolicy: Qt.NoFocus
    height: 48
    width: parent.width

    // Material.buttonPressColor
    Rectangle {
        visible: myButton._isActive
        height: myButton.height
        width: myButton.width
        color:  Material.listHighlightColor
    }

    Row {
        spacing: 0
        topPadding: 0
        leftPadding: 16
        rightPadding: 16
        anchors.verticalCenter: parent.verticalCenter
        Item {
            anchors.verticalCenter: parent.verticalCenter
            width: 24 + 32
            height: 24
            Image {
                id: myImage
                width: 24
                height: 24
                horizontalAlignment: Image.AlignLeft
                anchors.verticalCenter: parent.verticalCenter
                source: _icon
                opacity: _isActive? drawer.activeOpacity : drawer.inactiveOpacity
            }
            ColorOverlay {
                id: colorOverlay
                visible: myButton._isActive
                anchors.fill: myImage
                source: myImage
                color: _accentColor
            }
        } // image and coloroverlay
        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: _text
            opacity: 0.87 // isActive? 1.0 : 0.7
            color: _theme == "Dark"? "white" : "black"
            font.pixelSize: 14
            font.weight: Font.Medium
        } // label
    } // row
    Label {
        rightPadding: 16
        visible: _counter != 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        text: _counter
        opacity: 0.87
        color: _theme == "Dark"? "white" : "black"
        font.pixelSize: 14
        font.weight: Font.Medium
    } // label
    Rectangle {
        visible: _markerColor != ""
        anchors.right: parent.right
        width: 6
        height: parent.height
        color: _markerColor
    }
} // myButton

