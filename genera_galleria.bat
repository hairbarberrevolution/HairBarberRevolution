@echo off
REM ────────────────────────────────────────────────────────────────
REM  Genera automaticamente GALLERIA_DONNA.json e GALLERIA_UOMO.json
REM  leggendo i file immagine presenti nelle rispettive cartelle.
REM
REM  Come usarlo (Windows):
REM  Fai doppio click su questo file dalla cartella del sito.
REM ────────────────────────────────────────────────────────────────

cd /d "%~dp0"

call :genera IMMAGINI_DONNA GALLERIA_DONNA.json
call :genera IMMAGINI_UOMO  GALLERIA_UOMO.json
echo Fatto! Ricarica il sito nel browser.
pause
exit /b

:genera
setlocal EnableDelayedExpansion
set folder=%1
set output=%2
set entries=
set first=1
for %%F in (%folder%\*.jpg %folder%\*.jpeg %folder%\*.png %folder%\*.webp %folder%\*.gif %folder%\*.JPG %folder%\*.JPEG %folder%\*.PNG %folder%\*.WEBP %folder%\*.GIF %folder%\*.avif) do (
  if "%%~nxF" NEQ ".gitkeep" (
    if !first!==1 (
      set entries="%%~nxF"
      set first=0
    ) else (
      set entries=!entries!, "%%~nxF"
    )
  )
)
echo [!entries!]> %output%
echo   ^> %output% aggiornato
endlocal
exit /b
