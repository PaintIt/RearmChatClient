import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Item {
    property alias text: contentText.text
    property alias image: myImage.source
    property alias _switch: mySwitch

    id: advSwitch
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter
    width: parent.width
    height: 48
    RowLayout{
        spacing: 0
        anchors.fill: parent
        Item {
            width: 24
            height: 24
            Layout.leftMargin: 15
            Image {
                id: myImage
                width: 24
                height: 24
                horizontalAlignment: Image.AlignLeft
                anchors.verticalCenter: parent.verticalCenter
                source: _icon
            }
            ColorOverlay {
                id: colorOverlay
                visible: mySwitch.position == 1.0
                anchors.fill: myImage
                source: myImage
                color: _accentColor
            }
        } // image and coloroverlay

        Label{
            id: contentText
        }

        Row{
            Layout.alignment: Qt.AlignRight
            Rectangle{
                width: 1
                height: advSwitch.height
                color: "lightblue"
            }

            Switch{
                id: mySwitch
                Layout.rightMargin: 15
            }
        }
    }
}
