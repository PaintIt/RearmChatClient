import QtQuick 2.9
import QtQuick.Controls 2.5

import chatmodel 1.0

import "../customs"

Page {


    id: root
    title: qsTr("Contacts")

    Image{
        anchors.fill: parent
        opacity: 0.35
        source: _backgroundImage
    }

    ListView {
        id: listView
        anchors.fill: parent
        topMargin: 10
        leftMargin: 10
        bottomMargin: 10
        rightMargin: 10
        spacing: 10
        model: SqlContactModel {}
        delegate: ItemDelegate {
            text: model.display
            width: listView.width - listView.leftMargin - listView.rightMargin
            height: avatar.implicitHeight
            leftPadding: avatar.implicitWidth + 32
            onClicked: root.StackView.view.push("qrc:/pages/ConversationPage.qml", { inConversationWith: model.display })
            Image {
                id: avatar
                source: "qrc:/rec/" + model.display.replace(" ", "_") + ".png"
            }
        }
    }
    FloatingActionButton{
        imageSource: "qrc:/rec/24/plus.png"
        z: 1
        anchors.margins: 16
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: toast.start("TODO :)")
    }
}

