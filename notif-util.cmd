@ECHO off
SETLOCAL EnableDelayedExpansion

REM teststr: CPT (DR) DOCTORMAN, Senior Medical Officer, HQ of HQs <derp@derpy.com>; 1WO ENCIK AN CIK, Company Chief Trainer, 1Barbers <yiii@hello.com>; Some Guy With No Job And Email

REM PMT Notification/Report Email-Writing Utility
REM written by wong kok rui

ECHO ================
ECHO NOTIF-UTIL
ECHO MMI Ops Branch Notification/Report Email-Writing Utility
ECHO ================
SET util-choice=nothing
SET invalid-choice-entered=0

:prog_options_selector
  IF !util-choice! EQU q EXIT /B 0
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
    ECHO [q] QUIT
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
  REM initial preprocessing: first change all "; " to ";" for batch delim. then change all " <" to "<"
  SET emails-input=!emails-input:; =;!
  SET "emails-input=!emails-input: <=<!"

  echo.
  :op1-loop-1
  IF [!emails-input!] EQU [] (
    echo.
    echo You can copy-paste the above list into your report. Note that it is NOT sorted by rank, and watch out for duplicates.
    echo Please double-check with your own eyes.
    echo.
    goto util-prog-eof
    )
  FOR /f "tokens=1* delims=;" %%G in ("!emails-input!") do (

      set opt1-line-output=%%G
      REM remove name, assuming no commas in name (remove everything to left of first comma+space)
      set "opt1-line-output=!opt1-line-output:*, =!"

      REM remove email, assuming email encased in <> chars
      FOR /f "tokens=1* delims=<" %%A in ("!opt1-line-output!") do (
        set opt1-line-output=%%A
      )


      echo !opt1-line-output!
      set emails-input=%%H


  )
  goto op1-loop-1

)


IF !util-choice! EQU 2 (
  SET /p emails-input="Copy-Paste Previous 'To'/'CC' Field: "
  REM initial preprocessing: first change all "; " to ";" for batch delim. then change all " <" to "<"
  SET emails-input=!emails-input:; =;!
  SET "emails-input=!emails-input: <=<!"

  echo.
  :op2-loop-1
  IF [!emails-input!] EQU [] (
    echo.
    echo.
    echo You can copy-paste the above string into Outlook's To/CC Field, and press Ctrl + K to automatically expand and find the relavant person at that appointment. Not everything might auto-expand though
    echo Please double-check with your own eyes.
    echo.
    goto util-prog-eof
    )
  FOR /f "tokens=1* delims=;" %%G in ("!emails-input!") do (

      set opt2-line-output=%%G
      REM remove name, assuming no commas in name (remove everything to left of first comma+space)
      set "opt2-line-output=!opt2-line-output:*, =!"

      REM remove email, assuming email encased in <> chars
      FOR /f "tokens=1* delims=<" %%A in ("!opt2-line-output!") do (
        set opt2-line-output=%%A
      )

      <NUL set /p =!opt2-line-output!
      <NUL set /p =;

      set emails-input=%%H


  )
  goto op2-loop-1
)



:util-prog-eof
pause
SET /p restart-util="Do you want to go again? y if yes, anything else if no"
if !restart-util! EQU y (
  SET util-choice=nothing
  goto prog_options_selector
)
ENDLOCAL
pause
EXIT /B 0

set "opt1-tbremoved=!opt1-line-output:*<=<!"
echo !opt1-tbremoved!
call set opt1-line-output=!opt1-line-output:!opt1-tbremoved!=!s
