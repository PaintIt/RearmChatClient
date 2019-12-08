import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
Popup {
    id: popup
    closePolicy: Popup.NoAutoClose
    property alias text: popupLabel.text
    property alias buttonText: okButton.text
    z: 3
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    implicitHeight: 240
    implicitWidth: parent.width * .9
    modal: true
    ColumnLayout {
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 10
        RowLayout {
            Label {
                id: popupLabel
                topPadding: 20
                leftPadding: 8
                rightPadding: 8
                text: ""
                color: Material.accent
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            } // popupLabel
        } // row label
        RowLayout {
            Button {
                id: okButton
                text: "Close"
                onClicked: {
                    popup.close()
                }
            } // okButton
        } // row button
    } // col layout

    /*onAboutToHide: {
        window.backKeyBlocked = false
    }
    onAboutToShow: {
        window.backKeyBlocked = true
    }*/


} // popup
