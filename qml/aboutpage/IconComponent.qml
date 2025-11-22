import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Suru 2.2
import QtQuick.Layouts 1.3
import Lomiri.Components 1.3 as UT

ColumnLayout {
    id: iconComponent

    spacing: Suru.units.gu(1)

    UT.LomiriShape {
        id: iconShape
        
        Layout.preferredWidth: Suru.units.gu(20)
        Layout.preferredHeight: Layout.preferredWidth
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        
        aspect: UT.LomiriShape.Flat
        radius: "large"

        source: Image {
            source: "../icon.svg"
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            asynchronous: true
        }
    }

    Label {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        Suru.textLevel: Suru.Paragraph
        text: i18n.tr("JasonWalt Bab@'s")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Label {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
font.bold: true
        Suru.textLevel: Suru.Paragraph
        text: i18n.tr("Ying-Yang")
        font.pixelSize: 50
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        onLinkActivated: {
            flickable.externalLinkConfirmation(link)
        }
    }
}
