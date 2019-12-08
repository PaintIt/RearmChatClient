import QtQuick 2.9

Rectangle {
  id: sectionContent
  color: "transparent"
  width: parent.width
  height: contentContainer.height + 2 * verticalMargin

  property real horizontalMargin: 5
  property real verticalMargin: 5

  property var contentItem
  onContentItemChanged: contentItem.parent = contentContainer

  Item {
    id: contentContainer
    anchors.centerIn: parent
    width: parent.width - 2 * horizontalMargin
    height: contentItem ? contentItem.height : 0
  }
}
