@ECHO off
SETLOCAL EnableDelayedExpansion

REM PMT Notification/Report Email-Writing Utility
REM written by wong kok rui

ECHO ================
ECHO NOTIF-UTIL
ECHO MMI Ops Branch Notification/Report Email-Writing Utility
ECHO ================
SET util-choice=nothing
SET invalid-choice-entered=0

:prog_options_selector
  IF !util-choice! NEQ 1 IF !util-choice! NEQ 2 IF !util-choice! NEQ ? (
    IF !invalid-choice-entered! EQU 1 (
      ECHO.
      ECHO Please enter only 1, 2, or ?
    )
    ECHO.
    ECHO Possible Options:
    ECHO [1] Report Appointment List Generation
    ECHO [2] Auto-populate "To:"/"CC:" - EZ Ctrl+K Utility
    ECHO [?] HELP
    ECHO.
    SET /p util-choice="Input Choice (number): "
    ECHO !util-choice!
    SET invalid-choice-entered=1
    GOTO prog_options_selector
  )
  IF !util-choice! EQU ? (
    SET invalid-choice-entered=0
    ECHO.
    ECHO //todo put help here lol
    SET util-choice=nothing
    GOTO prog_options_selector
  )

IF !util-choice! EQU 1 (
  SET /p emails-input="Copy-Paste Previous 'To'/'CC' Field: "
  REM first change all "; " to ";" for batch delim
  SET emails-input=!emails-input:; =;!
  ECHO !emails-input!
  SET "emails-input=!emails-input: <=<!"

  ECHO !emails-input!
  pause
  REM test WONG KOK RUI, Dumbass <h1410129@nushigh.edu.sg>; PANG CHEN JUN, MRF BOI <h1410088@nushigh.edu.sg>; XAVIER
  :op1-loop-1
  IF [!emails-input!] EQU [] (
    pause
    goto util-prog-eof
    )
  FOR /f "tokens=1* delims=;" %%G in ("!emails-input!") do (
      echo %%G
      echo START NEW SHIT
      set opt1-line-output=%%G
      FOR /f "tokens=1* delims=<" %%X in ("!opt1-line-output!") do (
          set opt1-line-output=%%X
          echo !opt1-line-output!
          FOR /f "tokens=1* delims=," %%A in ("!opt1-line-output!") do (
            echo %%B
          )
      )
      set emails-input=%%H

  )
  goto op1-loop-1
  pause
)

IF !util-choice! EQU 2 (

)
pause
:util-prog-eof
ENDLOCAL
pause
EXIT /B 0
