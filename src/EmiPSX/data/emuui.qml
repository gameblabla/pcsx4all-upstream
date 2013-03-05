/***********************************************************
Copyright (C) 2013 AndreBotelho(andrebotelhomail@gmail.com)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the
Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02111-1307 USA.
***********************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1    // Symbian components


Rectangle {
    id: menuBase
    width: 640
    height: 360
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#69acdb"
        }

        GradientStop {
            position: 1
            color: "#0b1220"
        }
    }
    objectName: "mainMenu"
    property bool active: true
    signal emuContinue
    signal getRomFile
    signal saveState
    signal loadState
    signal resetEmu
    signal exitEmu
    signal saveConfig
    signal saveVControl
    signal runKeyConfig
    signal setKey(int witch, int value)
    signal vctvalueChanged(int value)
    signal stChanged(int value)
    signal zoomChanged(int value)
    signal volumeChanged(int value)
    signal romLoaded
    signal getRomDir
    signal getSaveDir
    signal updateRomDir
    signal updateSaveDir
    function updateimgs() { menuBase.romLoaded() }  // slot
    function upRomDir() {
        menuBase.updateRomDir()
    }  // slot
    function upSaveDir() {
        menuBase.updateSaveDir()
    }  // slot
    property string romdir: "E:/Data"
    property string savedir: "E:/Data"
    property int activeTab: 1


    Item {
        id: tab1
        x: 0
        y: -360
        width: 640
        height: 360
        state: "active"
        Button {
            id: btnLoad
            x: 59
            y: 27
            width: 242
            height: 43
            anchors.left: parent.left
            anchors.right: parent.right
            text: "Load New Rom"
            anchors.leftMargin: 59
            anchors.rightMargin: 339
            onClicked:
                menuBase.getRomFile()
        }

        Button {
            id: btnContinue
            x: 38
            y: 77
            width: 242
            height: 46
            text: "Continue Game"
            anchors.rightMargin: 361
            anchors.right: parent.right
            anchors.leftMargin: 38
            anchors.left: parent.left
            onClicked:
                menuBase.emuContinue()
        }

        Button {
            id: btnReset
            x: 26
            y: 132
            width: 242
            height: 44
            text: "Reset"
            anchors.rightMargin: 372
            anchors.right: parent.right
            anchors.leftMargin: 26
            anchors.left: parent.left
            onClicked:
                menuBase.resetEmu()
        }

        Button {
            id: btnExit
            x: 90
            y: 293
            width: 242
            height: 44
            text: "Exit"
            anchors.rightMargin: 308
            anchors.right: parent.right
            anchors.leftMargin: 90
            anchors.left: parent.left
            onClicked:
                menuBase.exitEmu()
        }

        Button {
            id: btnLoadState
            x: 536
            y: 96
            width: 93
            height: 42
            text: "Load"
            z: 1
            anchors.rightMargin: 12
            anchors.right: parent.right
            anchors.leftMargin: 536
            anchors.left: parent.left
            onClicked:
                menuBase.loadState()
        }

        Button {
            id: btnSaveState
            x: 535
            y: 259
            width: 94
            height: 42
            text: "Save"
            z: 1
            anchors.rightMargin: 11
            anchors.right: parent.right
            anchors.leftMargin: 535
            anchors.left: parent.left
            onClicked: menuBase.saveState()
        }

        Button {
            id: buttonmenu
            x: 26
            y: 185
            width: 242
            height: 46
            rotation: 0
            text: "Configuration"
            onClicked:
                menuBase.activeTab = 2
        }

        Button {
            id: buttonabout1
            x: 35
            y: 239
            width: 247
            height: 45
            text: "About"
            z: 1
            clip: false
            rotation: 0
            opacity: 1
            onClicked:
                menuBase.activeTab = 3
        }

        PathView {
                id: path_view1
                objectName: "savePathView"
                x: 338
                y: 32
                width: 276
                height: 261
                path: Path {
                    startY: 0
                    startX: 230
                    PathAttribute { name: "iconScale"; value: 0.5 }
                    PathAttribute { name: "iconOpacity"; value: 0.5 }
                    PathAttribute { name: "iconZ"; value: -1 }
                    PathQuad {
                        x: 100
                        y: 65
                        controlY: 30
                        controlX: 65
                    }
                    PathAttribute { name: "iconScale"; value: 1.0 }
                    PathAttribute { name: "iconOpacity"; value: 1.0 }
                    PathAttribute { name: "iconZ"; value: 1 }
                    PathQuad {
                        x: 230
                        y: 261
                        controlY: 195
                        controlX: 65
                    }
                    PathQuad {
                        x: 230
                        y: 0
                        controlY: 130
                        controlX: 230
                    }
                }
                delegate: Component {
                   Item{
                        width: 220
                        height: 220
                        scale: PathView.iconScale
                        opacity: PathView.iconOpacity
                        z: PathView.iconZ
                        Column {
                            spacing: 1
                            Text { id: nameText; text: name; font.pointSize: 16 }
                            Rectangle {
                                width: 210
                                height: 210
                                color: colorCode
                                anchors.horizontalCenter: parent.horizontalCenter
                                Image{
                                    id: currentImage
                                    cache: false;
                                    anchors.centerIn: parent;
                                    width: 200;
                                    height: 200;
                                    source: image;
                                    Connections{
                                        target: menuBase
                                        onRomLoaded:{ //update images
                                            currentImage.source = "";
                                            currentImage.source = image;
                                        }

                                    }
                                }

                            }
                        }
                    }
                }
                model: ListModel {
                    ListElement {
                        name: "Slot 5"
                        colorCode: "white"
                        image: "image://saves/4"
                    }
                    ListElement {
                        name: "Slot 6"
                        colorCode: "red"
                        image: "image://saves/5"
                    }
                    ListElement {
                        name: "Slot 1"
                        colorCode: "blue"
                        image: "image://saves/0"
                    }
                    ListElement {
                        name: "Slot 2"
                        colorCode: "green"
                        image: "image://saves/1"
                    }
                    ListElement {
                        name: "Slot 3"
                        colorCode: "gray"
                        image: "image://saves/2"
                    }
                    ListElement {
                        name: "Slot 4"
                        colorCode: "yellow"
                        image: "image://saves/3"
                    }
                }
                onMovementEnded: menuBase.stChanged( currentIndex )
            }

            Rectangle {
                id: rectangle1
                x: 343
                y: 26
                width: 255
                height: 48
                color: "#64362d2d"
                radius: 20
                border.width: 2
                border.color: "#2f2b2b"

                Text {
                    id: text8
                    x: 13
                    y: 2
                    width: 229
                    height: 46
                    text: qsTr("State Selection")
                    clip: false
                    font.italic: false
                    verticalAlignment: Text.AlignVCenter
                    styleColor: "#f5e8e8"
                    smooth: false
                    z: 6
                    font.pixelSize: 35
                    style: Text.Outline
                    font.underline: false
                    font.bold: true
                    font.family: "Times New Roman"
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            states:
                State {
                name: "active"; when: menuBase.activeTab == 1;
                PropertyChanges { target: tab1; x: 0; y: 0 }
                }
            transitions:
                Transition {
                NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.InOutQuad }
                }
    }

    Item {
        id: tab2
        x: 1280
        y: 0
        width: 640
        height: 360
        Button {
            id: buttonconfig
            x: 271
            y: 143
            z: 1
            width: 100
            height: 43
            rotation: 0
            text: "Return"
            onClicked:
                menuBase.activeTab = 2
        }

        Rectangle {
            id: menurect
            x: 10
            y: 312
            width: 80
            height: 40
            color: "#00000000"
            border.color: "#000000"
            objectName: "menubtn"
            MouseArea {
                anchors.fill: parent
                drag.target: menurect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: tab2.width - menurect.width
                drag.minimumY: 0
                drag.maximumY: tab2.height - menurect.height
            }
            Image {
                id: menuImage
                fillMode: Image.Stretch
                anchors.fill: parent
                source: "mbutton.png"
            }
        }

        Rectangle {
            id: yrect
            x: 450
            y: 240
            width: 60
            height: 60
            color: "#00000000"
            border.color: "#000000"
            objectName: "ybtn"
            MouseArea {
                anchors.fill: parent
                drag.target: yrect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: tab2.width - yrect.width
                drag.minimumY: 0
                drag.maximumY: tab2.height - yrect.height
            }
            Image {
                id: yimage
                anchors.fill: parent
                source: "buttonS.png"
                fillMode: Image.PreserveAspectFit
            }
        }

        Rectangle {
            id: brect
            x: 510
            y: 290
            width: 60
            height: 60
            color: "#00000000"
            border.color: "#000000"
            objectName: "bbtn"
            MouseArea {
                anchors.fill: parent
                drag.target: brect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: tab2.width - brect.width
                drag.minimumY: 0
                drag.maximumY: tab2.height - brect.height
            }
            Image {
                id: bimage
                anchors.fill: parent
                source: "buttonX.png"
                fillMode: Image.PreserveAspectFit
            }
        }

        Rectangle {
            id: xrect
            x: 510
            y: 190
            width: 60
            height: 60
            color: "#00000000"
            border.color: "#000000"
            objectName: "xbtn"
            MouseArea {
                anchors.fill: parent
                drag.target: xrect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: tab2.width - xrect.width
                drag.minimumY: 0
                drag.maximumY: tab2.height - xrect.height
            }
            Image {
                id: ximage
                anchors.fill: parent
                source: "buttonT.png"
                fillMode: Image.PreserveAspectFit
            }
        }

        Rectangle {
            id: arect
            x: 570
            y: 240
            width: 60
            height: 60
            color: "#00000000"
            border.color: "#000000"
            objectName: "abtn"
            MouseArea {
                anchors.fill: parent
                drag.target: arect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: tab2.width - arect.width
                drag.minimumY: 0
                drag.maximumY: tab2.height - arect.height
            }
            Image {
                id: aimage
                anchors.fill: parent
                source: "buttonC.png"
                fillMode: Image.PreserveAspectFit
            }
        }

        Rectangle {
            id: lrect
            x: 10
            y: 10
            width: 70
            height: 30
            color: "#00000000"
            border.color: "#000000"
            objectName: "lbtn"
            MouseArea {
                anchors.fill: parent
                drag.target: lrect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: tab2.width - lrect.width
                drag.minimumY: 0
                drag.maximumY: tab2.height - lrect.height
            }
            Image {
                id: limage
                x: 0
                y: 0
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                fillMode: Image.Stretch
                anchors.fill: parent
                source: "lbutton.png"
            }
        }

        Rectangle {
            id: padrect
            x: 5
            y: 100
            width: 180
            height: 180
            color: "#00000000"
            radius: 4
            border.color: "#000000"
            visible: true
            objectName: "dpadbtn"
            MouseArea {
                anchors.fill: parent
                drag.target: padrect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: tab2.width - padrect.width
                drag.minimumY: 0
                drag.maximumY: tab2.height - padrect.height
            }
            Rectangle {
                id: downrect
                x: 0
                y: 120
                width: 180
                height: 60
                color: "#00000000"
                objectName:  "downbtn"
                Image {
                    id: image1
                    x: 0
                    y: 0
                    width: 107
                    height: 82
                    anchors.fill: parent
                    source: "setaDOWN.png"
                    fillMode: Image.PreserveAspectFit
                }
            }

            Rectangle {
                id: rightrect
                x: 120
                y: 0
                width: 60
                height: 180
                color: "#00000000"
                objectName:  "rightbtn"
                Image {
                    id: image3
                    anchors.fill: parent
                    source: "setaRIGHT.png"
                    fillMode: Image.PreserveAspectFit
                }
            }

            Rectangle {
                id: uprect
                x: 0
                y: 0
                width: 180
                height: 60
                color: "#00000000"
                objectName:  "upbtn"
                Image {
                    id: image4
                    anchors.fill: parent
                    source: "setaUP.png"
                    fillMode: Image.PreserveAspectFit
                }
            }

            Rectangle {
                id: leftrect
                x: 0
                y: 0
                width: 60
                height: 180
                color: "#00000000"
                objectName:  "leftbtn"
                visible: true
                Image {
                    id: image5
                    anchors.fill: parent
                    source: "setaLEFT.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Rectangle {
            id: startrect
            x: 320
            y: 10
            width: 70
            height: 20
            color: "#00000000"
            border.color: "#000000"
            objectName: "stbtn"
            MouseArea {
                anchors.fill: parent
                drag.target: startrect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: tab2.width - startrect.width
                drag.minimumY: 0
                drag.maximumY: tab2.height - startrect.height
            }
            Image {
                id: startimage
                anchors.fill: parent
                source: "stbutton.png"
                fillMode: Image.Stretch
            }
        }

        Rectangle {
            id: selectrect
            x: 230
            y: 10
            width: 70
            height: 20
            color: "#00000000"
            border.color: "#000000"
            objectName: "slbtn"
            MouseArea {
                anchors.fill: parent
                drag.target: selectrect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: tab2.width - selectrect.width
                drag.minimumY: 0
                drag.maximumY: tab2.height - selectrect.height
            }
            Image {
                id: selectimage
                anchors.fill: parent
                source: "slbutton.png"
                fillMode: Image.Stretch
            }
        }

        Rectangle {
            id: rrect
            x: 560
            y: 10
            width: 70
            height: 30
            color: "#00000000"
            border.color: "#000000"
            objectName: "rbtn"
            MouseArea {
                anchors.fill: parent
                drag.target: rrect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: tab2.width - rrect.width
                drag.minimumY: 0
                drag.maximumY: tab2.height - rrect.height
            }
            Image {
                id: rimage
                width: 70
                height: 30
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                sourceSize.height: 112
                anchors.fill: parent
                source: "rbutton.png"
                fillMode: Image.Stretch
            }
        }

        Button {
            id: buttonconfig1
            x: 271
            y: 190
            width: 100
            height: 43
            text: "Save"
            rotation: 0
            onClicked: {
                menuBase.activeTab = 1
                menuBase.saveVControl()
            }
        }

        states:
            State {
            name: "active"; when: menuBase.activeTab == 7;
            PropertyChanges { target: tab2; x: 0; y: 0 }
            //PropertyChanges { target: statusbar1; visible: false }
            }
        transitions:
            Transition {
            NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.InOutQuad }
            }
    }
    Item {
        id: tab3
        x: 0
        y: 360
        width: 640
        height: 360

        TextArea {
            id: textabout
            x: 31
            y: 67
            width: 578
            height: 272
            font.pixelSize: 23
            readOnly: true
            font.family: "Times New Roman"
            text: "This is a Open Source emulator built with Qt ToolKit.
Projected by Andre Botelho.
http://libproductions.wordpress.com/emisnes
Mail to:
andrebotelhomail@gmail.com
Support:
bug.libpro@gmail.com"
        }
        states:
            State {
            name: "active"; when: menuBase.activeTab == 3;
            PropertyChanges { target: tab3; x: 0; y: 0 }
            }
        transitions:
            Transition {
            NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.InOutQuad }
            }

        Button {
            id: buttonabout
            x: 213
            y: 0
            width: 360
            height: 42
            text: "Main Menu"
            clip: false
            opacity: 1
            rotation: 0
            onClicked:
                menuBase.activeTab = 1
        }

    }

    Item {
        id: tab4
        x: 640
        y: 0
        width: 640
        height: 360

        Button {
            id: buttonconfigmenu
            x: 30
            y: 36
            width: 200
            height: 50
            text: "Main Menu"
            clip: false
            rotation: 0
            opacity: 1
            onClicked:
                menuBase.activeTab = 1
        }

        Button {
            id: buttonconfigmenu2
            x: 30
            y: 181
            width: 198
            height: 50
            text: "Config Audio"
            platformAutoRepeat: false
            clip: false
            rotation: 0
            opacity: 1
            onClicked:
                menuBase.activeTab = 6
        }

        Button {
            id: buttonconfigmenu3
            x: 30
            y: 108
            width: 200
            height: 50
            text: "Config Video"
            clip: false
            rotation: 0
            opacity: 1
            onClicked:
                menuBase.activeTab = 5
        }

        Button {
            id: buttonconfigmenu4
            x: 490
            y: 155
            width: 250
            height: 50
            text: "Config Virtual Control"
            clip: false
            rotation: 90
            opacity: 1
            onClicked:
                menuBase.activeTab = 7
        }

        Button {
            id: buttonsaveconfig
            x: 37
            y: 269
            width: 227
            height: 70
            text: "Save Configuration"
            rotation: 0
            onClicked: {
                menuBase.activeTab = 1
                menuBase.saveConfig()
            }
        }

        Rectangle{
            id: warnRect
            width: 320
            height: 180
            visible: false
            radius: 30
            color: "#f0cccccc"
            border.width: 5
            border.color: "#f0000000"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            property string texto: "Press a Key for Up"
            property int counter: 0
            x: 154
            y: 85
            z: 1
            Text{
                text: warnRect.texto
                anchors.fill: parent
                font.bold: false
                font.pointSize: 8
                font.family: "Tahoma"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            Text{
                text: "Click to Skip"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                font.bold: false
                font.pointSize: 8
                font.family: "Tahoma"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            focus: false
            Keys.onPressed: {
                menuBase.setKey( counter, event.key)
                counter = counter + 1;
                if(counter == 1) texto = "Press a Key for Down";
                if(counter == 2) texto = "Press a Key for Left";
                if(counter == 3) texto = "Press a Key for Right";
                if(counter == 4) texto = "Press a Key for A";
                if(counter == 5) texto = "Press a Key for B";
                if(counter == 6) texto = "Press a Key for X";
                if(counter == 7) texto = "Press a Key for Y";
                if(counter == 8) texto = "Press a Key for L";
                if(counter == 9) texto = "Press a Key for R";
                if(counter == 10) texto = "Press a Key for Start";
                if(counter == 11) texto = "Press a Key for Select";
                if( counter > 11){
                    warnRect.visible = false
                    warnRect.focus = false
                    texto = "Press a Key for Up"
                    counter = 0
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    warnRect.counter = warnRect.counter + 1
                    if(warnRect.counter == 1) warnRect.texto = "Press a Key for Down";
                    if(warnRect.counter == 2) warnRect.texto = "Press a Key for Left";
                    if(warnRect.counter == 3) warnRect.texto = "Press a Key for Right";
                    if(warnRect.counter == 4) warnRect.texto = "Press a Key for A";
                    if(warnRect.counter == 5) warnRect.texto = "Press a Key for B";
                    if(warnRect.counter == 6) warnRect.texto = "Press a Key for X";
                    if(warnRect.counter == 7) warnRect.texto = "Press a Key for Y";
                    if(warnRect.counter == 8) warnRect.texto = "Press a Key for L";
                    if(warnRect.counter == 9) warnRect.texto = "Press a Key for R";
                    if(warnRect.counter == 10) warnRect.texto = "Press a Key for Start";
                    if(warnRect.counter == 11) warnRect.texto = "Press a Key for Select";
                    if(  warnRect.counter > 11){
                        warnRect.visible = false
                        warnRect.focus = false
                        warnRect.texto = "Press a Key for Up"
                        warnRect.counter = 0
                    }
                }
            }

        }
        Button {
            id: buttonkeyconfig
            x: 324
            y: 296
            width: 217
            height: 43
            text: "Key Config"
            rotation: 0
            property int i;
            onClicked:{
                    warnRect.visible = true;
                    warnRect.focus = true;
            }
        }

        Text {
            id: text9
            x: 275
            y: 15
            width: 171
            height: 25
            color: "#ffffff"
            text: "Rom Directory"
            font.pixelSize: 18
            font.family: "Times New Roman"

            Button {
                id: buttonromdir
                x: -13
                y: 36
                width: 317
                height: 50
                text: menuBase.romdir
                transformOrigin: Item.Center
                clip: false
                rotation: 0
                platformAutoRepeat: false
                opacity: 1
                onClicked: menuBase.getRomDir()
                Connections{
                    target: menuBase
                    onUpdateRomDir:{ //update images
                        buttonromdir.text = ""
                        buttonromdir.text = menuBase.romdir
                    }

                }
            }
        }

        Text {
            id: text10
            x: 275
            y: 113
            width: 171
            height: 25
            color: "#ffffff"
            text: "Save Directory"
            font.pixelSize: 18
            font.family: "Times New Roman"

            Button {
                id: buttonsavedir
                x: -13
                y: 31
                width: 317
                height: 50
                text: menuBase.savedir
                clip: false
                rotation: 0
                platformAutoRepeat: false
                opacity: 1
                onClicked: menuBase.getSaveDir()
                Connections{
                    target: menuBase
                    onUpdateSaveDir:{
                        buttonsavedir.text = ""
                        buttonsavedir.text = menuBase.savedir
                    }

                }
            }
        }

        Text {
            id: text1
            x: 310
            y: 209
            width: 226
            height: 34
            color: "#ffffff"
            text: "Virtual Control Opacity"
            font.pixelSize: 21
            Slider {
                id: vtransSlider
                x: -7
                y: 41
                width: 205
                height: 36
                minimumValue: 0
                orientation: 1
                value: 7
                maximumValue: 9
                stepSize: 1
                valueIndicatorVisible: false
                objectName: "vctranslider"
            }
            font.family: "Times New Roman"
        }
        states: [
            State {
                name: "active"
                PropertyChanges {
                    target: tab4
                    x: "0"
                    y: "0"
                }
                when: menuBase.activeTab == 2
            }]
        transitions: [
            Transition {
                NumberAnimation {
                    properties: "x,y"
                    easing.type: "InOutQuad"
                    duration: 400
                }
            }]
    }

    Item {
        id: tabconfigvideo
        x: 640
        y: -360
        width: 640
        height: 360
        Button {
            id: buttonconfigvideo
            x: 108
            y: 309
            width: 360
            height: 42
            text: "Return"
            clip: false
            rotation: 0
            opacity: 1
            onClicked:
                menuBase.activeTab = 2
        }

        Text {
            id: text4
            x: 126
            y: 22
            width: 342
            height: 42
            text: qsTr("Video Configuration")
            font.pixelSize: 30
            style: Text.Raised
            font.underline: false
            font.bold: false
            font.family: "Times New Roman"
            horizontalAlignment: Text.AlignHCenter
        }

        CheckBox {
            id: frameBox
            x: 58
            y: 267
            text: "Show Framerate"
            objectName: "frameBox"
        }

        CheckBox {
            id: mdecBox
            x: 472
            y: 73
            text: "Mdec Enable"
            objectName: "mdecBox"
        }

        CheckBox {
            id: sblitBox
            x: 325
            y: 190
            text: "Skip Blit(spd hack)"
            objectName: "sblitBox"
        }

        Text {
            id: text5
            x: 40
            y: 85
            width: 103
            height: 30
            color: "#ffffff"
            text: qsTr("Image Size")
            font.pixelSize: 23
            SelectionListItem {
                id: imSize
                x: 107
                y: -15
                width: 172
                height: 61
                SelectionDialog {
                    id: isizedial
                    x: 6
                    y: 34
                    width: 352
                    height: 180
                    titleText: "Select image size:"
                    model: ListModel {
                        ListElement {
                            name: "Normal"
                        }

                        ListElement {
                            name: "FullScreen"
                        }
                    }
                    objectName: "isizedial"
                    selectedIndex: 0
                }
                title: isizedial.model.get(isizedial.selectedIndex).name
                objectName: "imSize"
                onClicked: isizedial.open()
            }
            font.family: "Times New Roman"
        }

        Text {
            id: text6
            x: 40
            y: 149
            width: 103
            height: 30
            color: "#ffffff"
            text: qsTr("Frameskip")
            font.pixelSize: 23
            font.family: "Times New Roman"

            SelectionListItem {
                id: framerate
                x: 108
                y: -16
                width: 172
                height: 61
                SelectionDialog {
                    id: framedial
                    x: -37
                    y: -128
                    width: 322
                    height: 227
                    titleText: "Select Frameskip:"
                    model: ListModel {
                        ListElement {
                            name: "Auto"
                        }

                        ListElement {
                            name: "0"
                        }

                        ListElement {
                            name: "1"
                        }

                        ListElement {
                            name: "2"
                        }

                        ListElement {
                            name: "3"
                        }

                        ListElement {
                            name: "4"
                        }

                    }
                    objectName: "fskipdial"
                    selectedIndex: 0
                }
                title: framedial.model.get(framedial.selectedIndex).name
                objectName: "framerate"
                onClicked: framedial.open()
            }
        }

        CheckBox {
            id: smoothBox
            x: 325
            y: 137
            text: "Smooth Image"
            objectName: "smoothBox"
        }

        Text {
            id: text12
            x: 40
            y: 213
            width: 103
            height: 30
            color: "#ffffff"
            text: qsTr("Orientation")
            font.pixelSize: 23
            SelectionListItem {
                id: orientationlist
                x: 112
                y: -15
                width: 172
                height: 61
                SelectionDialog {
                    id: orientdial
                    x: -42
                    y: -157
                    width: 322
                    height: 227
                    titleText: "Select Orientation:"
                    model: ListModel {
                        ListElement {
                            name: "Auto"
                        }

                        ListElement {
                            name: "Landscape"
                        }

                        ListElement {
                            name: "Portrait"
                        }
                    }
                    objectName: "orientdial"
                    selectedIndex: 0
                }
                title: orientdial.model.get(orientdial.selectedIndex).name
                onClicked: orientdial.open()
            }
            font.family: "Times New Roman"
        }

        CheckBox {
            id: sgpuBox
            x: 325
            y: 73
            text: "Skip GPU"
            objectName: "sgpuBox"
        }

        CheckBox {
            id: lightBox
            x: 325
            y: 245
            text: "Light"
            objectName: "lightBox"
        }

        CheckBox {
            id: blendBox
            x: 480
            y: 245
            text: "Blend"
            objectName: "blendBox"
        }
        states: [
            State {
                name: "active"
                PropertyChanges {
                    target: tabconfigvideo
                    x: "0"
                    y: "0"
                }
                when: menuBase.activeTab == 5
            }]
        transitions: [
            Transition {
                NumberAnimation {
                    properties: "x,y"
                    easing.type: "InOutQuad"
                    duration: 400
                }
            }]
    }

    Item {
        id: tabconfigaudio
        x: 640
        y: 360
        width: 640
        height: 360
        Button {
            id: buttonconfigaudio
            x: 140
            y: 28
            width: 360
            height: 42
            text: "Return"
            clip: false
            rotation: 0
            opacity: 1
            onClicked:
                menuBase.activeTab = 2
        }

        Text {
            id: text2
            x: 333
            y: 112
            width: 135
            height: 30
            color: "#ffffff"
            text: qsTr("Volume")
            font.bold: false
            font.pixelSize: 22
            font.family: "Times New Roman"

            Slider {
                id: volumeSlider
                x: 77
                y: -3
                width: 220
                height: 36
                orientation: 1
                minimumValue: 0
                value: 70
                maximumValue: 100
                stepSize: 1
                valueIndicatorVisible: false
                objectName: "volumeSlider"
                onValueChanged: {
                    if( !volumeSlider.pressed) menuBase.volumeChanged(value)
                }
            }
        }

        CheckBox {
            id: senaBox
            x: 65
            y: 124
            text: "Enable Sound"
            objectName: "senaBox"
        }

        CheckBox {
            id: cdaBox
            x: 65
            y: 176
            text: "CDDA"
            objectName: "cdaBox"
        }

        CheckBox {
            id: xaBox
            x: 183
            y: 176
            text: "XA"
            objectName: "xaBox"
        }

        Text {
            id: text3
            x: 166
            y: 70
            width: 309
            height: 42
            text: qsTr("Audio & MIsc")
            font.pixelSize: 30
            style: Text.Raised
            font.underline: false
            font.bold: false
            font.family: "Times New Roman"
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: text7
            x: 314
            y: 165
            width: 116
            height: 30
            color: "#f5f2f2"
            text: qsTr("Sound  Rate")
            font.pixelSize: 23
            font.family: "Times New Roman"

            SelectionListItem {
                id: sndRate
                x: 131
                y: -16
                width: 185
                height: 61
                SelectionDialog {
                    id: sratedial
                    x: -309
                    y: -128
                    width: 338
                    height: 290
                    visible: false
                    titleText: "Select Sound Rate:"
                    model: ListModel {
                        ListElement {
                            name: "8000"
                        }

                        ListElement {
                            name: "11025"
                        }

                        ListElement {
                            name: "22050"
                        }

                        ListElement {
                            name: "44100"
                        }
                    }
                    objectName: "sratedial"
                    selectedIndex: 0
                }
                title: sratedial.model.get(sratedial.selectedIndex).name
                objectName: "sndRate"
                onClicked: sratedial.open()
            }
        }

        Text {
            id: text11
            x: 314
            y: 231
            width: 116
            height: 30
            color: "#f5f2f2"
            text: qsTr("CPU Type")
            font.pixelSize: 23
            SelectionListItem {
                id: cpu
                x: 131
                y: -16
                width: 191
                height: 61
                SelectionDialog {
                    id: cpudial
                    x: -307
                    y: -180
                    width: 338
                    height: 290
                    titleText: "Select CPU Type:"
                    visible: false
                    model: ListModel {
                        ListElement {
                            name: "Recompiler"
                        }

                        ListElement {
                            name: "Interpreter"
                        }
                    }
                    objectName: "cpuDial"
                    selectedIndex: 1
                }
                title: cpudial.model.get(cpudial.selectedIndex).name
                objectName: "cpu"
                onClicked: cpudial.open()
            }
            font.family: "Times New Roman"
        }

        Text {
            id: text13
            x: 262
            y: 296
            width: 116
            height: 30
            color: "#f5f2f2"
            text: qsTr("BIAS")
            font.pixelSize: 23
            SelectionListItem {
                id: bias
                x: 57
                y: -15
                width: 103
                height: 61
                SelectionDialog {
                    id: biasDial
                    x: -309
                    y: -248
                    width: 338
                    height: 290
                    titleText: "Select BIAS Value:"
                    visible: false
                    model: ListModel {
                        ListElement {
                            name: "AUTO"
                        }

                        ListElement {
                            name: "1"
                        }

                        ListElement {
                            name: "2"
                        }

                        ListElement {
                            name: "3"
                        }

                        ListElement {
                            name: "4"
                        }

                        ListElement {
                            name: "5"
                        }
                    }
                    objectName: "biasDial"
                    selectedIndex: 2
                }
                title: biasDial.model.get(biasDial.selectedIndex).name
                objectName: "cpu"
                onClicked: biasDial.open()
            }
            font.family: "Times New Roman"
        }

        CheckBox {
            id: flimBox
            x: 65
            y: 284
            text: "Frame Limit"
            objectName: "flimBox"
        }

        CheckBox {
            id: biosBox
            x: 65
            y: 231
            text: "Emulate PSX Bios"
            objectName: "biosBox"
        }

        Text {
            id: text14
            x: 424
            y: 296
            width: 116
            height: 30
            color: "#f5f2f2"
            text: qsTr("Clock")
            font.pixelSize: 23
            SelectionListItem {
                id: clocklist
                x: 57
                y: -15
                width: 157
                height: 61
                title: "clock"//lockDial.model.get(clockDial.selectedIndex).name
                SelectionDialog {
                    id: clockDial
                    x: -309
                    y: -248
                    width: 338
                    height: 290
                    titleText: "Select Clock Percentage:"
                    visible: false
                    model: ListModel {
                        ListElement {
                            name: "100"
                        }

                        ListElement {
                            name: "50"
                        }

                        ListElement {
                            name: "33"
                        }

                        ListElement {
                            name: "25"
                        }

                        ListElement {
                            name: "20"
                        }
                    }
                    objectName: "clockDial"
                    selectedIndex: 2
                }
                objectName: "clock"
                onClicked: clockDial.open()
            }
            font.family: "Times New Roman"
        }
        states: [
            State {
                name: "active"
                PropertyChanges {
                    target: tabconfigaudio
                    x: "0"
                    y: "0"
                }
                when: menuBase.activeTab == 6
            }]
        transitions: [
            Transition {
                NumberAnimation {
                    properties: "x,y"
                    easing.type: "InOutQuad"
                    duration: 400
                }
            }]
    }

//    StatusBar {
//        id: statusbar1
//        x: 0
//        y: 0
//        width: 640
//        height: 24
//    }

}
