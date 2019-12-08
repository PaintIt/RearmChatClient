import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3


Rectangle {
  color: "transparent"
  width: parent.width
  height: iconRect.height + 10

  property alias text: appText.text
  property alias image: imageItem.source

  Row {
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 10

    Rectangle {
      id: iconRect
      visible: imageItem.source != ""
      width: 20 * 2.5
      height: visible ? width : appText.height
      radius: width * 0.5
      color: "transparent"

      Image {
        id: imageItem
        visible: imageItem.source != ""
        anchors.centerIn: parent
        width: 20 * 1.5
        height: width / sourceSize.width * sourceSize.height
      }
    }

    Text {
      id: appText
      anchors.verticalCenter: parent.verticalCenter
      color: Material.theme === Material.Dark ? "white" : "black"
      font.pixelSize: 16
      font.bold: true
    }
  }
}
