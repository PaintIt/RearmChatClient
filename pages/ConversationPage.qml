import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import io.qt.examples.chattutorial 1.0

import "../customs"

Page {

    property string inConversationWith
    property int    _messageTextSize: settings.messTextSize
    property string _backgroundColor: settings.backgroundColor
    property string _backgroundImage: settings.backgroundImage

    id: root

    Image {
        id: backImg
        anchors.fill: parent
        source: _backgroundImage == "non" ? "" : _backgroundImage
    }

    header: ChatToolBar {
        _btnVisible: true
        _textContent: inConversationWith
        onBtnClicked: root.StackView.view.pop()
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: pane.leftPadding + messageField.leftPadding
            displayMarginBeginning: 40
            displayMarginEnd: 40
            verticalLayoutDirection: ListView.BottomToTop
            boundsBehavior: ListView.OvershootBounds
            spacing: 12
            model: SqlConversationModel {
                recipient: inConversationWith
            }
            delegate: Column {
                anchors.right: sentByMe ? parent.right : undefined
                spacing: 2

                readonly property bool sentByMe: model.recipient !== "Me"

                Row {
                    id: messageRow
                    spacing: 6
                    anchors.right: sentByMe ? parent.right : undefined

                    Image {
                        id: avatar
                        source: !sentByMe ? "qrc:/rec/" + model.author.replace(
                                                " ", "_") + ".png" : ""
                    }

                    Item {
                        height: textMessage.implicitHeight + 24
                        width: Math.min(
                                   textMessage.implicitWidth + 24,
                                   listView.width - avatar.width - messageRow.spacing)
                        //width: (textMessage.implicitWidth + 20) > (textMessage.width + 10) ? textMessage.width + 10 : textMessage.implicitWidth + 20
                        Rectangle {
                            id: messageArea
                            anchors.fill: parent
                            color: !sentByMe ? "#aaffaa" : Qt.lighter(_backgroundColor)
                            radius: 5
                            anchors.right: sentByMe ? parent.right : undefined
                        }
                        Text {
                            id: textMessage
                            anchors.fill: parent
                            anchors.margins: 10
                            text: model.message
                            horizontalAlignment: sentByMe ? Text.AlignRight : undefined
                            wrapMode: Text.Wrap
                            textFormat: Text.RichText
                            font.pixelSize: _messageTextSize
                        }


                        /* MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                listView.model.removeMessage(model.id)
                            }
                        }*/
                    }
                }

                Label {
                    id: timestampText
                    text: Qt.formatDateTime(model.timestamp, "d MMM hh:mm")
                    color: "lightgrey"
                    anchors.right: sentByMe ? parent.right : undefined
                    font.pixelSize: 10
                    background: Rectangle{
                        color: "black"
                    }
                }
            }
        }

        Pane {
            id: pane
            Layout.fillWidth: true
            Layout.maximumHeight: root.height / 2
            RowLayout {
                width: parent.width

                Rectangle {
                    id: smilesButton
                    height: 30
                    color: "#00ffffff"
                    width: 30
                    Image {
                        anchors.fill: parent
                        source: "qrc:/rec/smiles/1f60a.png"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            !smilesPopup.opened ? smilesPopup.open(
                                                      ) : "undefined"
                        }
                    }
                }

                TextArea {
                    id: messageField
                    Layout.fillWidth: true
                    placeholderText: qsTr("Compose message")
                    wrapMode: TextArea.Wrap
                    selectByMouse: true
                    selectByKeyboard: true
                    textFormat: TextEdit.PlainText
                }

                Rectangle {
                    id: sendButton
                    height: 20
                    color: "#00ffffff"
                    width: 20
                    enabled: messageField.length > 0
                    rotation: 180
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            listView.model.sendMessage(inConversationWith,
                                                       messageField.text)
                            messageField.text = ""
                        }
                    }
                    Text {
                        anchors.fill: parent
                        text: "\u25C0"
                        font.pixelSize: 20
                        color: parent.enabled ? "skyblue" : "undefined"
                    }
                }
            } // RowLayout
        } // Pane
    } // ColumnLayout

    SmilesArea {
        id: smilesPopup
        width: root.width * 0.8
        height: root.height / 2
        x: 0
        y: pane.y - height
        onIsClickedChanged:{
            messageField.textFormat = TextArea.RichText
            messageField.insert(messageField.cursorPosition,
                                                path)
            //messageField.textFormat = TextArea.PlainText
            }
        }
}
