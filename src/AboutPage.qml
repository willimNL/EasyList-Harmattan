import com.nokia.meego 1.0
import QtQuick 1.1
import "settingsDb.js" as SettingsDb

Page {
    id: aboutPage
    property color backgroundColor: SettingsDb.getValue("BACKGROUND_COLOR")
    property color headerBackgroundColor: SettingsDb.getValue("HEADER_BACKGROUND_COLOR")
    property color headerTextColor: SettingsDb.getValue("HEADER_TEXT_COLOR")
    property color textColor: SettingsDb.getValue("TEXT_COLOR")
    orientationLock: SettingsDb.getOrientationLock();
    property string version: "0.0.19";

    Flickable {
        id: flick
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: background.implicitHeight
        contentWidth: background.implicitWidth
        flickableDirection: Flickable.VerticalFlick
        clip: true
        Rectangle {
            id: background
            color: backgroundColor
            implicitWidth: flick.width
            implicitHeight: flick.height
            Rectangle {
                id: header
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 70
                color: headerBackgroundColor
                z: 10
                Label {
                    id: title
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    text: qsTr("EasyList - About")
                    font.pixelSize: 32
                    color: headerTextColor
                }
            }

            Text {
                id: text1
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Helvetica"
                font.pointSize: 48
                text: "<a href='http://willemliu.nl/donate/'>EasyList</a>"
                onLinkActivated: {
                    Qt.openUrlExternally(link);
                }
                color: textColor
            }
            Text {
                id: text2
                anchors.top: text1.bottom
                anchors.horizontalCenter: text1.horizontalCenter
                font.family: "Helvetica"
                font.pointSize: 16
                text: version
                color: textColor
            }
            Text {
                id: text3
                anchors.top: text2.bottom
                anchors.horizontalCenter: text2.horizontalCenter
                font.family: "Helvetica"
                font.pointSize: 24
                text: qsTr("Created with Qt")
                color: textColor
            }
            Text {
                id: text4
                anchors.top: text3.bottom
                anchors.horizontalCenter: text3.horizontalCenter
                font.family: "Helvetica"
                font.pointSize: 24
                text: qsTr("Created by <a href='http://willemliu.nl/donate/'>Willem Liu</a>")
                onLinkActivated: {
                    Qt.openUrlExternally(link);
                }
                color: textColor
            }
            Text {
                id: text5
                anchors.top: text3.bottom
                anchors.horizontalCenter: text3.horizontalCenter
                font.family: "Helvetica"
                font.pointSize: 24
                text: qsTr("Thanks to:") + "<br>" +
                      "Oytun Eren Şengül" + "<br>" +
                      "Stanislav"
                onLinkActivated: {
                    Qt.openUrlExternally(link);
                }
                color: textColor
            }
        }
    }

    QueryDialog {
        id: removeDialog
        titleText: qsTr("Drop tables?")
        message: qsTr("Do you really want to remove all tables used by EasyList?")
        acceptButtonText: qsTr("Ok")
        rejectButtonText: qsTr("Cancel")
        onAccepted: {
            SettingsDb.removeTables();
        }
    }

    tools: ToolBarLayout {
        id: myToolbar
        ToolIcon {
            iconId: "toolbar-back";
            onClicked: {
                pageStack.pop();
            }
        }
        ToolIcon {
            iconId: "toolbar-delete";
            onClicked: {
                removeDialog.open();
            }
        }
    }

    function loadTheme()
    {
        SettingsDb.loadTheme();
        backgroundColor = SettingsDb.getValue("BACKGROUND_COLOR");
        headerBackgroundColor = SettingsDb.getValue("HEADER_BACKGROUND_COLOR");
        headerTextColor = SettingsDb.getValue("HEADER_TEXT_COLOR");
        textColor = SettingsDb.getValue("TEXT_COLOR");
    }
}
