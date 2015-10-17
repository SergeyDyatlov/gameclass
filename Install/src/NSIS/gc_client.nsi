
; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "GameClass3"
!define PRODUCT_VERSION "3.85.7"
!define PRODUCT_PUBLISHER "numb"
!define PRODUCT_WEB_SITE "http://forum.nodasoft.ru"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

!define PROJECT_FOLDER "..\..\.."
SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

!define MUI_WELCOMEFINISHPAGE_BITMAP "${PROJECT_FOLDER}\Res\Installer.bmp"

; Welcome page
!insertmacro MUI_PAGE_WELCOME

; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Select components
!insertmacro MUI_PAGE_COMPONENTS
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "Russian"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PROJECT_FOLDER}\Output\Setup\gc3setup_client.${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\GameClass3"
ShowInstDetails show
ShowUnInstDetails show

InstType "���������� ������� �����"

Section "���������� ����� GameClass" SEC01
  SectionIn 1

; �� ������ ���������� ������������� ������ � ������� ������
  ExecWait 'net stop srvgccl'
  ExecWait '$INSTDIR\Client\gcclsrv.exe -uninstall -silent'
  ExecWait 'taskkill /IM gccl.exe /F'
  ExecWait 'tskill gccl /A'

; �������� ����� �������
  SetOutPath "$INSTDIR\Client"
  SetOverwrite on
  File "${PROJECT_FOLDER}\Install\src\Packages\Client\*.*"
  SetOutPath "$INSTDIR\Client\locales"
  SetOverwrite on
  File "${PROJECT_FOLDER}\Install\src\Packages\Client\locales\*.*"
  
  SetOutPath "$INSTDIR\Client\Skins"
  SetOverwrite on
  File "${PROJECT_FOLDER}\Install\src\Packages\Client\Skins\*.*"
  SetOutPath "$INSTDIR\Client\Skins\full"
  SetOverwrite on
  File "${PROJECT_FOLDER}\Install\src\Packages\Client\Skins\full\*.*"
  SetOutPath "$INSTDIR\Client\Sounds"
  SetOverwrite on
  File "${PROJECT_FOLDER}\Install\src\Packages\Client\Sounds\*.*"
  SetOutPath "$INSTDIR\Client\Files"

; ������ ������ ������ � �������
  WriteRegStr HKLM "SOFTWARE\GameClass\Client" "InstallDirectory" "$INSTDIR\Client"
  WriteRegStr HKLM "SOFTWARE\GameClass\Client" "CurrentVersion" "${PRODUCT_VERSION}"
  
; ������������� � ������������
  WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "GameClass Client" "$INSTDIR\Client\gccl.exe"

; ������������� � ��������
  ExecWait 'netsh firewall add allowedprogram "$INSTDIR\Client\gccl.exe" GCClient ENABLE'
  ExecWait 'netsh firewall add allowedprogram "$INSTDIR\Client\gcclsrv.exe" GCClientService ENABLE'
  
; ������������ ������ � ��������� ��
  ExecWait '$INSTDIR\Client\gcclsrv.exe -install -silent'
  ExecWait 'net start srvgccl'
  
SectionEnd


LangString DESC_CLIENT ${LANG_RUSSIAN} "����� ��������� ��������������� �� ���������� ����������"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SEC01} $(DESC_CLIENT)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


;Function un.onUninstSuccess
;  HideWindow
;  MessageBox MB_ICONINFORMATION|MB_OK "�������� ��������� $(^Name) ���� ������� ���������."
;FunctionEnd

;Function un.onInit
;  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "�� ������� � ���, ��� ������� ������� $(^Name) � ��� ���������� ���������?" IDYES +2
;  Abort
;FunctionEnd

Section Uninstall

  ExecWait 'net stop srvgccl'
  ExecWait '$INSTDIR\Client\gcclsrv.exe -uninstall -silent'
  ExecWait 'taskkill /IM gccl.exe /F'
  ExecWait 'tskill gccl /A'

;  Delete "$INSTDIR\Client\Skins\*.*"
;  RmDir "$INSTDIR\Client\Skins"
;  Delete "$INSTDIR\Client\Sounds\*.*"
;  RmDir "$INSTDIR\Client\Sounds"
;  Delete "$INSTDIR\Client\Files\*.*"
;  RmDir "$INSTDIR\Client\Files"
;  Delete "$INSTDIR\Client\*.*"
  RmDir /r "$INSTDIR\Client"

  DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "GameClass Client"

;  Delete "$INSTDIR\${PRODUCT_NAME}.url"
;  Delete "$INSTDIR\uninst.exe"
;  Delete "$INSTDIR\Scripts\*.*"
;  Delete "$INSTDIR\Traffic Inspector Plug-In\*.*"
;  Delete "$INSTDIR\UserGate Plug-In\*.*"

;  Delete  "$INSTDIR\*.*"

;  Delete "$SMPROGRAMS\GameClass3\Uninstall.lnk"
;  Delete "$SMPROGRAMS\GameClass3\Website.lnk"
;  Delete "$SMPROGRAMS\GameClass3\GameClass3.lnk"
;  Delete "$SMPROGRAMS\GameClass3\Website.lnk"
;  Delete "$SMPROGRAMS\GameClass3\Uninstall.lnk"
;  Delete "$SMPROGRAMS\GameClass3\Backup and Restore database.lnk"
;  Delete "$SMPROGRAMS\GameClass3\Traffic Inspector Plug-In Installation.lnk"
;  Delete "$SMPROGRAMS\GameClass3\UserGate 2.8 Plug-In.lnk"

  RMDir /r "$SMPROGRAMS\GameClass3"
  
;  RMDir "$INSTDIR\Scripts"
;  RMDir "$INSTDIR\Traffic Inspector Plug-In"
;  RMDir "$INSTDIR\UserGate Plug-In"
  RMDir /r "$INSTDIR"

  DeleteRegKey HKLM "SOFTWARE\GameClass"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd