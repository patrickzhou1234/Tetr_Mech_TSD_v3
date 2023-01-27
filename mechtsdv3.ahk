#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

SysGet, Monitor, Monitor, %A_Index%
global square:=0, stick:=0, tpiece:=0, x1:=Round(MonitorRight/2.01469045), y1:=Round(MonitorBottom/5.02325581), x2:=x1+2, y2:=y1+355
Return

Rotate() {
    Send, {up Down}1{up Up}
}
return

Drop() {
    Send, {Space down}1{Space up}
}

newPiece() {
    PixelSearch, Px, Py, x1, y1, x2, y2, 0xC03ACE, 1, Fast
    if (ErrorLevel=0) {
        if (tpiece>0) {
            tpiece--
            Rotate()
            Loop, 2 {
                Send, {Right down}100{Right up}
            }
            Sleep, 100
            Send, {Down down}100{Down up}
            Rotate()
            Drop()
        } else {
            Send, {c down}100{c up}
        }
    }
    PixelSearch, Px, Py, x1, y1, x2, y2, 0x9EE329, 1, Fast
    if (ErrorLevel=0) {
        Rotate()
        if (stick=0) {
            stick:=1
            Loop, 3 {
                Send, {Left down}100{Left up}
            }
        } else {
            stick:=0
            Loop, 5 {
                Send, {Left down}100{Left up}
            }
        }
        Drop()
    }
    PixelSearch, Px, Py, x1, y1, x2, y2, 0x2970E3, 1, Fast
    if (ErrorLevel=0) {
        Loop, 3 {
            Rotate()
        }
        Loop, 5 {
            Send, {Right down}100{Right up}
        }
        Sleep, 100
        Drop()
    }
    PixelSearch, Px, Py, x1, y1, x2, y2, 0xCE3A53, 1, Fast
    if (ErrorLevel=0) {
        Rotate()
        Send, {Left down}100{Left up}
        Drop()
    }
    PixelSearch, Px, Py, x1, y1, x2, y2, 0x29BEE3, 1, Fast
    if (ErrorLevel=0) {
        if (square=0) {
            square:=1
            Loop, 4 {
                Send, {Left down}100{Left up}
            }
        } else {
            square:=0
            Loop, 3 {
                Send, {Left down}100{Left up}
            }
        }
        Drop()
    }
    PixelSearch, Px, Py, x1, y1, x2, y2, 0x29E39E, 1, Fast
    if (ErrorLevel=0) {
        if (tpiece=0) {
            tpiece:=1
            Rotate()
            Loop, 2 {
                Send, {Right down}200{Right up}
            }
            Sleep, 200
            Send, {Down down}100{Down up}
            Sleep, 200
            Rotate()
            Sleep, 200
            Drop()
        } else {
            Send, {c down}100{c up}
        }
    }
    PixelSearch, Px, Py, x1, y1, x2, y2, 0x352BE3, 1, Fast
    if (ErrorLevel=0) {
        Rotate()
        Send, {Right down}100{Right up}
        Sleep, 100
        Send, {Down down}100{Down up}
        Send, {Left down}100{Left up}
        Drop()
    }
    Sleep, 1
}
return

`::
Loop, {
    if GetKeyState("Delete", "P") {
        square:=0, stick:=0, tpiece:=0
        break
    }
    newPiece()
}
return

Tab::
MouseGetPos, x, y
PixelGetColor, color, x, y
MsgBox, %color%
Return


;0xCE3A53 (blue) (maybe), 954, 219
;0x29E39E (Green)
;0x9EE329 (light blue)
;0x352BE3 (red)
;0x29BEE3 (yellow)
;0xC03ACE (tpiece)
;0x2970E3 (orange)
;1107, 280 stick lasts