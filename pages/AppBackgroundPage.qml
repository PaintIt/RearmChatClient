import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Page {
    id: accentPage
    bottomPadding: 24
    topPadding: 16
    title: qsTr("Background")

    Label {
        id: headline
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        font.pixelSize: 16
        leftPadding: 16
        rightPadding: 16
        bottomPadding: 16
        text: qsTr("Select Background image")
    }

    Label {
        id: description
        anchors.top: headline.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        font.pixelSize: 10
        leftPadding: 16
        rightPadding: 16
        bottomPadding: 16
        wrapMode: Label.Wrap
        text: qsTr("Here you can set or change the image of chat and other places of the application")
    }

    GridView {
        id: gridView
        clip: true
        focus: true
        cellHeight: !isLandscape? height / 2 : width / 3
        cellWidth: cellHeight
        anchors.top: description.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        delegate: Rectangle{
            height: gridView.cellHeight
            width: height
            color: "#000000"
            Text {
                text: qsTr("Clear")
                anchors.centerIn: parent
                color: "#ffffff"
            }
            Image {
                anchors.fill: parent
                source: model._src
                asynchronous: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    if(_backgroundImage !== model._src){
                            window.changeBackgroundImage(model._src)
                            toast.start(qsTr("Bacground image changed"))
                    }
                }
            }
        }

        model: ListModel {
            ListElement { _src: ""}
            ListElement { _src: "qrc:/rec/background/1.jpg"}
            ListElement { _src: "qrc:/rec/background/2.jpg"}
            ListElement { _src: "qrc:/rec/background/3.jpg"}
            ListElement { _src: "qrc:/rec/background/4.jpg"}
            ListElement { _src: "qrc:/rec/background/5.jpg"}
            ListElement { _src: "qrc:/rec/background/6.jpg"}
            ListElement { _src: "qrc:/rec/background/7.jpg"}
            ListElement { _src: "qrc:/rec/background/8.jpg"}
            ListElement { _src: "qrc:/rec/background/9.jpg"}
            ListElement { _src: "qrc:/rec/background/10.jpg"}
            ListElement { _src: "qrc:/rec/background/11.jpg"}
            ListElement { _src: "qrc:/rec/background/12.jpg"}
            ListElement { _src: "qrc:/rec/background/13.jpg"}
        }
        ScrollIndicator.vertical: ScrollIndicator { }
    } // end listView

} // end accentPage
