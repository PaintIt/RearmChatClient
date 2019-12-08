import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Popup {
    id: popup
    property alias text: toastLabel.text
    property bool isLandscape: window.width > window.height
    enabled: false
    closePolicy: Popup.NoAutoClose
    bottomMargin: isLandscape? 24 : 80
    x: (window.width - width) / 2
    y: (window.height - height)
    background: Rectangle{
        color: Material.accent
        radius: 24
        opacity: 0.8
    }
    Timer {
        id: toastTimer
        interval: 3000
        repeat: false
        onTriggered: {
            popup.close()
        }
    } // toastTimer
    Label {
        id: toastLabel
        leftPadding: 16
        rightPadding: 16
        font.pixelSize: 16
        color: "white"
    } // toastLabel
    onAboutToShow: {
        toastTimer.start()
    }
    function start(toastText) {
        toastLabel.text = toastText
        if(!toastTimer.running) {
            open()
        } else {
            toastTimer.restart()
        }
    } // function start
} // popup toastPopup
