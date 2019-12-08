import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.3

Page {
    property bool isRegisterPage: false
    property string textColor: Material.theme === Material.Dark ? "white" : "black"
    signal register

    id: loginPage
    title: qsTr("Login")


    // ____________login form background_________
    Rectangle {
        id: loginForm
        anchors.centerIn: parent
        width: content.width + 48
        height: content.height + 16
        color: "transparent"
        radius: 4
        border.color: _primaryColor
    }

    // ____________login form content____________
    GridLayout {
        id: content
        anchors.centerIn: loginForm
        columnSpacing: 20
        rowSpacing: 10
        columns: 2

        // ______________headline_______________
        Text {
            Layout.topMargin: 8
            Layout.bottomMargin: 12
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            text: isRegisterPage ? "Register" : "Login"
            color: textColor
        }

        // ___________email text and field_________
        Text {
            text: qsTr("E-mail")
            font.pixelSize: 12
            color: textColor
        }

        TextField {
            id: txtEmail
            Layout.preferredWidth: 200
            font.pixelSize: 14
        }

        // __________Nick Name field ONLY FOR REGISERING__________
        Text {
            text: qsTr("Nick")
            visible: isRegisterPage
            font.pixelSize: 12
            color: textColor
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
            color: textColor
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
                flat: true
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    console.debug("login...")
                    loginPage.forceActiveFocus()
                    //connect.sendAuthData(txtEmail.text, txtPassword.text)

                    txtPassword.text = ""
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
                    txtPassword.text = ""
                    console.debug("register page...")
                }
            }

            // __________buttons for register____________
            Button {
                text: qsTr("Register")
                visible: isRegisterPage
                flat: true
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    console.debug("register...")
                    loginPage.forceActiveFocus()
                    connect.sendRegisterData(txtEmail.text, txtNickName.text,
                                             txtPassword.text)
                    txtPassword.text = ""
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
                    txtPassword.text = ""
                    txtNickName.text = ""
                    console.debug("back...")
                }
            }
        }
    } // GridLayout
} //Page
