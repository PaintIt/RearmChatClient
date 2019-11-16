import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.3

import "customs"
import "pages"

ApplicationWindow {

    property bool   _userLoggedIn   : false
    property string _backgroundColor: settings.backgroundColor
    property string _theme          : settings.theme
    property string _autoDarkMode   : settings.autoNight


    id: window
    width: 400
    height: 480
    visible: true


    Material.theme: _theme == "Dark" ? Material.Dark : Material.System
    Material.accent: _backgroundColor
    Material.background: Qt.darker(_backgroundColor)
    Material.foreground: "black"
    Material.primary: Qt.lighter(_backgroundColor)
    Material.elevation: 6

    StackView {
        id: stackView
        visible: opacity > 0
        enabled: opacity == 1 ? true : false
        opacity: _userLoggedIn
        anchors{
            top: parent.top
            right: parent.right
            left: parent.left
            bottom: tabs.top
        }


        initialItem: ContactPage { id: contactPage
            onLoggedChanged: _userLoggedIn = logged
        }
        Behavior on opacity {
            NumberAnimation {
                duration: 1000
            }
        }
    }



    TabBar{
        id:      tabs
        height:  parent.height / 8
        visible: opacity > 0
        enabled: opacity == 1 ? true : false
        opacity: _userLoggedIn
        anchors{
            left:   parent.left
            right:  parent.right
            bottom: parent.bottom
        }

        TabButton{
            text: qsTr("Contacts")

            onToggled: {
                stackView.replace(stackView.currentItem,"pages/ContactPage.qml")
            }
        }
        TabButton{
            text: qsTr("Accaunt")
            onToggled: {
                stackView.replace(stackView.currentItem,"pages/AccauntInfoPage.qml")
            }
        }
        TabButton{
            text: qsTr("Settings")
            onToggled: {
                stackView.replace(stackView.currentItem,"pages/SettingsPage.qml")
            }
        }
        Behavior on opacity {
            NumberAnimation {
                duration: 1000
            }
        }
    }



    LoginPage {
        height: parent.height
        width: parent.width
        anchors.centerIn: parent
        visible: opacity > 0
        enabled: opacity == 1 ? true : false
        opacity: _userLoggedIn ? 0 : 1

        onRegister: {
            _userLoggedIn = true
            contactPage.logged = true
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 1000
            }
        }
    }



    Connections{
        target: connect
        onAuthStatusOk: _userLoggedIn = true
        onAuthStatusBad: _userLoggedIn = false
    }
}
