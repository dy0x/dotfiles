#Requires AutoHotkey v2.0
HoldThreshold := 150         

; shared flag
global HyperLayer := false    ; true while the hold layer is active

; ---------- Esc DOWN ----------
$Esc:: {                      ; key-down event
    global HyperLayer
    SetTimer(Hold_Esc, 0)                 ; cancel any pending timer
    SetTimer(Hold_Esc, -HoldThreshold)    ; single-shot timer
}

; ---------- Esc UP ----------
$Esc up:: {
    global HyperLayer
    SetTimer(Hold_Esc, 0)                 ; stop the timer
    if HyperLayer {                       ; we were in hold mode
        HyperLayer := false               ; leave layer
    } else {                              ; quick tap
        Send "{Esc}"
    }
}

; ---------- Timer callback ----------
Hold_Esc() {
    global HyperLayer
    if GetKeyState("Esc", "P")            ; Esc still physically down?
        HyperLayer := true                ; enter layer
}

; ---------- Layer hotkeys ----------
#HotIf HyperLayer                         ; active only while flag = true

h:: Send "{Left}"
j:: Send "{Down}"
k:: Send "{Up}"
l:: Send "{Right}"
u:: Send "{PgDn}"
i:: Send "{PgUp}" 

Alt:: Return                              ; stop Alt-menu flash

#HotIf                                    ; back to normal hotkeys
