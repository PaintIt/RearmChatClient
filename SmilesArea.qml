import QtQuick 2.12
import QtQuick.Controls 2.5

Popup {

    property string path
    property int isClicked: 0

    id: popupSmile

    // x: 0
    //y: Math.round(root.height - inputArea.height - height)
    //closePolicy: Popup.CloseOnPressOutsideParent

    GridView {
        id: content
        anchors.fill: parent
        clip: true
        focus: true
        cellHeight: 35
        cellWidth: 35

        model: SmilesModel {
        }
        delegate: Image {
            height: 20
            width: 20
            source: _sourse
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    //textArea.insert(textArea.cursorPosition,"<img src=\""+ _sourse + "\" align=\"top\" height=20 width=20>")
                    path = "<img src=\"" + _sourse + "\"  height=20 width=20>"
                    isClicked++
                }
            }


            /*  text: qsTr("<img src=\"" + _sourse + "\"
                                align=\"top\" height=25 width=25>")
*/
        }

        ScrollBar.vertical: ScrollBar {
            width: 5
        }
    }
}
