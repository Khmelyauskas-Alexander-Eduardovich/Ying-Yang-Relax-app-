import QtQuick 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.0

Item {
    id: root
    width: mainView.width
    height: mainView.heightQ
anchors.centerIn: parent
    // === ПЕРЕМЕННЫЕ ===
    property real baseSpeed: 90
    property real speed: baseSpeed
    property int direction: 1
    property bool paused: false
    property real actualSpeed: 0
    property int currentTrackIndex: 0
//    property real currentSpeed: baseSpeed

    property var tracks: [
        { path: "Sprites/Music & Loops/in-game-loop.mp3", title: "Esviji - CiberSheep" }
    ]
    // === ПЛАВНЫЙ СТАРТ ===
Component.onCompleted: {
    actualSpeed = 0
    speedAnim.stop()
    speedAnim.from = 0
    speedAnim.to = speed * direction
    speedAnim.start()
}

    // === МЕДИАПЛЕЕР ===
    MediaPlayer {
        id: musicPlayer
        source: tracks[currentTrackIndex].path
        autoPlay: true
        loops: MediaPlayer.Infinite
        volume: settingsBard.musicVolume
    }

    // === ИНЬ-ЯНЬ ===
    Image {
        id: yinYang
        anchors.centerIn: parent
        width: 200
        height: 200
        source: "Sprites/JasonWalt Bab@'s Especialmente Significando tanto de sa actualizando.svg"
        rotation: rotationAngle
        scale: zoomSlider.value
        Behavior on scale { NumberAnimation { duration: 400; easing.type: Easing.InOutQuad } }
    }
    // === ВРАЩЕНИЕ ===
    property real rotationAngle: 0
    Timer {
        interval: 16
        running: true
        repeat: true
        onTriggered: rotationAngle = (rotationAngle + actualSpeed * interval / 1000) % 360
    }
    // === АНИМАЦИЯ СКОРОСТИ ===
    NumberAnimation on actualSpeed {
        id: speedAnim
        duration: 400
        easing.type: Easing.InOutQuad
}
    // === КОНТРОЛЫ ===
    Column {
        id: column
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        width: 350

        Button {
            text: paused ? "▶️ Вращение: Выключено" : "⏸️ Вращение: Включено"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                paused = !paused
                speedAnim.stop()
                speedAnim.to = paused ? 0 : speed * direction
                speedAnim.start()
            }
        }
        Row {
            spacing: 8
            width: parent.width * 0.8
            Text { text: "Скорость"; color: "white"; font.pixelSize: 12; width: 70 }

            Slider {
                id: speedSlider
                from: 0
                to: 2
                value: 1
                stepSize: 0.01
                width: parent.width - 80
                onValueChanged: {
                    speed = baseSpeed * value
                    if (!paused) {
                        speedAnim.stop()
                        speedAnim.to = speed * direction
                        speedAnim.start()
                    }
                }
            }
        }

        Row {
            spacing: 8
            width: parent.width * 0.8
            Text { text: "Зум"; color: "white"; font.pixelSize: 12; width: 70 }

            Slider {
                id: zoomSlider
                from: 0.5
                to: 1.6
                value: 1
                stepSize: 0.01
                width: parent.width - 80
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
//            width: parent.width * 0.8

            Button {
                text: "◀️"
                onClicked: {
                    direction = -1
                    if (!paused) {
                        speedAnim.stop()
                        speedAnim.to = speed * direction
                        speedAnim.start()
                    }
                }
                background: Rectangle { color: direction === -1 ? "#4499ff" : "#666"; radius: 4 }
            }

            Button {
                text: "▶️"
                onClicked: {
                    direction = 1
                    if (!paused) {
                        speedAnim.stop()
                        speedAnim.to = speed * direction
                        speedAnim.start()
                    }
                }
                background: Rectangle { color: direction === 1 ? "#4499ff" : "#666"; radius: 4 }
            }
Button { text: "⚙️"; onClicked: page_stack.push("Settings.qml") }
                        Button {
            text: "i"
            onClicked:page_stack.push("AboutPage.qml")
            }
                                    Button {
            text: "❌"
            onClicked: Qt.quit()
            }
        }
    }

    // === ПАНЕЛЬ МУЗЫКИ ===
    Rectangle {
        id: musicPanel
        width: 250
        height: expanded ? 150 : 30
        color: "#222"
        opacity: 0.85
        radius: 8
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10
        property bool expanded: false

        Behavior on height { NumberAnimation { duration: 400; easing.type: Easing.InOutQuad } }

        Timer {
            id: hideTimer
            interval: 5000
            running: false
            repeat: false
            onTriggered: musicPanel.expanded = false
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                musicPanel.expanded = !musicPanel.expanded
                hideTimer.restart()
            }
        }

        Column {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 4

            Text { text: tracks[currentTrackIndex].title; color: "white"; font.pixelSize: 14 }

            Loader { active: musicPanel.expanded; sourceComponent: musicPanelControls }
        }
    }

    Component {
        id: musicPanelControls
        Column {
            spacing: 6
            Button {
                id: playPauseButton
                text: musicPlayer.playbackState === Audio.PlayingState ? "⏸️ Пауза" : "▶️ Воспроизвести"
                onClicked: {
                    if (musicPlayer.playbackState === Audio.PlayingState)
                        musicPlayer.pause()
                    else
                        musicPlayer.play()
                }

                Connections {
                    target: musicPlayer
                    onPlaybackStateChanged: playPauseButton.text =
                        musicPlayer.playbackState === Audio.PlayingState ? "⏸️ Пауза" : "▶️ Воспроизвести"
                }
            }
        }
    }
}
