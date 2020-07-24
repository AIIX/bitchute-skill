/*
 *  Copyright 2018 by Aditya Mehra <aix.m@outlook.com>
 *  Copyright 2020 Marco Martin <mart@kde.org>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.

 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.9
import QtQuick.Layouts 1.4
import QtQuick.Controls 2.3 as Controls
import org.kde.kirigami 2.8 as Kirigami

Controls.Button {
    id: control
    Layout.fillHeight: true
    Layout.fillWidth: true
    property var source
    property var btntext
    property bool hasText: false
    
    
    background: Rectangle {
        Kirigami.Theme.colorSet: Kirigami.Theme.Button
        color: control.activeFocus ? Kirigami.Theme.highlightColor : "transparent"

        Kirigami.Separator {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            color: Kirigami.Theme.highlightColor
            height: Kirigami.Units.smallSpacing
            visible: control.checked
        }
    }
    
    contentItem: Item {
        
        RowLayout {
                anchors.centerIn: parent
                spacing: Kirigami.Units.largeSpacing
                
            Image {
                id: contentHome
                Layout.preferredWidth: Kirigami.Units.iconSizes.medium
                Layout.preferredHeight: Kirigami.Units.iconSizes.medium
                Layout.alignment: hasText ? Qt.AlignLeft | Qt.AlignVCenter : Qt.AlignHCenter | Qt.AlignVCenter
                source: control.source
            }
            Controls.Label {
                id: contentHomeText
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                visible: hasText
                enabled: hasText
                text: control.btntext
            }
        }
    }
    
    Keys.onReturnPressed: {
        control.clicked()
    }
}
