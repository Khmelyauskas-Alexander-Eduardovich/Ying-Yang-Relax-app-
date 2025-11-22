/*
 * Copyright (C) 2025  JasonWalt Bab@
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * ying-yang is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Lomiri.Components 1.3 
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.0
import QtMultimedia 5.12
import QtQml 2.12
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import "Sprites"

Window {
    id: mainView
    width: 640
    height: 900
    visible: true
    color: settingsBard.useTransparentWindow ? "transparent" : "white"
    visibility: settingsBard.fullScreen ? Window.FullScreen : Window.Windowed
    title: qsTr("Ying-Yang")

    Settings {
        id: settingsBard
        category: "appearance"
        property bool useTransparentWindow: false
        property bool fullScreen: false
    }
    MultiPointTouchArea {
        anchors.fill: parent
        minimumTouchPoints: 1
        maximumTouchPoints: 1

        property real startX: 0
        property real startY: 0

        onPressed: {
            startX = touchPoints[0].x
            startY = touchPoints[0].y
        }

        onReleased: {
            var dx = touchPoints[0].x - startX
            var dy = touchPoints[0].y - startY

            // Swipe вверх (закрыть окно)
                page_stack.pop();
            // Swipe вправо (открыть настройки)
            if (dx > 100 && (!page_stack.currentItem || page_stack.currentItem.objectName !== "settingsPage")) {
                var settingsComponent = Qt.createComponent("Settings.qml")
                if (settingsComponent.status === Component.Ready) {
                    page_stack.push(settingsComponent)
                } else if (settingsComponent.status === Component.Error) {
                    console.log("Ошибка загрузки Settings.qml:", settingsComponent.errorString())
                } else {
                    console.log("Settings.qml ещё не готов, статус:", settingsComponent.status)
                }
            }

            // Swipe влево (смена Инь-Яня — оставляем тебе)
            if (dx < -100) {
                console.log("Swipe налево — сюда можно повесить смену Инь-Яня")
            }
        }
    }

    StackView {
        id: page_stack
        anchors.fill: parent
        initialItem: "YingYang.qml"

        // Переходы между страницами
        pushEnter: Transition {
            PropertyAnimation { property: "x"; from: mainView.width; to: 0; duration: 400; easing.type: Easing.InOutQuad }
            PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 400 }
        }
        pushExit: Transition {
            PropertyAnimation { property: "x"; from: 0; to: -mainView.width; duration: 400; easing.type: Easing.InOutQuad }
            PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: 400 }
        }
        popEnter: Transition {
            PropertyAnimation { property: "x"; from: -mainView.width; to: 0; duration: 400; easing.type: Easing.InOutQuad }
            PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 400 }
        }
        popExit: Transition {
            PropertyAnimation { property: "x"; from: 0; to: mainView.width; duration: 400; easing.type: Easing.InOutQuad }
            PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: 400 }
        }
    }
    // Слежение за настройками через on<Property> Changed
    Connections {
        target: settingsBard
        onUseTransparentWindowChanged: mainView.color = settingsBard.useTransparentWindow ? "transparent" : "white"
    }
}




