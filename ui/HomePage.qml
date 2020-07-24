/*
 *  Copyright 2018 by Aditya Mehra <aix.m@outlook.com>
 *  Copyright 2018 Marco Martin <mart@kde.org>
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
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.3
import org.kde.kirigami 2.8 as Kirigami
import Mycroft 1.0 as Mycroft
import "views" as Views
import "delegates" as Delegates

Mycroft.Delegate {
    id: delegate
    property bool busyIndicate: false
    
    fillWidth: true
    
    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    bottomPadding: 0

    skillBackgroundSource: sessionData.bgImage ? "https://source.unsplash.com/weekly?" + sessionData.bgImage : "https://source.unsplash.com/weekly?music"
    
    function highlightActiveCategory(cat){
        switch(cat){
            case "Home":
                //historyCatButton.checked = false
                searchCatButton.checked = false
                homeCatButton.checked = true
                break;
            case "History":
                searchCatButton.checked = false
                homeCatButton.checked = false
                //historyCatButton.checked = true
                break;
            case "Search":
                homeCatButton.checked = false
                //historyCatButton.checked = false
                searchCatButton.checked = true
                break;
        }
    }
        
    Connections {
        target: Mycroft.MycroftController
        onIntentRecevied: {
            if(type == "speak") {
                busyIndicatorPop.close()
                busyIndicate = false
            }
        }
    }
    
    onFocusChanged: {
        busyIndicatorPop.close()
        busyIndicate = false
    }
    
    Keys.onBackPressed: {
        parent.parent.parent.currentIndex++
        parent.parent.parent.currentItem.contentItem.forceActiveFocus()
    }
    
    
    contentItem: ColumnLayout {
        id: colLay1
        
        Rectangle {
            color: Qt.rgba(0, 0, 0, 0.8)
            Layout.fillWidth: true
            Layout.preferredHeight: Kirigami.Units.gridUnit * 3 
            Layout.maximumHeight: Kirigami.Units.gridUnit * 4
            z: 100
            
            TopBarTabButton {
                id: backButton
                source: "images/back.png"
                anchors.left: parent.left
                anchors.leftMargin: Kirigami.Units.largeSpacing
                width: Kirigami.Units.iconSizes.medium
                height: parent.height
                
                onClicked: {
                    delegate.parent.backRequested()
                }
            }
           
            RowLayout {
                id: categoryRepeater
                anchors {
                    left: backButton.right
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                anchors.leftMargin: Kirigami.Units.gridUnit
                anchors.rightMargin: Kirigami.Units.gridUnit
                
                TopBarTabButton {
                    id: homeCatButton
                    checked: true
                    source: "images/home.png"
                    btntext: "Home"
                    hasText: true
                    onClicked: {
                        categoryLayout.pop(categoryLayout.find(function(item) { return item.name == "homeCat";}))
                        highlightActiveCategory("Home")
                    }
                }
                
//                 TopBarTabButton {
//                     id: historyCatButton
//                     checked: false
//                     source: "images/history.png"
//                     btntext: "History"
//                     hasText: true 
//                     onClicked: {
//                         if(categoryLayout.depth >= 2) {
//                             categoryLayout.pop(null)
//                         }
//                         categoryLayout.push(historyCat)
//                         highlightActiveCategory("History")
//                     }
//                 }
                
                TopBarTabButton {
                    id: searchCatButton
                    checked: false
                    source: "images/search.png"
                    btntext: "Search"
                    hasText: true
                    onClicked: {
                        if(categoryLayout.depth >= 2) {
                            categoryLayout.pop(null)
                        }
                        categoryLayout.push(searchCat)
                        highlightActiveCategory("Search")
                    }
                }
            }
        }
        
        Component {
            id: homeCat
            CategoryBoxHomeView {
                id: homeCatView
            }
        }
        
        Component {
            id: historyCat
            CategoryBoxHistoryView {
                id: historyCatView
            }
        }
        
        Component {
            id: searchCat
            CategoryBoxSearchView  {
                id: searchCatView
            }
        }
        
        StackView {
            id: categoryLayout
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            Component.onCompleted: {
                categoryLayout.push(homeCat)
            }
        }
    }
    
    Popup {
        id: busyIndicatorPop
        width: parent.width
        height: parent.height
        background: Rectangle {
            anchors.fill: parent
            color: Qt.rgba(0, 0, 0, 0.5)
        }
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        
        BusyIndicator {
            running: busyIndicate
            anchors.centerIn: parent
        }
        
        onOpened: {
            busyIndicate = true
        }
        
        onClosed: {
            busyIndicate = false
        }
    }
}

