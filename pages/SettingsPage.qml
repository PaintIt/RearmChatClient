import QtQuick 2.12
import QtQuick.Controls 2.12

import "../customs"

Page {

    property string _backgroundColor: settings.backgroundColor
    property string _backgroundImage: settings.backgroundImage


    id: root

    Image {
        id: backImg
        anchors.fill: parent
        source: _backgroundImage == "non" ? "" : _backgroundImage
        opacity: 0.3
    }

    header: ChatToolBar {
        _btnVisible: false
        _textContent: "Settings"
    }


    ScrollView{
        anchors.fill: parent
        contentWidth: -1
        contentHeight: content.height + 1
        Column{
            id: content
            Row{
                Repeater{
                    id: themeColor
                    width: root.width
                    model: ["#918b8b","#ff8800", "#f7ff00","#25c41a","#44ff00","#158b48","#14168b","#65138b",
                    "#8b1257","#be0e2c"]
                    delegate: Rectangle{
                        height: width
                        width: root.width / themeColor.count
                        color: modelData
                        radius: width
                        border.color: "black"
                        border.width: 1
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(_backgroundColor != modelData)
                                    settings.setBackgroundColor(modelData)
                            }
                        }
                    }
                }
            }

            SectionSpacer{}
            Row{
                Repeater{
                    id: backImage
                    width: root.width
                    model: ["qrc:/rec/background/1.jpg","qrc:/rec/background/2.jpg","qrc:/rec/background/3.jpg"]
                    delegate: Image {
                        height: width
                        width: root.width / backImage.count
                        source: modelData
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                if(_backgroundImage != modelData)
                                    settings.setBackgroundImage(modelData)
                            }
                        }
                    }
                }
            }

        }   // content Column
    }   //ScrollView
}
