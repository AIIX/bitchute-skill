/*
 *  Copyright 2018 by Aditya Mehra <aix.m@outlook.com>
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

Item {    
    property var newsListModel: sessionData.newsListBlob.videoList
    property var musicListModel: sessionData.musicListBlob.videoList
    property var techListModel: sessionData.techListBlob.videoList
    property var polListModel: sessionData.polListBlob.videoList
    property var gamingListModel: sessionData.gamingListBlob.videoList
    property var searchListModel: sessionData.searchListBlob.videoList
    property var historyListModel: sessionData.historyListBlob.videoList
    
    
    Layout.fillWidth: true
    Layout.fillHeight: true
    
    onNewsListModelChanged: {
       newsListView.view.forceLayout()
    }
    onMusicListModelChanged: {
       musicListView.view.forceLayout()
    }
    onTechListModelChanged: {
       techListView.view.forceLayout()
    }
    onPolListModelChanged: {
       polListView.view.forceLayout()
    }
    onGamingListModelChanged: {
       gamingListView.view.forceLayout()
    }
    
    Flickable {
        width: parent.width
        height: parent.height
        contentHeight: contentLayout.implicitHeight
    
        ColumnLayout {
            id: contentLayout
            anchors {
                left: parent.left
                right: parent.right
                margins: Kirigami.Units.largeSpacing * 3
            }
            property Item currentSection
            readonly property int rowHeight: newsListView.cellWidth / 1.8 + Kirigami.Units.gridUnit * 7
            y: currentSection ? -currentSection.y : 0

            Behavior on y {
                NumberAnimation {
                    duration: Kirigami.Units.longDuration * 2
                    easing.type: Easing.InOutQuad
                }
            }

            spacing: Kirigami.Units.largeSpacing * 4

            Views.TileView {
                id: newsListView
                focus: false
                model: newsListModel
                title: "News"
                cellWidth: parent.width / 2
                delegate: Delegates.ListVideoCard{}
                implicitHeight: contentLayout.rowHeight
            }
            
            Views.TileView {
                id: musicListView
                model: musicListModel
                title: "Music"
                cellWidth: parent.width / 2
                delegate: Delegates.ListVideoCard{}
                implicitHeight: contentLayout.rowHeight
            }
            
            Views.TileView {
                id: techListView
                model: techListModel
                title: "Technology"
                cellWidth: parent.width / 2
                delegate: Delegates.ListVideoCard{}
                implicitHeight: contentLayout.rowHeight
            }
            
            Views.TileView {
                id: polListView
                model: polListModel
                title: "Politics"
                cellWidth: parent.width / 2
                delegate: Delegates.ListVideoCard{}
                implicitHeight: contentLayout.rowHeight
            }
            
            Views.TileView {
                id: gamingListView
                model: gamingListModel
                title: "Gaming"
                cellWidth: parent.width / 2
                delegate: Delegates.ListVideoCard{}
                implicitHeight: contentLayout.rowHeight
            }
        }
    }
}