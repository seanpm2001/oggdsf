; Script generated by the HM NIS Edit Script Wizard.

; Location of Visual Studio runtime libraries on the compiling system
;   ************* Change this to match the path where msvcp71.dll and msvcr71.dll live ******************
!define VS_RUNTIME_LOCATION "c:\Program Files\Microsoft Visual Studio .NET 2003\SDK\v1.1\Bin"
;   *****************************************************************************************************

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "oggcodecs"
!define PRODUCT_VERSION "0.70"
!define PRODUCT_PUBLISHER "illiminable"
!define PRODUCT_WEB_SITE "http://www.illiminable.com/ogg/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\OOOggDump.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "NSIS:StartMenuDir"



SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

; Include for library registration
!include "Library.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!define MUI_LICENSEPAGE_CHECKBOX
!insertmacro MUI_PAGE_LICENSE "..\..\..\COPYRIGHTS.rtf"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Start menu page
var ICONS_GROUP
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "illiminable\oggcodecs"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "Czech"
!insertmacro MUI_LANGUAGE "Dutch"
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Italian"
!insertmacro MUI_LANGUAGE "Japanese"
!insertmacro MUI_LANGUAGE "Korean"
!insertmacro MUI_LANGUAGE "Polish"
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "TradChinese"
!insertmacro MUI_LANGUAGE "Turkish"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "oggcodecs_${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\illiminable\oggcodecs"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Section "Ogg Core Files" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ; Runtime libraries from visual studio
  
  File "${VS_RUNTIME_LOCATION}\msvcr71.dll"
  File "${VS_RUNTIME_LOCATION}\msvcp71.dll"
  ;
  
  File "..\..\..\src\lib\core\directshow\dsfAbstractVideoEncoder\Release\dsfAbstractVideoEncoder.dll"
  File "..\..\..\src\lib\core\ogg\libOOOgg\Release\libOOOgg.dll"
  File "..\..\..\src\lib\core\ogg\libOOOggSeek\Release\libOOOggSeek.dll"
  File "..\..\..\src\lib\core\directshow\dsfSeeking\Release\dsfSeeking.dll"
  File "..\..\..\src\lib\core\ogg\libVorbisComment\Release\libVorbisComment.dll"
  File "..\..\..\ABOUT.rtf"
  File "..\..\..\VERSIONS"
  File "..\..\..\README"
  File "..\..\..\COPYRIGHTS.rtf"
  File "..\..\..\COPYRIGHTS"
  File "..\..\..\AUTHORS"
  File "..\..\..\HISTORY"

; Register libraries
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\core\directshow\dsfOggDemux\Release\dsfOggDemux.dll" "$INSTDIR\dsfOggDemux.dll" "$INSTDIR"
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\core\directshow\dsfOggMux\Release\dsfOggMux.dll" "$INSTDIR\dsfOggMux.dll" "$INSTDIR"

; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section "Annodex Core Files" SEC02
  File "..\..\..\src\lib\codecs\cmml\libCMMLTags\Release\libCMMLTags.dll"
  File "..\..\..\src\lib\codecs\cmml\libWinCMMLParse\Release\libWinCMMLParse.dll"
;  File "..\..\..\src\lib\core\directshow\dsfAnxDemux\Release\dsfAnxDemux.dll"
  ;Sleep 3000
  SetOutPath $INSTDIR
  ;RegDLL "$INSTDIR\dsfAnxDemux.dll"

  

  ;Sleep 3000
; Register libraries
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\codecs\cmml\dsfCMMLDecoder\Release\dsfCMMLDecoder.dll" "$INSTDIR\dsfCMMLDecoder.dll" "$INSTDIR"
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\core\directshow\dsfSubtitleVMR9\Release\dsfSubtitleVMR9.dll" "$INSTDIR\dsfSubtitleVMR9.dll" "$INSTDIR"
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\core\directshow\dsfAnxDemux\Release\dsfAnxDemux.dll" "$INSTDIR\dsfAnxDemux.dll" "$INSTDIR"
  Sleep 3000

; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section "Decoders" SEC03
  File "..\..\..\src\lib\codecs\vorbis\libs\libvorbis\win32\Vorbis_Dynamic_Release\vorbis.dll"
  File "..\..\..\src\lib\codecs\theora\libs\libOOTheora\Release\libOOTheora.dll"
  File "..\..\..\src\lib\codecs\flac\libs\libflac\obj\release\bin\libFLAC.dll"
  File "..\..\..\src\lib\codecs\flac\libs\libflac\obj\release\bin\libFLAC++.dll"
  File "..\..\..\src\lib\codecs\helper\libfishsound\win32\Release\libfishsound.dll"

; Register libraries
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\codecs\flac\filters\dsfNativeFLACSource\Release\dsfNativeFLACSource.dll" "$INSTDIR\dsfNativeFLACSource.dll" "$INSTDIR"
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\codecs\speex\filters\dsfSpeexDecoder\Release\dsfSpeexDecoder.dll" "$INSTDIR\dsfSpeexDecoder.dll" "$INSTDIR"
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\codecs\theora\filters\dsfTheoraDecoder\Release\dsfTheoraDecoder.dll" "$INSTDIR\dsfTheoraDecoder.dll" "$INSTDIR"
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\codecs\flac\filters\dsfFLACDecoder\Release\dsfFLACDecoder.dll" "$INSTDIR\dsfFLACDecoder.dll" "$INSTDIR"
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\codecs\vorbis\filters\dsfVorbisDecoder\Release\dsfVorbisDecoder.dll" "$INSTDIR\dsfVorbisDecoder.dll" "$INSTDIR"
  
; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section "Encoders" SEC04

; Register libraries
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\codecs\flac\filters\dsfFLACEncoder\Release\dsfFLACEncoder.dll" "$INSTDIR\dsfFLACEncoder.dll" "$INSTDIR"
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\codecs\speex\filters\dsfSpeexEncoder\Release\dsfSpeexEncoder.dll" "$INSTDIR\dsfSpeexEncoder.dll" "$INSTDIR"
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\codecs\theora\filters\dsfTheoraEncoder\Release\dsfTheoraEncoder.dll" "$INSTDIR\dsfTheoraEncoder.dll" "$INSTDIR"
  SetOutPath $INSTDIR
  !insertmacro InstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "..\..\..\src\lib\codecs\vorbis\filters\dsfVorbisEncoder\Release\dsfVorbisEncoder.dll" "$INSTDIR\dsfVorbisEncoder.dll" "$INSTDIR"
  
; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section "Command Line Tools" SEC05
  File "..\..\..\src\tools\OOOggDump\Release\OOOggDump.exe"
  File "..\..\..\src\tools\OOOggStat\Release\OOOggStat.exe"
  File "..\..\..\src\tools\OOOggValidate\Release\OOOggValidate.exe"
  File "..\..\..\src\tools\OOOggCommentDump\Release\OOOggCommentDump.exe"
  Sleep 8000
; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -AdditionalIcons
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk" "$INSTDIR\uninst.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\OOOggDump.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\OOOggDump.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  
; Registry Entries for directshow and WMP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_groups_flac.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\FLAC]
;@="FLAC File (flac)"
;"Extensions"=".flac"
;"MIME Types"="audio/x-flac"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\FLAC" "" "FLAC File (flac)"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\FLAC" "Extensions" ".flac"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\FLAC" "MIME Types" "audio/x-flac"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_groups_oga.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\OGA]
;@="Ogg File (oga)"
;"Extensions"=".oga"
;"MIME Types"="audio/x-ogg"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\OGA" "" "Ogg File (oga)"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\OGA" "Extensions" ".oga"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\OGA" "MIME Types" "audio/x-ogg"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_groups_ogv.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Video\OGV]
;@="Ogg File (ogv)"
;"Extensions"=".ogv"
;"MIME Types"="video/x-ogg"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Video\OGV" "" "Ogg File (ogv)"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Video\OGV" "Extensions" ".ogv"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Video\OGV" "MIME Types" "video/x-ogg"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_groups_spx.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\SPX]
;@="Ogg File (spx)"
;"Extensions"=".spx"
;"MIME Types"="audio/x-ogg"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\SPX" "" "Ogg File (spx)"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\SPX" "Extensions" ".spx"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\SPX" "MIME Types" "audio/x-ogg"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_mime_app_ogg.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\application/ogg]
;@="Ogg File"
;"AlreadyRegistered"="yes"
;"Extension.Key"=".ogg"
;"Extensions.CommaSep"="ogg,oga,ogv,spx"
;"Extensions.SpaceSep"=".ogg .oga .ogv .spx"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\application/ogg" "" "Ogg File"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\application/ogg" "AlreadyRegistered" "yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\application/ogg" "Extension.Key" ".ogg"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\application/ogg" "Extensions.CommaSep" "ogg,oga,ogv,spx"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\application/ogg" "Extensions.SpaceSep" ".ogg .oga .ogv .spx"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_mime_aud_flac.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-flac]
;@="FLAC Audio File"
;"AlreadyRegistered"="yes"
;"Extension.Key"=".flac"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-flac" "" "FLAC Audio File"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-flac" "AlreadyRegistered" "yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-flac" "Extension.Key" ".flac"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_mime_aud_ogg.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-ogg]
;@="Ogg Audio File"
;"AlreadyRegistered"="yes"
;"Extension.Key"=".oga"
;"Extensions.CommaSep"="ogg,spx"
;"Extensions.SpaceSep"=".ogg .spx"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-ogg" "" "Ogg Audio File"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-ogg" "AlreadyRegistered" "yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-ogg" "Extension.Key" ".oga"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-ogg" "Extensions.CommaSep" "ogg,spx"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-ogg" "Extensions.SpaceSep" ".ogg .spx"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_mime_vid_ogg.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\video/x-ogg]
;@="Ogg Video File"
;"AlreadyRegistered"="yes"
;"Extension.Key"=".ogv"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\video/x-ogg" "" "Ogg Video File"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\video/x-ogg" "AlreadyRegistered" "yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\video/x-ogg" "Extension.Key" ".ogv"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mm_medlib_flac.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.flac]
;"AlreadyRegistered"="yes"
;"MediaType.Description"="FLAC Audio"
;"Permissions"=dword:0000000f
;"Runtime"=dword:00000007
;"PerceivedType"="audio"
;"Extension.MIME"="audio/x-flac"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.flac" "AlreadyRegistered" "yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.flac" "MediaType.Description" "FLAC Audio"
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.flac" "Permissions" 0x0000000f
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.flac" "Runtime" 0x00000007
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.flac" "PerceivedType" "audio"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.flac" "Extension.MIME" "audio/x-flac"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mm_medlib_oga.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.oga]
;"AlreadyRegistered"="yes"
;"MediaType.Description"="Ogg Audio"
;"Permissions"=dword:0000000f
;"Runtime"=dword:00000007
;"PerceivedType"="audio"
;"Extension.MIME"="audio/x-ogg"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.oga" "AlreadyRegistered" "yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.oga" "MediaType.Description" "Ogg Audio"
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.oga" "Permissions" 0x0000000f
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.oga" "Runtime" 0x00000007
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.oga" "PerceivedType" "audio"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.oga" "Extension.MIME" "audio/x-ogg"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mm_medlib_ogg.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogg]
;"AlreadyRegistered"="yes"
;"MediaType.Description"="Ogg File"
;"Permissions"=dword:0000000f
;"Runtime"=dword:00000007
;"Extension.MIME"="application/ogg"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogg" "AlreadyRegistered" "yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogg" "MediaType.Description" "Ogg File"
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogg" "Permissions" 0x0000000f
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogg" "Runtime" 0x00000007
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogg" "Extension.MIME" "application/ogg"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mm_medlib_ogv.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogv]
;"AlreadyRegistered"="yes"
;"MediaType.Description"="Ogg Video"
;"Permissions"=dword:0000000f
;"Runtime"=dword:00000007
;"PerceivedType"="video"
;"Extension.MIME"="video/x-ogg"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogv" "AlreadyRegistered" "yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogv" "MediaType.Description" "Ogg Video"
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogv" "Permissions" 0x0000000f
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogv" "Runtime" 0x00000007
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogv" "PerceivedType" "video"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogv" "Extension.MIME" "video/x-ogg"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mm_medlib_spx.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.spx]
;"AlreadyRegistered"="yes"
;"MediaType.Description"="Ogg Speex Audio"
;"Permissions"=dword:0000000f
;"Runtime"=dword:00000007
;"PerceivedType"="audio"
;"Extension.MIME"="audio/x-ogg"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.spx" "AlreadyRegistered" "yes"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.spx" "MediaType.Description" "Ogg Speex Audio"
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.spx" "Permissions" 0x0000000f
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.spx" "Runtime" 0x00000007
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.spx" "PerceivedType" "audio"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.spx" "Extension.MIME" "audio/x-ogg"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_anx.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.anx]
;"Source Filter"="{6F767551-E3E1-461f-A8E5-C8ED36342ED1}"
  WriteRegStr HKCR "Media Type\Extensions\.anx" "Source Filter" "{6F767551-E3E1-461f-A8E5-C8ED36342ED1}"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_flac.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.flac]
;"Source Filter"="{6DDA37BA-0553-499a-AE0D-BEBA67204548}"
  WriteRegStr HKCR "Media Type\Extensions\.flac" "Source Filter" "{6DDA37BA-0553-499a-AE0D-BEBA67204548}"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_http.reg
;=========================================================
;[HKEY_CLASSES_ROOT\http\Extensions]
;".OGG"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;".OGV"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;".OGA"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;".SPX"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;".ANX"="{6F767551-E3E1-461f-A8E5-C8ED36342ED1}"
  WriteRegStr HKCR "http\Extensions" ".OGG" "{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
  WriteRegStr HKCR "http\Extensions" ".OGV" "{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
  WriteRegStr HKCR "http\Extensions" ".OGA" "{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
  WriteRegStr HKCR "http\Extensions" ".SPX" "{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
  WriteRegStr HKCR "http\Extensions" ".ANX" "{6F767551-E3E1-461f-A8E5-C8ED36342ED1}"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_oga.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.oga]
;"Source Filter"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
  WriteRegStr HKCR "Media Type\Extensions\.oga" "Source Filter" "{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_ogg.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.ogg]
;"Source Filter"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
  WriteRegStr HKCR "Media Type\Extensions\.ogg" "Source Filter" "{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_ogv.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.ogv]
;"Source Filter"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
  WriteRegStr HKCR "Media Type\Extensions\.ogv" "Source Filter" "{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_spx.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.spx]
;"Source Filter"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
  WriteRegStr HKCR "Media Type\Extensions\.spx" "Source Filter" "{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; wmp_mls.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\MLS\Extensions]
;"ogv"="video"
;"oga"="audio"
;"spx"="audio"
;"flac"="audio"
  WriteRegStr HKLM "SOFTWARE\Microsoft\MediaPlayer\MLS\Extensions" "ogv" "video"
  WriteRegStr HKLM "SOFTWARE\Microsoft\MediaPlayer\MLS\Extensions" "oga" "audio"
  WriteRegStr HKLM "SOFTWARE\Microsoft\MediaPlayer\MLS\Extensions" "spx" "audio"
  WriteRegStr HKLM "SOFTWARE\Microsoft\MediaPlayer\MLS\Extensions" "flac" "audio"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SectionEnd


Function un.onUninstSuccess
;  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
; Unregister libraries

  ; Unregister encoders
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfFLACEncoder.dll"
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfSpeexEncoder.dll"
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfTheoraEncoder.dll"
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfVorbisEncoder.dll"
  
  ; Unregister decoders
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfNativeFLACSource.dll"
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfSpeexDecoder.dll"
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfTheoraDecoder.dll"
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfFLACDecoder.dll"
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfVorbisDecoder.dll"


  ; Unregister core annodex libraries
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfAnxDemux.dll"
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfCMMLDecoder.dll"
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfSubtitleVMR9.dll"
  
  
  ; Unregister core ogg libraries
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfOggDemux.dll"
  SetOutPath $INSTDIR
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREBOOT_NOTPROTECTED "$INSTDIR\dsfOggMux.dll"
  


; Get rid of all the registry keys we made for directshow and WMP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_groups_flac.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\FLAC]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\FLAC"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_groups_oga.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\OGA]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\OGA"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_groups_ogv.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Video\OGV]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Video\OGV"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_groups_spx.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\SPX]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Groups\Audio\SPX"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_mime_app_ogg.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\application/ogg]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\application/ogg"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_mime_aud_flac.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-flac]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-flac"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_mime_aud_ogg.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-ogg]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\audio/x-ogg"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; media_mime_vid_ogg.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\video/x-ogg]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\MIME Types\video/x-ogg"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mm_medlib_flac.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.flac]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.flac"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mm_medlib_oga.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.oga]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.oga"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mm_medlib_ogg.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogg]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogg"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mm_medlib_ogv.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogv]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.ogv"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mm_medlib_spx.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.spx]
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Multimedia\WMPlayer\Extensions\.spx"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_anx.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.anx]
  DeleteRegKey HKCR "Media Type\Extensions\.anx"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_flac.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.flac]
  DeleteRegKey HKCR "Media Type\Extensions\.flac"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_http.reg
;=========================================================
;[HKEY_CLASSES_ROOT\http\Extensions]
;".OGG"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;".OGV"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;".OGA"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;".SPX"="{31CA0186-1FF0-4181-AA38-3CA4040BD260}"
;".ANX"="{6F767551-E3E1-461f-A8E5-C8ED36342ED1}"
  DeleteRegValue HKCR "http\Extensions" ".OGG"
  DeleteRegValue HKCR "http\Extensions" ".OGV"
  DeleteRegValue HKCR "http\Extensions" ".OGA"
  DeleteRegValue HKCR "http\Extensions" ".SPX"
  DeleteRegValue HKCR "http\Extensions" ".ANX"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_oga.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.oga]
  DeleteRegKey HKCR "Media Type\Extensions\.oga"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_ogg.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.ogg]
  DeleteRegKey HKCR "Media Type\Extensions\.ogg"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_ogv.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.ogv]
  DeleteRegKey HKCR "Media Type\Extensions\.ogv"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mt_spx.reg
;=========================================================
;[HKEY_CLASSES_ROOT\Media Type\Extensions\.spx]
  DeleteRegKey HKCR "Media Type\Extensions\.spx"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; wmp_mls.reg
;=========================================================
;[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\MLS\Extensions]
;"ogv"="video"
;"oga"="audio"
;"spx"="audio"
;"flac"="audio"
  DeleteRegValue HKLM "SOFTWARE\Microsoft\MediaPlayer\MLS\Extensions" "ogv"
  DeleteRegValue HKLM "SOFTWARE\Microsoft\MediaPlayer\MLS\Extensions" "oga"
  DeleteRegValue HKLM "SOFTWARE\Microsoft\MediaPlayer\MLS\Extensions" "spx"
  DeleteRegValue HKLM "SOFTWARE\Microsoft\MediaPlayer\MLS\Extensions" "flac"


  !insertmacro MUI_STARTMENU_GETFOLDER "Application" $ICONS_GROUP
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\OOOggCommentDump.exe"
  Delete "$INSTDIR\OOOggValidate.exe"
  Delete "$INSTDIR\OOOggStat.exe"
  Delete "$INSTDIR\OOOggDump.exe"
; Delete "$INSTDIR\dsfVorbisEncoder.dll"
; Delete "$INSTDIR\dsfTheoraEncoder.dll"
; Delete "$INSTDIR\dsfSpeexEncoder.dll"
; Delete "$INSTDIR\dsfFLACEncoder.dll"
; Delete "$INSTDIR\dsfVorbisDecoder.dll"
  Delete "$INSTDIR\libfishsound.dll"
; Delete "$INSTDIR\dsfFLACDecoder.dll"
  Delete "$INSTDIR\libFLAC++.dll"
  Delete "$INSTDIR\libFLAC.dll"
; Delete "$INSTDIR\dsfTheoraDecoder.dll"
  Delete "$INSTDIR\libOOTheora.dll"
; Delete "$INSTDIR\dsfSpeexDecoder.dll"
; Delete "$INSTDIR\dsfNativeFLACSource.dll"
  Delete "$INSTDIR\vorbis.dll"
; Delete "$INSTDIR\dsfSubtitleVMR9.dll"
; Delete "$INSTDIR\dsfAnxDemux.dll"
; Delete "$INSTDIR\dsfCMMLDecoder.dll"
  Delete "$INSTDIR\libWinCMMLParse.dll"
  Delete "$INSTDIR\libCMMLTags.dll"
  Delete "$INSTDIR\libVorbisComment.dll"
; Delete "$INSTDIR\dsfOggDemux.dll"
  Delete "$INSTDIR\dsfSeeking.dll"
  Delete "$INSTDIR\libOOOggSeek.dll"
  Delete "$INSTDIR\libOOOgg.dll"
; Delete "$INSTDIR\dsfOggMux.dll"
  Delete "$INSTDIR\dsfAbstractVideoEncoder.dll"
  Delete "$INSTDIR\ABOUT.rtf"
  Delete "$INSTDIR\VERSIONS"
  Delete "$INSTDIR\README"
  Delete "$INSTDIR\COPYRIGHTS.rtf"
  Delete "$INSTDIR\COPYRIGHTS"
  Delete "$INSTDIR\AUTHORS"
  Delete "$INSTDIR\HISTORY"


  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Website.lnk"

  RMDir "$SMPROGRAMS\$ICONS_GROUP"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
;  SetAutoClose true
SectionEnd
