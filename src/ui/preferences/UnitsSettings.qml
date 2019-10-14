import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import QGroundControl                       1.0
import QGroundControl.SettingsManager       1.0
import QGroundControl.FactSystem            1.0
import QGroundControl.FactControls          1.0
import QGroundControl.ScreenTools           1.0

Item {
    anchors.fill: parent

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
            width: parent.width * 0.9
            height: parent.height

            model: unitsModel

            header: Item {
                id: header
                width: settingsView.width
                height: ScreenTools.defaultFontPixelHeight * 3

                Text {
                    color: "grey"
                    text: qsTr("UNITS")
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    font.pixelSize: ScreenTools.defaultFontPixelHeight
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
                HorizontalSeparator { }
            }

            delegate: Item {
                id: element
                width: settingsView.width
                height: ScreenTools.defaultFontPixelHeight * 5

                Column {
                    anchors.topMargin: ScreenTools.defaultFontPixelHeight
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8
                    Text {
                        color: "white"
                        text: model.text
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        font.pixelSize: ScreenTools.defaultFontPixelHeight
                    }
                    UnitsCombobox {
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        fact: units
                        width: element.width / 2
                        font.pixelSize: ScreenTools.defaultFontPixelHeight
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
