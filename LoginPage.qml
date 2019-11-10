import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1

Page {
    property bool isRegisterPage: false

    signal register

    id: loginPage
    title: qsTr("Login")

    background: Rectangle {
        color: "#cee45e"
    }

    // login form background
    Rectangle {
        id: loginForm
        anchors.centerIn: parent
        width: content.width + 48
        height: content.height + 16
        color: "#006188"
        radius: 4
    }

    // login form content
    GridLayout {
        id: content
        anchors.centerIn: loginForm
        columnSpacing: 20
        rowSpacing: 10
        columns: 2

        // headline
        Text {
            Layout.topMargin: 8
            Layout.bottomMargin: 12
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            text: isRegisterPage ? "Register" : "Login"
        }

        // email text and field
        Text {
            text: qsTr("E-mail")
            font.pixelSize: 12
        }

        TextField {
            id: txtEmail
            Layout.preferredWidth: 200
            font.pixelSize: 14
        }

        // __________Nick Name field ONLY FOR REGISERING__________
        Text {
            text: qsTr("Nick name")
            visible: isRegisterPage
            font.pixelSize: 12
        }

        TextField {
            id: txtNickName
            visible: isRegisterPage
            Layout.preferredWidth: 200
            font.pixelSize: 14
        }

        // ________________password text and field_________________
        Text {
            text: qsTr("Password")
            font.pixelSize: 12
        }

        TextField {
            id: txtPassword
            Layout.preferredWidth: 200
            font.pixelSize: 14
            echoMode: TextInput.Password
        }

        // column for buttons, we use column here to avoid additional spacing between buttons
        Column {
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.topMargin: 12

            // ________buttons for loggin____________
            Button {
                text: qsTr("Login")
                visible: !isRegisterPage
                flat: false
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    console.debug("login...")
                    loginPage.forceActiveFocus()
                    //connect.sendAuthData(txtEmail.text, txtPassword.text)
                    register()
                }
            }
            Button {
                text: qsTr("No account yet? Register now")
                visible: !isRegisterPage
                font.pixelSize: 10
                flat: true
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    loginPage.forceActiveFocus()
                    isRegisterPage = true
                    console.debug("register page...")
                }
            }

            // __________buttons for register____________
            Button {
                text: qsTr("Register")
                visible: isRegisterPage
                flat: false
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    console.debug("register...")
                    loginPage.forceActiveFocus()
                    connect.sendRegisterData(txtEmail.text, txtNickName.text,
                                             txtPassword.text)
                    //register()
                }
            }
            Button {
                text: qsTr("Go back")
                font.pixelSize: 10
                visible: isRegisterPage
                flat: true
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    loginPage.forceActiveFocus()
                    isRegisterPage = false
                    console.debug("back...")
                }
            }
        }
    } // GridLayout
} //Page
