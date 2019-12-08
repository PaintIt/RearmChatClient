import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Popup {
    id: popup
    property alias text: popupLabel.text
    property alias buttonText: okButton.text
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    implicitHeight: 240
    implicitWidth: parent.width * .9
    ColumnLayout {
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 10
        RowLayout {
            Text {
                id: popupLabel
                topPadding: 20
                leftPadding: 8
                rightPadding: 8
                font.pixelSize: 18
                text: ""
                color: Material.accent
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            } // popupLabel
        } // row label
        RowLayout {
            Button {
                id: okButton
                text: ""
                flat: true
                font.pixelSize: 18
                onClicked: {
                    popup.close()
                }
            } // okButton
        } // row button
    } // col layout

    onAboutToHide: {
        stopTimer()
    }
    onAboutToShow: {
        closeTimer.start()
    }

    Timer {
        id: closeTimer
        interval: 4000
        repeat: false
        onTriggered: {
            popup.close()
        }
    }
    function stopTimer() {
        closeTimer.stop()
    }
} // popup
