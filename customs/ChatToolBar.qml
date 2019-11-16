import QtQuick.Controls 2.12
import QtQuick 2.9

ToolBar {

    property string _backColor:   settings.backgroundColor
    property string _textContent: "Empty"
    property string _textColor:   "black"
    property string _btnContent:  "\u25C0"
    property bool   _btnVisible:  false
    signal btnClicked

    /*Rectangle{
        anchors.fill: parent
        color: Qt.lighter(_backColor)
    }*/
    ToolButton {
        text: _btnContent
        visible: _btnVisible
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        onClicked: btnClicked()
    }

    Label {
        id: pageTitle
        text: qsTr(_textContent)
        font.pixelSize: 20
        anchors.centerIn: parent
        color: _textColor
    }
}
