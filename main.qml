import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: window
    width: 400
    height: 480
    visible: true

    property bool userLoggedIn: false

    StackView {
        id: stackView
        visible: opacity > 0
        enabled: opacity == 1 ? true : false
        opacity: userLoggedIn
        anchors.fill: parent
        initialItem: ContactPage {
            onLoggedChanged: userLoggedIn = logged
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
        opacity: userLoggedIn ? 0 : 1

        onRegister: {
            userLoggedIn = true
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 1000
            }
        }
    }

    Connections{
        target: connect
        onAuthStatusOk: userLoggedIn = true
        onAuthStatusBad: userLoggedIn = false
    }
}
