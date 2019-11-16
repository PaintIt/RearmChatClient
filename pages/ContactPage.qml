import QtQuick 2.12
import QtQuick.Controls 2.12

import io.qt.examples.chattutorial 1.0

import "../customs"

Page {

    property bool    logged: true
    property string _backgroundColor: settings.backgroundColor
    property string _backgroundImage: settings.backgroundImage
    property int    _mTextSize:       settings.messTextSize


    id: root

    Image {
        id: backImg
        anchors.fill: parent
        source: _backgroundImage == "non" ? "" : _backgroundImage
        opacity: 0.4
    }

    header: ChatToolBar {
        _btnVisible: true
        _textContent: "Contacts"
        onBtnClicked: logged = false
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

    Connections{
        target: settings
    }
}

