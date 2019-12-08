import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import QtQuick.Dialogs 1.3

import "../customs"

Page {

    id: root
    title: _nick

    Flickable{
        id: flickable
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        Column{
            id: content
            anchors.fill: parent
            Rectangle{
                width: userData.width
                height: userData.height
                color: Material.primary
                Column{
                    id: userData
                    width: root.width
                    spacing: 5
                    Label{
                        text: _email
                        //Layout.alignment: Qt.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "white"
                    }
                    Image {
                        asynchronous: true
                        height: 80
                        width: 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: _avatar == "" ? "qrc:/rec/48/contactx50.png" : _avatar
                        //Layout.alignment: Qt.AlignHCenter
                    }
                    Button{
                        text: qsTr("Upload")
                        flat: true
                        //Layout.alignment: Qt.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: fileDialog.open()
                    }

                }   // ColumnLayout

            }   // Rectangle

        }   // Column

    }   // Flickable

    FileDialog{
        id: fileDialog
        title: qsTr("Choice image")
        folder: shortcuts.pictures
        nameFilters: [ "Image files (*.jpg *.png *.jpeg)"]
        onAccepted: {
            _avatar = fileDialog.fileUrl
            window.changeAvatar(_avatar)
        }
    }

}   // Page
