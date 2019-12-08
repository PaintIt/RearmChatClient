import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import "customs"
import "pages"

ApplicationWindow {

    property bool   _userLoggedIn   : false

    property string _theme
    property string _autoDarkMode
    property string _accentColor: _settings.defaultAccentColor
    property string _primaryColor: _settings.defaultPrimaryColor
    property string _backgroundImage

    property bool isLandscape: width > height
    property var  activeDrawerButton: contactDrawerBtn
    property bool _tabBarVisible: _userLoggedIn && _settings.tabBarVisible
                                  && !isLandscape && !drawer.position > 0.2
                                  && stackView.depth < 2

    property string _nick: "Coccine"
    property string _email: "loveafdey@gmail.com"
    property string _avatar: _settings.avatar

    id: window
    width: 480
    height: 500
    visible: true


    Material.theme: _theme == "Dark" ? Material.Dark : Material.Light
    Material.accent: _accentColor
    Material.primary: _primaryColor


//________________________________TOOL BAR_________________________________

    header: ToolBar {
        contentHeight: toolButton.implicitHeight
        visible: opacity > 0
        enabled: opacity == 1 ? true : false
        opacity: _userLoggedIn

        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }
        ToolButton {
            id:   toolButton
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
            Image{
                anchors.centerIn: parent
                source: stackView.depth > 1 ? "qrc:/rec/24/back.png" : "qrc:/rec/24/menu.png"
            }

        }   // ToolButton

        Text {
            text: stackView.currentItem.title
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 14
        }

    }   // ToolBar

//______________________________TOOL BAR END____________________________________


//_______________________________TAB BAR_________________________________________

    footer: TabBar{
        id: tabs
        visible: opacity > 0
        enabled: opacity == 1 ? true : false
        opacity: _tabBarVisible
        currentIndex: 1

        property int lastIndex: 1

        Behavior on opacity {
            NumberAnimation {
                duration: 100
            }
        }
        IconTabButton{
            image: "qrc:/rec/24/menu.png"
            onClicked: drawer.open()
        }
        IconTabButton{
            index: 1
            image: "qrc:/rec/24/message.png"
            onToggled: {
                if(stackView.depth > 1)
                    stackView.pop()
                activeDrawerButton = contactDrawerBtn
                stackView.replace(stackView.currentItem, contactPage)
            }
        }
        IconTabButton{
            index: 2
            image: "qrc:/rec/24/contacts.png"
            onToggled: {
                if(stackView.depth > 1)
                    stackView.pop()
                activeDrawerButton = accauntDrawerBtn
                stackView.replace(stackView.currentItem,accauntInfoPage)
            }
        }
        IconTabButton{
            index: 3
            image: "qrc:/rec/24/settings.png"
            onToggled: {
                if(stackView.depth > 1)
                    stackView.pop()
                activeDrawerButton = settingsDrawerBtn
                stackView.replace(stackView.currentItem, settingsPage)
            }
        }
        onCurrentIndexChanged: {
            currentIndex == 0 ? currentIndex = lastIndex : lastIndex = currentIndex
        }
    }   // TabBar

//_________________________________TAB BAR END_______________________________________________



//__________________________________DRAWER___________________________________________________

    Drawer {

        property real activeOpacity: 0.87
        property real inactiveOpacity: 0.56
        property bool isLoginPage: !_userLoggedIn

        id:     drawer
        width:  !isLandscape? window.width * 0.75 : window.width * 0.45
        height: window.height

        Flickable{
            clip: true
            anchors.fill: parent
            contentHeight: column.height
            visible: !drawer.isLoginPage

            Column {
                id: column
                focus: false
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 0

                Rectangle{
                    id: drawerTitle
                    height: avatar.height + userInfoContent.height + 10
                    width: parent.width
                    color: Material.primary
                    Image {
                        anchors.fill: parent
                        id: drawerTitleBackground
                        source: _backgroundImage
                    }
                    Image {
                        id: avatar
                        height: 50
                        width: height
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: _avatar == ""? "qrc:/rec/48/contactsx50.png" : _avatar
                    }
                    ColumnLayout{
                        id: userInfoContent
                        anchors.top: avatar.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        Rectangle{
                            height: parent.height
                            width: parent.width
                            color: "black"
                            opacity: 0.3
                        }

                        Text {
                            text: _nick
                            font.pixelSize: 13
                            wrapMode: Text.Wrap
                            color: "white"
                        }
                        Text {
                            text: _email
                            font.underline: true
                            font.pixelSize: 13
                            wrapMode: Text.Wrap
                            color: "white"
                        }
                    }
                }

                Devider{}
                SectionSpacer{}

                DrawerDelegate{
                    id: contactDrawerBtn
                    _text: qsTr("Contacts")
                    _icon: "qrc:/rec/24/message.png"
                    _isActive: activeDrawerButton === this
                    onClicked: {
                        if(stackView.depth > 1)
                            stackView.pop()
                        tabs.currentIndex = 1
                        stackView.replace(stackView.currentItem,contactPage)
                        activeDrawerButton = this
                        drawer.close()
                    }


                }


                DrawerDelegate{
                    id: accauntDrawerBtn
                    _text: qsTr("Accaunt")
                    _icon: "qrc:/rec/24/contacts.png"
                    _isActive: activeDrawerButton === this
                    onClicked: {
                        if(stackView.depth > 1)
                            stackView.pop()
                        tabs.currentIndex = 2
                        stackView.replace(stackView.currentItem,accauntInfoPage)
                        activeDrawerButton = this
                        drawer.close()
                    }
                }

                DrawerDelegate{
                    id: settingsDrawerBtn
                    _text: qsTr("Settings")
                    _icon: "qrc:/rec/24/settings.png"
                    _isActive: activeDrawerButton === this
                    onClicked: {
                        if(stackView.depth > 1)
                            stackView.pop()
                        tabs.currentIndex = 3
                        stackView.replace(stackView.currentItem,settingsPage)
                        activeDrawerButton = this
                        drawer.close()
                    }
                }


                SectionSpacer{}
                Devider{}
                SectionSpacer{}
                DrawerDelegate{
                    _text: qsTr("Log out")
                    _icon: "qrc:/rec/24/unlock.png"
                    onClicked: {
                        if(stackView.depth > 1)
                            stackView.pop()
                        _userLoggedIn = false
                        activeDrawerButton = contactDrawerBtn
                        drawer.close()
                    }
                }
                DrawerDelegate{
                    _text: qsTr("Exit")
                    _icon: "qrc:/rec/48/delete.png"
                    onClicked: {
                        Qt.quit()
                    }
                }

                SectionSpacer{}
                Devider{}
                SectionSpacer{}
                AdvansedSwitch{
                    property bool _init: false

                    text: qsTr("Dark Mode")
                    image: "qrc:/rec/24/sun.png"
                    _switch.onToggled: {
                        if(_init){
                            _theme = _theme == "Dark" ? "Light" : "Dark"
                            toast.start("You can change colors in settings")
                        }
                    }
                    Component.onCompleted: {
                        if(_theme == "Dark"){
                            _switch.toggle()
                        }
                        _init = true
                    }
                }   // Switch for dark mode

                SectionSpacer{}

                AdvansedSwitch{
                    text: qsTr("Notifications")
                    image: "qrc:/rec/24/notifications.png"
                    _switch.onToggled: {
                        toast.start("TODO;)")
                    }
                }   // Switch for notifications

                SectionSpacer{}

                AdvansedSwitch{
                    property bool _init: false
                    text: qsTr("Favorites Bar")
                    image: "qrc:/rec/24/favorites.png"
                    _switch.onToggled: {
                        if(_init){
                            _settings.tabBarVisible = _settings.tabBarVisible == true? false : true
                        }
                    }
                    Component.onCompleted: {
                        if(_settings.tabBarVisible == true){
                            _switch.toggle()
                        }
                        _init = true
                    }
                }

            }   // Column

        }   // Flickable

        DrawerDelegate{
            visible: drawer.isLoginPage
            _text: qsTr("Exit")
            _icon: "qrc:/rec/48/delete.png"
            onClicked: {
                Qt.quit()
            }
        }

    }   // Drawer

//____________________________DRAWER END_____________________________________________________



//___________________________STACK VIEW______________________________________________________
    StackView {
        id:      stackView
        visible: opacity > 0
        enabled: opacity == 1 ? true : false
        opacity: _userLoggedIn
        anchors.fill: parent

        initialItem: contactPage
        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }
    }   // StackView


//___________________________STACK VIEW END_____________________________________________________

    LoginPage {
        height: parent.height
        width: parent.width
        anchors.centerIn: parent
        visible: opacity > 0
        enabled: opacity == 1 ? true : false
        opacity: _userLoggedIn ? 0 : 1

        onRegister: {
            _userLoggedIn = true
            toast.start("Success!")
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }
    }

    Connections{
        target: connect
        onAuthStatusOk: _userLoggedIn = true
        onAuthStatusBad: _userLoggedIn = false
        onGetLoginAndEmail:{
            _nick = login
            _email = email
        }
    }

    Component{
        id: settingsPage
        SettingsPage{

        }
    }

    Component{
        id: accauntInfoPage
        AccauntInfoPage{

        }
    }

    Component{
        id: contactPage
        ContactPage{

        }
    }


    Settings{
        id: _settings
        property alias accentColor: window._accentColor
        property alias primaryColor: window._primaryColor
        property alias theme: window._theme
        property alias autoDarkMod: window._autoDarkMode
        property alias backgroundImage: window._backgroundImage

        property string avatar: ""
        property alias  login: window._nick
        property alias  email: window._email

        property string defaultAccentColor: "#E91E63"
        property string defaultPrimaryColor: "#3F51B5"
        property string defaultAvatar: "qrc:/rec/48/contactx50.png"

        property bool tabBarVisible: true
    }

    PopupToast{
        id: toast
    }
    PopupInfo{
        id: info
        text: "Hello"
    }
    PopupTestModal{
        id: exInfo
        text: "huli"
    }

    onClosing: {
        if (Qt.platform.os == "android") {
            close.accepted = false;
            if (stackView.depth > 1)
                stackView.pop ()
            else
                drawer.open()
        }
    }

    function changeAccentColor(color){
        _settings.accentColor = color
    }
    function changePrimaryColor(color){
        _settings.primaryColor = color
    }
    function changeBackgroundImage(image){
        _settings.backgroundImage = image
    }
    function changeAvatar(avatar){
        _settings.avatar = avatar
    }
}
