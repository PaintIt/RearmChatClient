import QtQuick 2.9
import QtQuick.Controls.Material 2.3

Rectangle {
  color: "transparent"
  width: parent.width
  height: appText.height + 20

  property alias text: appText.text

  Text {
    id: appText
    width: parent.width - 20
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    horizontalAlignment: Text.AlignHCenter
    wrapMode: Text.Wrap
    color: Material.theme === Material.Dark ? "white" : "black"
    font.pixelSize: 10
  }
}
