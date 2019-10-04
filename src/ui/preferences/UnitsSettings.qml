import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import QGroundControl                       1.0
import QGroundControl.SettingsManager       1.0
import QGroundControl.FactSystem            1.0
import QGroundControl.FactControls          1.0

Item {
    anchors.fill: parent
    FontMetrics {
        id: fontMetrics
        font.family: "Arial"
        font.pixelSize: 18
    }

    Rectangle {
        id: unitsPage
        anchors.fill: parent
        color: "black"

        ListModel {
            id: unitsModel
            Component.onCompleted: {
                append({
                    text: qsTr("Distance"),
                    units: QGroundControl.settingsManager.unitsSettings.distanceUnits
                })
                append({
                    text: qsTr("Altitude"),
                    units: QGroundControl.settingsManager.unitsSettings.distanceUnits
                })
                append({
                    text: qsTr("Area"),
                    units: QGroundControl.settingsManager.unitsSettings.areaUnits
                })
                append({
                    text: qsTr("Speed"),
                    units: QGroundControl.settingsManager.unitsSettings.speedUnits
                })
            }
        }

        ListView {
            id: settingsView
            anchors {
                top: parent.top;
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width * 0.85
            height: parent.height

            model: unitsModel

            header: Item {
                id: header
                width: settingsView.width
                height: fontMetrics.height * 3

                Text {
                    color: "grey"
                    text: qsTr("UNITS")
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    font: fontMetrics.font
                    anchors.verticalCenter: parent.verticalCenter
                }
                HorizontalSeparator { }
            }

            delegate: Item {
                id: element
                width: settingsView.width
                height: fontMetrics.height * 5

                Column {
                    anchors.topMargin: fontMetrics.height
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8
                    Text {
                        color: "white"
                        text: model.text
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        font: fontMetrics.font
                    }
                    UnitsCombobox {
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        fact: units
                        width: element.width / 2
                        font: fontMetrics.font
                    }
                }

                HorizontalSeparator { }
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
