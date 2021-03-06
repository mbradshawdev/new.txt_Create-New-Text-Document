
;---------------------------------------------------------------------------------------------------------
;==New .txt Create New Text Document======================================================================

/*
Version:    1.0
NOTES:      Newly created, probably no updates needed
TO-DO:      Probably nothing, maybe more advanced way of waiting for creation then select incase HD is sleeping or idk
INFO:       
  Waits for valid active windows explorer / grabs directory, creates empty "new.txt" file there then selects it
  Because right-clicking is so 1996
  And it saves about 1.5 seconds on a task I repeat very often
Change-Log:
  1.0 Newly created, probably no updates needed

*/

;---------------------------------------------------------------------------------------------------------
;==SETTINGS===============================================================================================

#NoEnv                          ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                         ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SendMode Input                  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%     ; Ensures a consistent starting directory.

;---------------------------------------------------------------------------------------------------------
;==PROGRAM================================================================================================

;Wait for Launchy to close
Loop
 {
  IfWinNotActive Launchy
   break
 } 

Loop
{ ;GetDirLoop
 ControlGetText, currDir, ToolbarWindow322, A           ;Get Filepath (until a valid one is found)
 StringTrimLeft, currDir, currDir, 9                    ;Removes "Address: "
 if RegExMatch(currDir, "[A-Z]:\\")                     ;Range A-Z, literal :, escaped literal \, aka C:\ or D:\ etc
 {                                                      ;
  ToolTip                                               ;Clear tooltip
  Break                                                 ;Break dir grabbing loop
 }

 if currDir
  ToolTip Looking for destination folder...`nIndent: "%IndentString%"`nPlease click on a valid Windows Explorer window (folder)`n"%currDir%" doesn't look right`, keep trying!
 else 
  ToolTip Looking for destination folder...`nIndent: "%IndentString%"`nPlease click on a valid Windows Explorer window (folder)
}
 
FileAppend, , %currDir%\new.txt         ;append ..nothing! aka create
Sleep 100                               ;Seems long enough
Send new.                               ;Select the file with n-e-w-. keystrokes (primitive but quick and easy)

Return

$~Esc::                                 ;$~Hotkey sends original [ESC] keystroke and closes app
ToolTip BYE!
ExitApp
