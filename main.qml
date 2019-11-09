import QtQuick 2.12
import QtQuick.Controls 2.12



ApplicationWindow {
    id: window
    width: 400
    height: 480
    visible: true

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: ContactPage {}
    }
}

