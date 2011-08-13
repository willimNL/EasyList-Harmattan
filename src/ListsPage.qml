import com.meego 1.0
import QtQuick 1.0
import "settingsDb.js" as SettingsDb
import "listsDb.js" as ListsDb

Page {
    id: listsPage
    property string listName: SettingsDb.getListName()

    Rectangle {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 70
        color: "#333"
        z: 1
        Text {
            id: title
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "EasyList - Lists"
            font.pointSize: 30
            color: "#fff"
        }
    }

    Rectangle {
        id: saveArea
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: saveAsButton.height
        z: 1
        TextField {
            id: textField
            anchors.left: parent.left
            anchors.right: saveAsButton.left
            anchors.topMargin: 5
            anchors.top: parent.top
        }
        ToolIcon {
            id: saveAsButton
            iconId: "toolbar-done";
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                if(listName.length > 0)
                {
                    ListsDb.saveAs(listName, textField.text);
                    listName = textField.text;
                    SettingsDb.setListName(listName);
                    reloadDb();
                }
            }
        }
    }


    ListModel {
        id: listModel
    }
    ListView {
        id: listView
        anchors.top: saveArea.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        model: ListsDb.getListsModel()
        delegate: itemComponent
        highlight: highlight
    }
    ScrollDecorator {
        flickableItem: listView
    }

    Component {
        id: itemComponent
        ListsItemDelegate {
            id: listsItem
            listName: model.listName
            height: 55
            width: listView.width

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    listView.currentIndex = index;
                    listName = listView.currentItem.listName;
                    SettingsDb.setListName(listName);
                    reloadDb();
                }
            }
        }
    }

    Component {
        id: highlight
        Rectangle {
            width: listView.width;
            height: 55
            color: "lightsteelblue";
            Behavior on y {
                SpringAnimation {
                    spring: 3
                    damping: 0.2
                }
            }
        }
    }

    function reloadDb()
    {
        ListsDb.getListsModel();
        listName = SettingsDb.getListName();
        var num = listModel.count;
        for(var i = 0; i < num; ++i)
        {
            textField.text = listName;
            if(listModel.get(i).listName == listName)
            {
                listView.currentIndex = i;
                break;
            }
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
                if(listModel.count > 0)
                {
                    removeDialog.open();
                }
            }
        }
    }

    QueryDialog {
        id: removeDialog
        titleText: "Remove list?"
        message: "Do you really want to remove [" + listName + "] and all its items?"
        acceptButtonText: "Ok"
        rejectButtonText: "Cancel"
        onAccepted: {
            ListsDb.removeList(listName);
            reloadDb();
        }
    }

    onVisibleChanged: {
        if(visible)
        {
            reloadDb();
        }
    }
}
