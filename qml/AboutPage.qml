import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Suru 2.2
import "aboutpage"
import "common" as Common
import "common/pages" as Pages
import "common/listitems" as ListItems
import Lomiri.Components 1.3
Pages.BasePage {
    id: aboutPage
    title: i18n.tr("About %1").arg("Ying-Yang")
    flickable: aboutFlickable
header:  PageHeader  {
id: pageHeader
                        title: i18n.tr("About this app")
                        leadingActionBar.actions:[
                        Action {
                        objectName: "action"

                        iconName: "go-back"
                        text: i18n.tr("Go Back")

                        onTriggered: {
                       page_stack.pop(YingYang.qml)
                        }
                    }
                    ]
                  }
    Common.BaseFlickable {
        id: aboutFlickable
        
        anchors.fill: parent
        contentHeight: listView.height + iconComponent.height + Suru.units.gu(5)
        boundsBehavior: Flickable.DragOverBounds
        pageHeader: aboutPage.pageManager ? aboutPage.pageManager.pageHeader : null

        ScrollIndicator.vertical: ScrollIndicator { }

        IconComponent {
            id: iconComponent

            anchors {
                top: parent.top
                topMargin: Suru.units.gu(2)
                left: parent.left
                right: parent.right
            }
        }

        ListView {
            id: listView

            model: aboutModel
            height: contentHeight
            interactive: false

            anchors {
                top: iconComponent.bottom
                topMargin: Suru.units.gu(2)
                left: parent.left
                right: parent.right
            }

            section {
                property: "section"
                delegate: SectionItem { text: section }
            }

            delegate: ListItems.NavigationDelegate {
                text: model.text
                icon.name: model.icon
                icon.color: Suru.foregroundColor
                progressionIcon.color: Suru.foregroundColor
                progressionIcon.name: "external-link"
                tooltipText: model.subText
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Suru.units.gu(1)
                }

                onClicked: {
                    Qt.openUrlExternally(urlText)
                }
            }
        }

        ListModel {
            id: aboutModel
            
            Component.onCompleted: fillData()
    
            function fillData() {
              
                append({"section": i18n.tr("Support"), "text": i18n.tr("Report a bug"), "subText": "", "icon": "mail-mark-important"
                                                                , "urlText": "https://github.com/Khmelyauskas-Alexander-Eduardovich/Ying-Yang-Relax-app-/issues"})
                append({"section": i18n.tr("Support"), "text": i18n.tr("Contact Developer"), "subText": "", "icon": "stock_email"
                                                                , "urlText": "t.me://Knyaz_Dirizher"})
                append({"section": i18n.tr("Support"), "text": i18n.tr("View source"), "subText": "", "icon": "stock_document"
                                                                , "urlText": "https://github.com/Khmelyauskas-Alexander-Eduardovich/Ying-Yang-Relax-app-"})
                append({"section": i18n.tr("Support"), "text": i18n.tr("Donate to Kugi via LibrePay"), subText: i18n.tr("Kugi has helped me with developing this app. Donate to him please 🙏"), "icon": "like"
                                                                , "urlText": "https://liberapay.com/kugi_eusebio/donate"})
                append({"section": i18n.tr("Support"), "text": i18n.tr("Donate to Kugi via PayPal"), subText: "Kugi has helped me with developing this app. Donate to him please 🙏", "icon": "like"
                                                                , "urlText": "http://www.paypal.me/Kugi"})
                append({"section": i18n.tr("Support"), "text": i18n.tr("View in OpenStore"), "subText": "", "icon": "ubuntu-store-symbolic"
                                                                , "urlText": "openstore://ying-yang.khmelyauskas"})
                append({"section": i18n.tr("Developers"), "text": "JasonWalt Bab@", "subText": i18n.tr("Main developer"), "icon": ""
                                                                , "urlText":"https://github.com/Khmelyauskas-Alexander-Eduardovich"})                                                                
                append({"section": i18n.tr("Icon"), "text": "JasonWalt Bab@", "subText": i18n.tr("I am drawn this logo in Inkscape and in AI (Adobe Illustrator)"), "icon": ""
                                                                , "urlText": "mailto:mardimusa8@gmail.com"})                                                
                
                append({"section": i18n.tr("Powered by"), "text": "Kugi's Tagatuos (Tagatous2) app components", "subText": i18n.tr("Date and time pickers"), "icon": ""
                                                                , "urlText": "https://github.com/kugiigi/tagatuos-app"})
            }
        }
    }

}
