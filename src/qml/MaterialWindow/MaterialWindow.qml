import QtQuick 2.0
import Material 0.1
import QtGraphicalEffects 1.0

ApplicationWindow {
    title: "Application Name"
    color: "transparent"
    flags:   root.app.customFrame ? Qt.FramelessWindowHint : Qt.Window
    id: __window
    width: 1000
    height: 640
    theme {
        id: theme
        primaryColor: "#F44336"
        primaryDarkColor: "#D32F2F"
        accentColor: "#FF5722"
        backgroundColor: "transparent"
    }
    visible: true
    property var initialPageFrameLess
    default property alias content : frame.children
    property alias minSize: resizeArea.minSize

    ResizeArea{
        id:resizeArea
        anchors.fill: parent
        dragHeight: root.app.customFrame ? systemBar.height : 0
        anchors.margins: root.app.customFrame ? 8 : 0
        target: __window
        minSize: Qt.size(600,400)
        enabled: true

        RectangularGlow {
            id: outGlow
            anchors.fill: frame
            anchors.margins: root.app.customFrame ? 5 : 0
            anchors.bottomMargin: 0
            glowRadius: root.app.customFrame ? 10 : 0
            spread: 0.1
            color: "#A0000000"
            cornerRadius: frame.radius + glowRadius
        }

        Rectangle{
            id: frame
            border{width: 0; color: activeTab.customColor ? colorLuminance(activeTab.customColor, -0.1) : "#EFEFEF"}
            anchors.fill: parent
            anchors.margins: root.app.customFrame ? 9 : 0
            color: "white"
            smooth: true

            SystemBar {
                id: systemBar
                visible: root.app.customFrame
            }

            Toolbar {
                id: __toolbar
                anchors.margins: 1
                anchors.topMargin: 0
                anchors.top: systemBar.bottom
            }


            PageStack {
                id: __pageStack
                initialItem: __window.initialPageFrameLess
                anchors {
                left: parent.left
                right: parent.right
                top: root.app.customFrame ?  __toolbar.bottom : parent.top
                bottom: parent.bottom
            }

            onPushed: __toolbar.push(page)
            onPopped: __toolbar.pop()
            onReplaced: __toolbar.replace(page)
            }

            OverlayLayer {
                    id: dialogOverlayLayer
                    objectName: "dialogOverlayLayer"
                }

            OverlayLayer {
                id: tooltipOverlayLayer
                objectName: "tooltipOverlayLayer"
            }

            OverlayLayer {
                id: overlayLayer
            }

        }
    }

    Item{
        state:__window.visibility
        states: [
            State {
                name: "2"   /*Windowed*/
                PropertyChanges { target: resizeArea; anchors.margins: root.app.customFrame ? 8 : 0; enabled: true }
                PropertyChanges { target: outGlow; visible: true }
                PropertyChanges { target: frame; anchors.margins: root.app.customFrame ? 4 : 0; border.width: 0;  }
            },
            State {
                name: "4"   /*FullScreen*/
                PropertyChanges { target: resizeArea; anchors.margins: 0; enabled: false }
                PropertyChanges { target: outGlow; visible: false }
                PropertyChanges { target: frame; anchors.margins: 0; border.width: 0; }
            }
        ]
    }

    function colorLuminance(hex, lum) {
    	hex = String(hex).replace(/[^0-9a-f]/gi, '');
    	if (hex.length < 6) {
    	       hex = hex[0]+hex[0]+hex[1]+hex[1]+hex[2]+hex[2];
    	}
    	lum = lum || 0;
    	var rgb = "#", c, i;
    	for (i = 0; i < 3; i++) {
    		c = parseInt(hex.substr(i*2,2), 16);
    		c = Math.round(Math.min(Math.max(0, c + (c * lum)), 255)).toString(16);
    		rgb += ("00"+c).substr(c.length);
    	}

    	return rgb;
    }


}
