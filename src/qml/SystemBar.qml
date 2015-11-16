import Material 0.1
import QtQuick 2.2

Rectangle {

    anchors {
        top: parent.top;
        left: parent.left;
        right: parent.right;
        margins: 0
        bottomMargin: 0
    }

    height: tabsModel.count > 1 || root.app.integratedAddressbars ? root.tabHeight : Units.dp(30)
    color: /* root.currentTabColorDarken*/ root.app.shadeBehindTabs ? Qt.rgba(0,0,0,0.05) : Qt.rgba(0,0,0,0)
}
