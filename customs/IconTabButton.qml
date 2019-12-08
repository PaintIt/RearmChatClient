import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

TabButton {
    property real theOpacity: 1.0
    property alias image: contentImage.source
    property int index
    focusPolicy: Qt.NoFocus
    height: 48
    contentItem:
        Item {
        Image {
            id: contentImage
            anchors.centerIn: parent
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            opacity: colorOverlay.visible? 1.0 : theOpacity
        }
        ColorOverlay {
            id: colorOverlay
            visible: true
            anchors.fill: contentImage
            source: contentImage
            color: index == tabs.currentIndex ? Material.primary :
                                                Material.theme == Material.Dark? Qt.lighter(Material.accent, 1.5) :
                                                                                 Qt.darker(Material.accent, 1.5)
        }
    } // item
}
