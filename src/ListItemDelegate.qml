import com.meego 1.0
import QtQuick 1.0

Item {
    id: listItem
    signal checkChanged
    property string itemIndex: "0"
    property string itemText: "No text"
    property string itemSelected: "false"

    CheckBox {
        id: checkBox
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        checked: {
            if(itemSelected == "true")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        onClicked: {
            if(checkBox.checked)
            {
                itemSelected = "true";
            }
            else
            {
                itemSelected = "false";
            }
            checkBoxText.text = getText();
            checkChanged();
        }
    }
    Label {
        id: checkBoxText
        text: getText()
        font.family: "Helvetica"
        font.pixelSize: 26
        anchors.left: checkBox.right
        anchors.verticalCenter: checkBox.verticalCenter
    }

    Rectangle {
        id: divisionLine
        color: "#ccc"
        height: 1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }


    function getText()
    {
        if(itemSelected == "true")
        {
            checkBoxText.font.strikeout = true;
            return itemText;
        }
        else
        {
            return itemText;
        }
    }
}
