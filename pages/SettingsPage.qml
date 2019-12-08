import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import "../customs"

Page {

    id: root
    title: qsTr("Settings")

    header: TabBar{
        id: tabMenu
        currentIndex: swipeView.currentIndex
        TabButton{text: "Primary"}
        TabButton{text: "Accent"}
        TabButton{text: "Background"}
    }

    SwipeView{
        id: swipeView
        anchors.fill: parent
        PrimaryColorPage{}
        AccentColorPage{}
        AppBackgroundPage{}
        currentIndex: tabMenu.currentIndex
    }
    PopupToast{
        id: toast
    }

}
