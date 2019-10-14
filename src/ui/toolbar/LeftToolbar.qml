import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import QGroundControl.ScreenTools           1.0

Rectangle { // Custom drawer
    id: leftMenu
    x: -width
    width: buttonsMenu.width
    color: "black"
    property ButtonGroup menuButtonsGroup: menuButtonsGroup

    ListModel {
        id: buttonModel
        ListElement {
            text: "Settings";
            icon: "qrc:/qmlimages/settings.svg";
            page: "qrc:/qml/UnitsSettings.qml" }
        ListElement {
            text: "Mission Planner";
            icon: "qrc:/qmlimages/waypoint.svg";
            page: "" }
    }

    ButtonGroup {
        id: menuButtonsGroup
        exclusive: true;
    }

    ListView {
        id: buttonsMenu
        spacing: 1
        implicitWidth: contentItem.childrenRect.width
        height: parent.height

        model: buttonModel
        delegate: Button {
            id: menuButton
            property alias cursorShape: buttonMouseArea.cursorShape
            cursorShape: Qt.PointingHandCursor
            anchors { left: parent.left; right: parent.right }
            height: ScreenTools.defaultFontPixelHeight * 3
            checkable: true
            text: model.text;
            enabled: true
            hoverEnabled: true;
            ButtonGroup.group: menuButtonsGroup
            background: Rectangle {
                color: parent.checked ? "#1c2171" : "black"
            }
            onClicked: settingsPageLoader.source = model.page

            MouseArea {
                id: buttonMouseArea
                anchors.fill: parent
                hoverEnabled: true
                /// Pass signal transparently to upper Button
                onPressed:  mouse.accepted = false
            }

            contentItem: Row {
                id: row
                spacing: ScreenTools.defaultFontPixelHeight
                leftPadding: ScreenTools.defaultFontPixelHeight
                rightPadding: ScreenTools.defaultFontPixelHeight
                Image {
                    source: model.icon
                    anchors.verticalCenter: parent.verticalCenter
                    width: ScreenTools.defaultFontPixelHeight
                    height: ScreenTools.defaultFontPixelHeight
                    fillMode: Image.PreserveAspectFit

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: parent.parent.parent.hovered ? "#00ffc8" : "transparent"
                    }
                }
                Text {
                    text: model.text
                    font.pixelSize: ScreenTools.defaultFontPixelHeight
                    anchors.verticalCenter: parent.verticalCenter
                    color: parent.parent.hovered ? "#00ffc8" : "white"
                }
            }
            HorizontalSeparator { }
        }
    }

    states: [
        State {
            name: "slideOut"; when: leftMenu.slideOut
            PropertyChanges { target: leftMenu; x: 0; }
        },
        State {
            name: "slideIn"; when: leftMenu.slideIn
            PropertyChanges { target: leftMenu; x: -width; }
        }
    ]

    transitions: [
        Transition {
            to: "slideOut"
            NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 400; loops: 1 }
        },
        Transition {
            to: "slideIn"
            NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 400; loops: 1 }
        }
    ]
}
