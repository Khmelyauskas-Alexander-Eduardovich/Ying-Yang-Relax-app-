import QtQuick 2.12
import Lomiri.Components 1.3
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.0
import "components"
import "components/ListItems" as ListItems
Page {
    id: settingsPage
    anchors.fill: parent
    header: PageHeader { 
id: pageHeader
title: i18n.tr("Settings")
leadingActionBar.actions: [
Action {
objectName: "action"
iconName: "go-first"
text: i18n.tr("Go Back")
onTriggered: page_stack.pop(YingYang.qml)
}
]
}
Flickable {
id: flickFlack
anchors.top: pageHeader.bottom
anchors {
left: parent.left
right: parent.right
bottom: parent.bottom
}

    ColumnLayout {
        anchors.fill: parent
        spacing: units.gu(1) //10
Item {
Layout.fillWidth: true
height: childrenRect.height
        ListItems.SectionDivider {
text: i18n.tr("Apereance")
iconName: "preferences-desktop-wallpaper-symbolic"
        }}
        SettingsSwitch {
            text: "Enable Transparent Window"
            checked: settingsBard.useTransparentWindow
            onCheckedChanged: {
                settingsBard.useTransparentWindow = checked
            }
        }

        SettingsSwitch {
            text: "Full Screen Mode"
            checked: settingsBard.fullScreen
            onCheckedChanged: {
                settingsBard.fullScreen = checked
            }
        }
Item {
Layout.fillWidth: true
height: childrenRect.height
        ListItems.SectionDivider {
text: i18n.tr("Others")
iconName: "properties"
        }}
        Dial {
            id: volumeDialPane
            from: 0
            to: 1
            value: settingsBard.musicVolume
            onValueChanged: settingsBard.musicVolume = value
            Label {
                text: "Music Volume"
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.right
            }
        }
        Slider {
            id: durationAnimSlider
            live: true
            snapMode: Slider.SnapAlways
            from: 0
            to: 1000
            value: 300
onValueChanged: settingsBard.durationOfAnims = value
        }
        SpinBox {
        id: spinBoxHideDuration
        value: 5000
        from: 0
        to: 10000
        stepSize: 100
        onValueChanged: settingsBard.hideDuration = value
        editable: true
        Label {
            text: qsTr("Music Panel Hide Time")
            anchors {
                verticalCenter: parent.verticalCenter
            left: parent.right
            leftMargin: 30
            }
        }
        }
    }
    // iOS-style gesture bar
    Rectangle {
        id: iOSGestureBar
        width: 400
        height: 5
        radius: 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        color: "#999"
        anchors.horizontalCenter: parent.horizontalCenter
    y: dragable
    MouseArea {
        id: dragable
    anchors.fill: parent
    drag.axis: Drag.YAxis
    drag.target: iOSGestureBar
    drag.maximumY: 60
    drag.minimumY: 0
    }
    }
    // Swipe вверх — закрыть страницу
    MultiPointTouchArea {
id: swipeAreaII
        minimumTouchPoints: 1
        maximumTouchPoints: 1
        property real startX: 0
        property real startY: 0
        height: 50
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        onPressed: {
            startX = touchPoints[0].x
            startY = touchPoints[0].y
        }

        onReleased: {
            var dx = touchPoints[0].x - startX
            var dy = touchPoints[0].y - startY

            if (dy < -100) page_stack.pop()
        }
    }
}
}