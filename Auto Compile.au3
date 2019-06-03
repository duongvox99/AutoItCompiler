#cs [AutoCompileFileInfo]
	Path_Exe=F:\Code\Au3\Auto Compile\Auto Compile 8.0 - Dương Võ.exe
	Path_Icon=F:\Code\Au3\Auto Compile\Resources\Icon Tool.ico
	Company=Copyright © Jackson
	Copyright=Copyright © Jackson
	Description=Dương Võ
	Version=8.0.0.0
	ProductName=8.0
	ProductVersion=8.0.0.0
#ce

#RequireAdmin
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <File.au3>
#include <GuiImageList.au3>
#include <WinAPI.au3>
#include <GuiButton.au3>
;~ #include "CoProc.au3"

Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode", 3)
Opt("GUICloseOnESC", 0)
Opt("TrayOnEventMode", 1)

FileInstall("Resources\logoAutoCompile.png", @TempDir & '\logoAutoCompile.png', 1)
FileInstall("Resources\Bo Sung.txt", @TempDir & '\SJtr35879DUFABA.tmp', 1)
FileInstall("Resources\Obfuscator.exe", @TempDir & "\Obfuscator.exe", 1)
FileInstall("Resources\Obfuscator.dat", @TempDir & "\Obfuscator.dat", 1)
FileInstall("Resources\Aut2exe.exe", @TempDir & "\Aut2exe.exe", 1)
FileInstall("Resources\Aut2exe_x64.exe", @TempDir & "\Aut2exe_x64.exe", 1)
FileInstall("Resources\upx.exe", @TempDir & "\upx.exe", 1)
FileInstall("Resources\icon.ico", @TempDir & "\icon.ico", 1)
FileInstall("Resources\ZLIB.au3", @TempDir & "\ZLIB.au3", 1)
FileInstall("Resources\WinHttp.au3", @TempDir & "\WinHttp.au3", 1)
FileInstall("Resources\WinHttpConstants.au3", @TempDir & "\WinHttpConstants.au3", 1)

Global $Version_Tool = '8.0'
Global $Loi = 0, $Check = 0, $Old_Pass = '', $Old_Path_Exe = ''
Global $NewCode = '#EndRegion - Auto Compile - Dương Võ' & @CRLF, $old = "", $Path
Global $FILE_TBL_OB, $FILE_AU3_OB, $Old_OnTop = '', $Old_PassRAR = ''
Global $Bo_Sung = FileRead(@TempDir & '\SJtr35879DUFABA.tmp')
Global $Func_Ob_UTF8 =  _
'Func _ObfusDT($String)' & @CRLF & _
'	If $String = "" Then Return' & @CRLF & _
'	$String = BinaryToString("0x" & $String)' & @CRLF & _
'	Local $data = ""' & @CRLF & _
'	Local $Jackson = StringSplit($String, Chr(144), 1)' & @CRLF & _
'	Local $chr = Asc($Jackson[2])' & @CRLF & _
'	$String = $Jackson[1]' & @CRLF & _
'	Local $len = StringLen($String)' & @CRLF & _
'	If (StringRight($len, 1) = 0 Or StringRight($len, 1) = 2 Or StringRight($len, 1) = 4 Or StringRight($len, 1) = 6 Or StringRight($len, 1) = 8) Then' & @CRLF & _
'		Local $len2 = $len' & @CRLF & _
'	Else' & @CRLF & _
'		Local $len2 = $len - 1' & @CRLF & _
'	EndIf' & @CRLF & _
'	Local $split = StringSplit($String, "")' & @CRLF & _
'	For $JDH = 1 To StringLen($String) Step 2' & @CRLF & _
'		$data &= $split[$JDH]' & @CRLF & _
'	Next' & @CRLF & _
'	For $JDH = $len2 To 1 Step -2' & @CRLF & _
'		$data &= $split[$JDH]' & @CRLF & _
'	Next' & @CRLF & _
'	$split = StringSplit($data, Chr($chr))' & @CRLF & _
'	Local $data2 = ""' & @CRLF & _
'	For $JDH = 1 To UBound($split) - 1' & @CRLF & _
'		$chr1 = Asc(StringLeft($split[$JDH], 1))' & @CRLF & _
'		$chr2 = StringReplace($split[$JDH], Chr($chr1), "")' & @CRLF & _
'		$chr3 = $chr1 - $chr2' & @CRLF & _
'		$data2 &= Chr($chr3)' & @CRLF & _
'	Next' & @CRLF & _
'	Return BinaryToString($data2, 4)' & @CRLF & _
'EndFunc'
Global $Func_Ob_UTF8Old = _
		'Func _ObfusDThuong($BHDYM)' & @CRLF & _
		'	If Not StringInStr($BHDYM, "%") Then Return $BHDYM' & @CRLF & _
		'	Local $aData = StringSplit($BHDYM, "%")' & @CRLF & _
		'	For $i = 2 To $aData[0]' & @CRLF & _
		'		$aData[1] &= Chr(Dec(StringLeft($aData[$i],2))) & StringTrimLeft($aData[$i],2)' & @CRLF & _
		'	Next' & @CRLF & _
		'	Return BinaryToString(StringToBinary($aData[1],1),4)' & @CRLF & _
		'EndFunc'
Global $Format, $Add_Pass, $Input_Add_Pass, $Add_Info, $Input_Add_Info, $Input_Name_Rar, $Delete_Exe_After
Global $Path_Include, $DTGui
If @OSArch = "X64" Then
	$Path_Include = RegRead('HKLM\SOFTWARE\Wow6432Node\AutoIt v3\AutoIt', 'InstallDir') & '\Include\'
Else
	$Path_Include = RegRead('HKLM\SOFTWARE\AutoIt v3\AutoIt\', 'InstallDir') & '\Include\'
EndIf
If $Path_Include = '' Then _MsgboxError("Bạn hãy cài đặt AutoIT trước khi sử dụng chương trình !")
Dim $Include

Global $IBTNMSGLIST = _GUIImageList_Create(620, 57, 5, 1, 3)
Global $HBTNMSGBITMAP[4]
$HBTNMSGBITMAP[1] = _WinAPI_CreateSolidBitmap($DTGui, 1421772, 620, 57)
$HBTNMSGBITMAP[1] = _WinAPI_CreateSolidBitmap($DTGui, 0x1FCB36, 620, 57)
$HBTNMSGBITMAP[2] = _WinAPI_CreateSolidBitmap($DTGui, 0x0D365A, 620, 57)
$HBTNMSGBITMAP[3] = _WinAPI_CreateSolidBitmap($DTGui, 6710886, 620, 57)
_GUIImageList_Add($IBTNMSGLIST, $HBTNMSGBITMAP[1])
_GUIImageList_Add($IBTNMSGLIST, $HBTNMSGBITMAP[2])
_GUIImageList_Add($IBTNMSGLIST, $HBTNMSGBITMAP[3])
_GUIImageList_Add($IBTNMSGLIST, $HBTNMSGBITMAP[3])
_GUIImageList_Add($IBTNMSGLIST, $HBTNMSGBITMAP[1])
_GUIImageList_Add($IBTNMSGLIST, $HBTNMSGBITMAP[1])

$DTGui = GUICreate("Auto Compile " & $Version_Tool & " - Dương Võ", 640, 359, -1, -1, -1, $WS_EX_ACCEPTFILES)

If IsAdmin() Then _WinAPI_ChangeWindowMessageFilterEx($DTGui, $WM_DROPFILES, $MSGFLT_ALLOW)
If IsAdmin() Then _WinAPI_ChangeWindowMessageFilterEx($DTGui, $WM_COPYGLOBALDATA, $MSGFLT_ALLOW)
GUISetOnEvent($GUI_EVENT_DROPPED, 'DrapAndDrop')
GUISetOnEvent($GUI_EVENT_CLOSE, '_Exit')

$OnTop = GUICtrlCreateCheckbox("On Top", 580, 0)
;~ GUICtrlSetOnEvent(-1, 'OnTop')
GUICtrlSetState(-1, $GUI_CHECKED)
;~ OnTop()
AdlibRegister("OnTop")

GUICtrlCreateTab(2, 2, 637, 355)
GUICtrlCreateTabItem("Compiler")

GUICtrlCreateGroup("Main", 7, 25, 305, 95)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlCreateLabel("Source:", 17, 45, 36, 17)
$Input_Path_Au3 = GUICtrlCreateInput("", 60, 42, 209, 20)
GUICtrlSendMsg($Input_Path_Au3, $em_setcuebanner, True, "Nhập đường dẫn")
GUICtrlCreateButton("...", 271, 41, 30, 22)
GUICtrlSetOnEvent(-1, 'Change_Path_Au3')
GUICtrlCreateLabel("Dest:", 17, 68, 36, 17)
$Input_Path_Exe = GUICtrlCreateInput("", 60, 66, 209, 20)
GUICtrlCreateButton("...", 271, 65, 30, 22)
GUICtrlSetOnEvent(-1, 'Change_Path_Exe')
GUICtrlCreateLabel("Icon:", 17, 90, 36, 17)
$Input_Path_Icon = GUICtrlCreateInput("", 60, 90, 209, 20)
GUICtrlCreateButton("...", 271, 89, 30, 22)
GUICtrlSetOnEvent(-1, 'Change_Path_Icon')
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateGroup("Options", 7, 125, 305, 100)
$Obfuscator = GUICtrlCreateCheckbox("Use Obfuscator", 37, 145, 100, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RenameFunc = GUICtrlCreateCheckbox("*Rename Func", 187, 145, 100, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$UPX = GUICtrlCreateCheckbox("Pack with UPX", 187, 170, 100, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$x32 = GUICtrlCreateRadio("Compile for x32", 37, 195, 100, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$x64 = GUICtrlCreateRadio("Compile for x64", 187, 195, 100, 17)
$Obfuscator_2 = GUICtrlCreateCheckbox("*Ob Homemade", 37, 170, 100, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateGroup("File Info", 325, 25, 305, 167)
GUICtrlCreateLabel("Company Name:", 335, 45, 86, 17)
$Input_Company = GUICtrlCreateInput("Copyright © Jackson", 420, 42, 200, 20)
GUICtrlCreateLabel("Copyright:", 335, 68, 86, 17)
$Input_Copyright = GUICtrlCreateInput("Copyright © Jackson", 420, 66, 169, 20)
$C = GUICtrlCreateButton('©', 591, 65, 30, 22)
GUICtrlSetOnEvent(-1, 'C')

GUICtrlCreateLabel("Description:", 335, 91, 86, 17)
$Input_Description = GUICtrlCreateInput("Dương Võ", 420, 90, 200, 20)
GUICtrlCreateLabel("Version:", 335, 115, 86, 17)
$Input_Version = GUICtrlCreateInput("", 420, 114, 200, 20)
GUICtrlCreateLabel("Product Name:", 335, 139, 86, 17)
$Input_ProductName = GUICtrlCreateInput("", 420, 138, 200, 20)
GUICtrlCreateLabel("Product Version:", 335, 163, 86, 17)
$Input_ProductVersion = GUICtrlCreateInput("", 420, 162, 200, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateGroup("Compress", 325, 200, 305, 152)
$Add_Rar = GUICtrlCreateCheckbox("Auto Compress With Winrar", 345, 220, 150, 17)
GUICtrlSetOnEvent(-1, "Auto_Compress_With_Winrar")
GUICtrlCreateLabel("+ Chọn định dạng nén :", 355, 243, 150, 17)
$Format = GUICtrlCreateCombo("", 490, 238, 130, 20, 0x0003)
GUICtrlSetData($Format, "rar|zip|7z", '7z')
GUICtrlCreateLabel("+ Tên tệp tin nén :", 355, 309, 95, 17)
$Input_Name_Rar = GUICtrlCreateInput("", 460, 309, 160, 20)
$Add_Info = GUICtrlCreateCheckbox("Thêm thông tin :", 352, 286, 95, 17)
$Input_Add_Info = GUICtrlCreateInput("", 460, 286, 130, 20)
$ChangePathInfoRar = GUICtrlCreateButton("...", 590, 285, 30, 22)
GUICtrlSetOnEvent(-1, 'Change_Path_InfoRAR')
$Add_Pass = GUICtrlCreateCheckbox("Thêm mật khẩu :", 352, 266, 95, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetOnEvent(-1, 'addpass')
$Input_Add_Pass = GUICtrlCreateInput("", 460, 263, 160, 20, $ES_CENTER)
addpass()
$Delete_Exe_After = GUICtrlCreateCheckbox("Xóa file sau khi nén", 352, 332, 135, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
Auto_Compress_With_Winrar()

$Reset = GUICtrlCreateButton("Reset To Default", 110, 230, 100, 40)
GUICtrlSetOnEvent(-1, "ResetToDefault")
$Load = GUICtrlCreateButton("Load From EXE File", 7, 230, 100, 40)
GUICtrlSetOnEvent(-1, "LoadFromExeFile")

$Progress1 = GUICtrlCreateProgress(7, 290, 303, 10, 0x00000008)
$Progress2 = GUICtrlCreateProgress(7, 290, 303, 10, 0x00000008)
GUICtrlSetState(-1, $GUI_HIDE)
$Progress = GUICtrlCreateProgress(7, 275, 303, 10)
$Start = GUICtrlCreateButton(">>> Start <<<", 7, 305, 305, 40)
GUICtrlSetCursor(-1, 0)
GUICtrlSetOnEvent(-1, 'Start')
$Save = GUICtrlCreateButton("Save Info", 213, 230, 100, 40)
GUICtrlSetOnEvent(-1, 'Save')
;~ _GUICtrlButton_SetImageList($Reset, $IBTNMSGLIST, 4)
;~ _GUICtrlButton_SetImageList($Load, $IBTNMSGLIST, 4)
_GUICtrlButton_SetImageList($Start, $IBTNMSGLIST, 4)
;~ _GUICtrlButton_SetImageList($Save, $IBTNMSGLIST, 4)

GUICtrlCreateTabItem("About")
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlCreateGroup('', 10, 25, 205, 110)
GUICtrlCreateLabel("Auto Compile", 30, 44, 167, 35)
GUICtrlSetFont(-1, 20, 800, 0, "Times New Roman")
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlCreateLabel("Phiên bản: " & $Version_Tool, 65, 78, 130, 20)
GUICtrlSetFont(-1, 10, 400)
GUICtrlCreateLabel("Tác giả: Dương Võ", 35, 106, 165, 24)
GUICtrlSetFont(-1, 12, 800, 0)
GUICtrlSetColor(-1, 0x008000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateLabel("Copyright © Jackson", 35, 146, 200, 24)
GUICtrlSetFont(-1, 12, 400)
GUICtrlCreateLabel("* Homepage:", 20, 176, 100, 24)
GUICtrlSetFont(-1, 13, 800, 0, "Times New Roman")
GUICtrlSetColor(-1, 0x31658D)
GUICtrlCreateLabel("* Facebook:", 20, 201, 100, 24)
GUICtrlSetFont(-1, 13, 800, 0, "Times New Roman")
GUICtrlSetColor(-1, 0x31658D)
GUICtrlCreateLabel("* Group:", 20, 226, 100, 24)
GUICtrlSetFont(-1, 13, 800, 0, "Times New Roman")
GUICtrlSetColor(-1, 0x31658D)

$h = GUICtrlCreateLabel('D Software', 110, 176, 100, 24, $SS_RIGHT)
GUICtrlSetOnEvent(-1, 'h')
GUICtrlSetFont(-1, 13, 800, 4, "Times New Roman")
GUICtrlSetColor(-1, 0xC90000)
GUICtrlSetCursor(-1, 0)
$s = GUICtrlCreateLabel('Dương Võ', 131, 201, 80, 24, $SS_RIGHT)
GUICtrlSetOnEvent(-1, 's')
GUICtrlSetFont(-1, 13, 800, 4, "Times New Roman")
GUICtrlSetColor(-1, 0xC90000)
GUICtrlSetCursor(-1, 0)
$p = GUICtrlCreateLabel('AutoIT Script', 61, 226, 150, 24, $SS_RIGHT)
GUICtrlSetOnEvent(-1, 'p')
GUICtrlSetFont(-1, 13, 800, 4, "Times New Roman")
GUICtrlSetColor(-1, 0xC90000)
GUICtrlSetCursor(-1, 0)
$Add = _
		'----------------------------------------------------------------' & @CRLF & _
		'Tool có sử dụng :' & @CRLF & _
		'	+ Obfuscate: 1.0.31.1' & @CRLF & _
		'	+ UPX Pack: 3.91.0.0' & @CRLF & _
		'	+ Aut2exe.exe: 3.3.14.2' & @CRLF & _
		'----------------------------------------------------------------' & @CRLF & _
		'Giao diện được xây dựng từ ý tưởng của Tool CWAutComp v2.19.0.2' & @CRLF & _
		'----------------------------------------------------------------' & @CRLF & _
		'Các cách bảo vệ sử dụng trong Tool được mình phát triển từ các ý tưởng của các đàn anh trên Group AutoIT và được rút ra từ kinh nghiệm của bản thân ...' & @CRLF & _
		'-------------------------- & -_- & --------------------------'

GUICtrlCreateGroup('', 225, 25, 402, 245)
_ScrollingCredits('<img src="' & @TempDir & '\logoAutoCompile.png" width=400 height=120>' & @CRLF & @CRLF & _
		$Add, 233, 40, 385, 224, "Giới thiệu Tool Auto Compile", 1, 0, "Times New Roman", 18, Default, 0x808000)

GUICtrlSetData(-1, $Add)

$Donate = GUICtrlCreateButton(">>> Donate me <<<", 7, 295, 620, 50)
GUICtrlSetCursor(-1, 0)
GUICtrlSetOnEvent(-1, 'Donate')
_GUICtrlButton_SetImageList($Donate, $IBTNMSGLIST, 4)

GUISetState(@SW_SHOW)

$idAbout = TrayCreateItem("About")
TrayItemSetOnEvent($idAbout, 'About')
TrayCreateItem("")
$idExit = TrayCreateItem("Exit")
TrayItemSetOnEvent($idExit, '_Exit')
TraySetState(1)

Func Donate()
	ShellExecute("http://duongvox.blogspot.com/p/donate.html")
EndFunc

Func ResetToDefault()
	GUICtrlSetData($Input_Company, "Copyright © Jackson")
	GUICtrlSetData($Input_Copyright, "Copyright © Jackson")
	GUICtrlSetData($Input_Description, "Dương Võ")
	GUICtrlSetData($Input_Version, "")
	GUICtrlSetData($Input_ProductName, "")
	GUICtrlSetData($Input_ProductVersion, "")
EndFunc

Func LoadFromExeFile()
	If $Old_OnTop = $GUI_CHECKED Then WinSetOnTop($DTGui, "", 0)
	$p = FileOpenDialog("Chọn đường dẫn đến file Exe", -1, "(*.exe)")
	If $p <> "" Then
		GUICtrlSetData($Input_Company, FileGetVersion($p, "CompanyName"))
		GUICtrlSetData($Input_Copyright, FileGetVersion($p, "LegalCopyright"))
		GUICtrlSetData($Input_Description, FileGetVersion($p, "FileDescription"))
		GUICtrlSetData($Input_Version, FileGetVersion($p, "FileVersion"))
		GUICtrlSetData($Input_ProductName, FileGetVersion($p, "ProductName"))
		GUICtrlSetData($Input_ProductVersion, FileGetVersion($p, "ProductVersion"))
	EndIf
	If $Old_OnTop = $GUI_CHECKED Then WinSetOnTop($DTGui, "", 1)
EndFunc

Func _MsgboxError($ERR)
	MsgBox(16 + 262144, "Lỗi", $ERR)
	ConsoleWrite(@CRLF & $Path & @CRLF)
	ShellExecute($Path)
	Exit
EndFunc   ;==>_MsgboxError

Func About()
	MsgBox(64 + 262144, "Dương Võ", "Công cụ này còn nhiều thiếu xót ! Hãy đóng góp để phát triển hơn nhé !")
EndFunc   ;==>About

Func Auto_Compress_With_Winrar()
	If GUICtrlRead($Add_Rar) = $GUI_UNCHECKED Then
		GUICtrlSetState($Format, $GUI_DISABLE)
		GUICtrlSetState($Add_Pass, $GUI_DISABLE)
		GUICtrlSetState($Input_Add_Pass, $GUI_DISABLE)
		GUICtrlSetState($Add_Info, $GUI_DISABLE)
		GUICtrlSetState($Input_Add_Info, $GUI_DISABLE)
		GUICtrlSetState($Input_Name_Rar, $GUI_DISABLE)
		GUICtrlSetState($ChangePathInfoRar, $GUI_DISABLE)
		GUICtrlSetState($Delete_Exe_After, $GUI_DISABLE)
	Else
		GUICtrlSetState($Format, $GUI_ENABLE)
		GUICtrlSetState($Add_Pass, $GUI_ENABLE)
		GUICtrlSetState($Input_Add_Pass, $GUI_ENABLE)
		GUICtrlSetState($Add_Info, $GUI_ENABLE)
		GUICtrlSetState($Input_Add_Info, $GUI_ENABLE)
		GUICtrlSetState($Input_Name_Rar, $GUI_ENABLE)
		GUICtrlSetState($ChangePathInfoRar, $GUI_ENABLE)
		GUICtrlSetState($Delete_Exe_After, $GUI_ENABLE)
	EndIf
EndFunc

Func Start()
	Local $_E = 0
	Global $Path = @TempDir & "\AutoCompile" & Random(0, 9999, 1)

	Global $Path_Au3 = GUICtrlRead($Input_Path_Au3)
	Global $Path_Exe = GUICtrlRead($Input_Path_Exe)
	Global $Path_Icon = GUICtrlRead($Input_Path_Icon)

	Global $Company = GUICtrlRead($Input_Company)
	Global $Copyright = GUICtrlRead($Input_Copyright)
	Global $Description = GUICtrlRead($Input_Description)
	Global $Version = GUICtrlRead($Input_Version)
	Global $ProductName = GUICtrlRead($Input_ProductName)
	Global $ProductVersion = GUICtrlRead($Input_ProductVersion)

	If $Company = '' Then $Company = 'Copyright © Jackson Võ'
	If $Copyright = '' Then $Copyright = 'Copyright © Jackson Võ'
	If $Description = '' Then $Description = 'Dương Võ'
	If $Version = '' Then $Version = '1.0.0.0'
	If $ProductName = '' Then $ProductName = '1.0'
	If $ProductVersion = '' Then $ProductVersion = '1.0.0.0'

	GUICtrlSetState($Start, $GUI_DISABLE)
	GUICtrlSetState($Input_Path_Au3, $GUI_DISABLE)
	GUICtrlSetState($Input_Path_Exe, $GUI_DISABLE)
	GUICtrlSetState($Input_Path_Icon, $GUI_DISABLE)
	If $Path_Au3 = '' Or $Path_Exe = '' Then
		MsgBox(0 + 48 + 262144, "Thông báo", "Bạn chưa nhập đường dẫn tới file Au3 hoặc Exe !")
	Else
		If FileGetSize($Path_Au3) = 0 Then
			MsgBox(0 + 48 + 262144, "Thông báo", "Đường dẫn File .au3 không tồn tại !")
		ElseIf $Path_Icon <> '' And FileGetSize($Path_Icon) = 0 Then
			MsgBox(0 + 48 + 262144, "Thông báo", "Đường dẫn File .ico không tồn tại !")
		Else
			If GUICtrlRead($Add_Rar) = $GUI_CHECKED Then
				Global $PassRAR = GUICtrlRead($Input_Add_Pass)
				Global $NameRAR = GUICtrlRead($Input_Name_Rar)
				Global $Info = GUICtrlRead($Input_Add_Info)

				If $NameRAR = '' Then
					MsgBox(0 + 48 + 262144, "Thông báo", "Bạn chưa nhập tên tệp tin nén !")
					$_E = 1
				ElseIf GUICtrlRead($Add_Info) = $GUI_CHECKED And  $Info = '' Then
					MsgBox(0 + 48 + 262144, "Thông báo", "Bạn chưa nhập thông tin cho tệp tin nén !")
					$_E = 1
				ElseIf GUICtrlRead($Add_Pass) = $GUI_CHECKED And  $PassRAR = '' Then
					MsgBox(0 + 48 + 262144, "Thông báo", "Bạn chưa nhập mật khẩu cho tệp tin nén !")
					$_E = 1
				ElseIf StringRegExp($PassRAR, ' ') Then
					MsgBox(0 + 48 + 262144, "Thông báo", "Mật khẩu không được chứa khoảng trắng !")
					$_E = 1
				ElseIf GUICtrlRead($Add_Info) = $GUI_CHECKED And FileGetSize($Info) = 0 Then
					MsgBox(0 + 48 + 262144, "Thông báo", "Đường dẫn file chú thích tệp tin nén không tồn tại !")
					$_E = 1
				EndIf
			EndIf

			If $_E = 0 Then
				DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", GUICtrlGetHandle($Progress1), "uint", 0x40A, "wparam", True, "lparam", "10")
				DirCreate($Path & '\')
				If GUICtrlRead($Obfuscator) = $GUI_CHECKED Then OB()
				If $Path_Icon = '' Then
					$Path_Icon = $Path & "\icon.ico"
				EndIf
				Compile()
				If GUICtrlRead($Add_Rar) = $GUI_CHECKED Then Winrar()
				WinSetTitle($DTGui, "", "Auto Compile")
				If $Loi <> 1 Then MsgBox(0 + 64 + 262144, "Thông báo", "Mission Complete")
				$Loi = 0
			EndIf
		EndIf
	EndIf
	If ProcessExists('Obfuscator.exe') Then ProcessClose('Obfuscator.exe')
	If ProcessExists('Aut2exe.exe') Then ProcessClose('Aut2exe.exe')
	If ProcessExists('Aut2exe_x64.exe') Then ProcessClose('Aut2exe_x64.exe')
	If ProcessExists('upx.exe') Then ProcessClose('upx.exe')

	If $Check = 0 Then DirRemove($Path, 1)

	GUICtrlSetState($Input_Path_Au3, $GUI_ENABLE)
	GUICtrlSetState($Input_Path_Exe, $GUI_ENABLE)
	GUICtrlSetState($Input_Path_Icon, $GUI_ENABLE)
	GUICtrlSetState($Start, $GUI_ENABLE)
	GUICtrlSetData($Progress, 0)
	DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", GUICtrlGetHandle($Progress1), "uint", 0x40A, "wparam", False, "lparam", "10")
	GUICtrlSetState($Progress1, $GUI_HIDE)
	GUICtrlSetState($Progress2, $GUI_SHOW)
	GUICtrlSetState($x64, $GUI_ENABLE)
EndFunc   ;==>Start

Func OB()
	Global $CodeName = Convert(StringRegExpReplace($Path_AU3, ".*\\(.*?)\..*", "\1.au3"))
	Global $File_Au3 = FileRead($Path_AU3)

	FileCopy(@TempDir & "\Obfuscator.exe", $Path & "\Obfuscator.exe", 1)
	FileCopy(@TempDir & "\Obfuscator.dat", $Path & "\Obfuscator.dat", 1)

	WinSetTitle($DTGui, "", "Auto Compile - Processing Include...")
	$Include_NotOb = StringRegExp($File_Au3, "(?i)\s*(#include\s+'.*?');notOB", 3)
	If Not @error Then
		For $DE = 0 To UBound($Include_NotOb) - 1
			$File_Au3 = StringReplace($File_Au3, $Include_NotOb[$DE] & ';notOB', '')
		Next
		$Include_NotOb = _ArrayToString($Include_NotOb, @CRLF) & @CRLF
	Else
		$Include_NotOb = ''
	EndIf

	$Include = StringRegExp($File_Au3, '(?i)\s*#include\s+([<"''].*?[>"''])', 3)
	If Not @error Then
		For $P = 0 To UBound($Include) - 1
			If StringInStr($Include[$P], '.au3') Then
				$File_Au3 = StringReplace($File_Au3, $Include[$P], '"' & _pIncluded($Include[$P], StringRegExp($Path_AU3, "(.*\\).*", 1)[0]) & '"')
			EndIf
		Next
	EndIf

	If Not StringInStr($File_Au3, 'Func _Start_Lov()') Then $File_Au3 = '_Start_Lov()' & @CRLF & $File_Au3 & @CRLF & $Bo_Sung
;~ 	$File_Au3 = Delete_Comment($File_Au3)

	$File_Au3 = StringSplit($File_Au3, @CRLF, 1)
	$Path_Ini = "D" & Random(1000, 999999, 1) & "J"

	For $i = 1 To UBound($File_Au3) - 1
		If $File_Au3[$i] <> "" And StringInStr($File_Au3[$i], ".+") = 0 And StringInStr($File_Au3[$i], ".*?") = 0  And StringRegExp($File_Au3[$i], "(?i)\s*#include") = 0 Then
			$Temp = StringRegExp($File_Au3[$i], '((?:".*?")|(?:''.*?''))(?:[,\)\]&]|\s|$)', 3)
			If Not @error Then
				For $J = 0 To UBound($Temp) - 1
					If StringRegExp($Temp[$J], ";Protect") Then
						$Tem = StringTrimRight(StringTrimLeft($Temp[$J], 1), 1)
						If $Tem <> "" Then
							$TMP = Encode($Tem)
							IniWrite(StringRegExpReplace($Path_AU3, ".au3", $Path_Ini & ".ini"), "Jackson", $i, $TMP)
							$File_Au3[$i] = StringReplace($File_Au3[$i], $Temp[$J], '_ObfusDT(IniRead(@TempDir & "\' & $Path_Ini & '", "Jackson", ' & $i & ', ""))')
						EndIf
					Else
						$TMP = EncodeOld($Temp[$J])
						If $Temp[$J] <> $TMP Then
							$File_Au3[$i] = StringReplace($File_Au3[$i], $Temp[$J], '_ObfusDThuong(' & CutString($TMP) & ')')
						EndIf
					EndIf
				Next
			EndIf
		EndIf
	Next

	$File_Au3 = _ArrayToString($File_Au3, @CRLF, 1)
	If FileExists(StringRegExpReplace($Path_AU3, ".au3", $Path_Ini & ".ini")) Then $File_Au3 = 'FileInstall("' & StringRegExpReplace($Path_AU3, ".au3", $Path_Ini & ".ini") & '", @TempDir & "\' & $Path_Ini & '", 1)' & @CRLF & $File_Au3
	If Not StringInStr($File_Au3, 'Func _ObfusDThuong($BHDYM)') And StringInStr($File_Au3, "_ObfusDThuong(") Then $File_Au3 &= @CRLF & $Func_Ob_UTF8Old
	If Not StringInStr($File_Au3, 'Func _ObfusDT($BHDYM)') And StringInStr($File_Au3, "_ObfusDT(") Then $File_Au3 &= @CRLF & $Func_Ob_UTF8

;~ 	$File_Au3 &= @CRLF & $Func_Ob_UTF8Old; dành riêng khi compile Tool này
;~ 	$File_Au3 &= @CRLF & $Func_Ob_UTF8; dành riêng khi compile Tool

;~ 	$File_Au3 = StringRegExpReplace($File_Au3, "(?U)(?i)Opt\('(.*?)',", 'Opt("' & '$1' & '",')
;~ 	$Opt = StringRegExp($File_Au3, '(?U)(?i)Opt\("(.*)"', 3)
;~ 	For $6 = 0 To UBound($Opt) - 1
;~ 		$File_Au3 = StringRegExpReplace($File_Au3, 'Opt\("' & $Opt[$6] & '"', 'Opt\(BinaryToString("' & StringToBinary($Opt[$6], 4) & '", 4)')
;~ 	Next

;~ 	$File_Au3 = StringRegExpReplace($File_Au3, "(?U)(?i)(?<!Func)(	+|\x28| |\R)(?!(If|Or|And|Not|DllCall|StringReg))(?=String|GUI|Mouse|Control|Slee|Send|Tray)(\w+)(?:\x28)(.+)(?:\x29)(,| |\R|\x29)", "$1" & "Call(" & '"$3"' & ", " & "$4)" & "$5")
;~ 	$File_Au3 = StringRegExpReplace($File_Au3, "(?U)(?i)Call\x28(.+)(\x2C \x29|\x2C\x29)", "Call(" & "$1" & ")")
	Write_File_Ob($Path & '\' & $CodeName, $File_Au3)

	WinSetTitle($DTGui, "", "Auto Compile - Obfuscating...")
	$Pid = Run('"' & $Path & '\Obfuscator.exe" "' & $Path & '\' & $CodeName & '"', '', @SW_HIDE, 2)
	ProcessWaitClose($Pid)

	$DEF = _FileListToArray($Path, '*.au3', 1)
	For $DH = 1 To UBound($DEF) - 1
		If StringRegExp($DEF[$DH], '_Obfuscated.au3') Then
			$FILE_AU3_OB = FileRead($Path & '\' & $DEF[$DH])
			$FILE_TBL_OB = FileRead($Path & '\' & StringReplace($DEF[$DH], '_Obfuscated.au3', '.au3.tbl'))
		EndIf
	Next
	If $FILE_TBL_OB <> '' Then
		$FILE_TBL_OB = _CutString_TBL($FILE_TBL_OB)
		If StringRegExp($FILE_TBL_OB, '"') = 0 Then $FILE_TBL_OB = '"' & $FILE_TBL_OB & '"'
	Else
		_MsgboxError("Không tìm thấy file tbl !")
	EndIf

	WinSetTitle($DTGui, "", "Auto Compile - Hiding file TBL...")
	$Func_Start = StringRegExp($FILE_AU3_OB, '(?s)(?i)Func ' & StringRegExp($FILE_AU3_OB, '#OnAutoItStartRegister "(.*?)"', 3)[0] & '.*?Endfunc', 3)[0]
	$Func_Replace = $Func_Start

	Global $A = 0, $Os = $Func_Replace
	Do
		If StringRegExp($Os, "Execute") = 1 Then
			$Os = StringRegExp($Os, "(?s)(?i)Execute\(BinaryToString\('(.*?)'\)\)", 3)[0]
			$Os = BinaryToString($Os)
		Else
			$Os = StringRegExp($Os, "StringSplit\(FileRead.*?,'(.*?)',1\)", 3)[0]
			$A = 1
		EndIf
	Until $A = 1

	$Func_Replace = StringRegExpReplace($Func_Replace, '(?i)local .+=(.[^()]+)\(\)', "")
	$Func_Replace = StringRegExpReplace($Func_Replace, "(?s)(?i)Fileinstall\('.+.tbl',(.*?),1\)", "Local $DLIT = " & $FILE_TBL_OB)
	$Func_Replace = StringRegExpReplace($Func_Replace, "(?s)(?i)next.*?Endfunc", "")
	$Func_Replace = StringRegExpReplace($Func_Replace, "(?s)(?i)Execute\(BinaryToString\('(.*?)'\)\)", "StringSplit($DLIT, '" & $Os & "', 1)")
	$Func_Replace &= @CRLF & "Next" & @CRLF & "EndFunc"

	If $Include_NotOb <> '' Then
		$FILE_AU3_OB = $Include_NotOb & $FILE_AU3_OB
	EndIf

	$FILE_AU3_OB = StringReplace($FILE_AU3_OB, StringRegExp($FILE_AU3_OB, '(?s)(?i)Func ' & StringRegExp($Func_Start, "(?i)local .+=(.[^()]+)", 3)[0] & '.*?Endfunc', 3)[0], "")
	$FILE_AU3_OB = StringReplace($FILE_AU3_OB, $Func_Start, $Func_Replace)

	If GUICtrlRead($RenameFunc) = $GUI_CHECKED Then
		WinSetTitle($DTGui, "", "Auto Compile - Renaming Func...")

		$Funcs = StringRegExp($FILE_AU3_OB, '(?i)Func +([\w|_]+)\(', 3)

		Local $count = -1, $D = 0
		Do
			$D += 1
			$count += 26 ^ $D
		Until $count >= UBound($Funcs)
		Dim $NewFuncs = _BruteForce($D)

		For $J = 0 To UBound($Funcs) - 1
			$FILE_AU3_OB = StringRegExpReplace($FILE_AU3_OB, $Funcs[$J] & '\(', $NewFuncs[$J + 1] & '(')
			$FILE_AU3_OB = StringRegExpReplace($FILE_AU3_OB, '"' & $Funcs[$J] & '"', '"' & $NewFuncs[$J + 1] & '"')
			$FILE_AU3_OB = StringRegExpReplace($FILE_AU3_OB, "'" & $Funcs[$J] & "'", "'" & $NewFuncs[$J + 1] & "'")
		Next
	EndIf

	$FILE_AU3_OB = StringRegExpReplace($FILE_AU3_OB, 'Os', 'Jackson')
	$FILE_AU3_OB = Delete_Comment($FILE_AU3_OB)

	If GUICtrlRead($Obfuscator_2) = $GUI_CHECKED Then
		WinSetTitle($DTGui, "", "Auto Compile - HomeMade...")
		If StringInStr($FILE_AU3_OB, "﻿#AutoIt3Wrapper_UseX64=no") Then
			$FILE_AU3_OB = StringReplace($FILE_AU3_OB, '﻿#AutoIt3Wrapper_UseX64=no', '')
			GUICtrlSetState($x32, $GUI_CHECKED)
			GUICtrlSetState($x64, $GUI_UNCHECKED)
			GUICtrlSetState($x64, $GUI_DISABLE)
		Else
			$FILE_AU3_OB = StringReplace($FILE_AU3_OB, '﻿#AutoIt3Wrapper_UseX64=yes', '')
		EndIf

		$FILE_AU3_OB = StringRegExpReplace($FILE_AU3_OB, '#OnAutoItStartRegister "(.*?)"', '$1()')

		$FileInstall = StringRegExp($FILE_AU3_OB, 'FileInstall\((.*?),.+\)', 3)
		For $2 = 0 To UBound($FileInstall) - 1
			If Not (((StringLeft($FileInstall[$2], 1) = '"' Or StringLeft($FileInstall[$2], 1) = "'") And (StringRight($FileInstall[$2], 1) <> '"' And StringRight($FileInstall[$2], 1) <> "'")) Or StringRegExp($FileInstall[$2], '&.+\$.+&')) Then
				$___ = StringTrimRight(StringTrimLeft($FileInstall[$2], 1), 1)
				Local $sDrive = "", $sDir = "", $sFilename = "", $sExtension = ""
				$__ = _PathSplit($___, $sDrive, $sDir, $sFilename, $sExtension)
				$__ = FileGetShortName($__[3] & $__[4])
				$FILE_AU3_OB = StringReplace($FILE_AU3_OB, 'FileInstall(' & $FileInstall[$2], 'FileCopy(@TempDir & "\' & $__ & '"')
				$NewCode &= 'FileInstall("' & $___ & '", @TempDir & "\' & $__ & '", 1)' & @CRLF
			EndIf
		Next
	EndIf
	$FILE_AU3_OB = "#EndRegion" & @CRLF & $FILE_AU3_OB & @CRLF & "#EndRegion"
	Write_File_Ob(StringRegExpReplace($Path_AU3, ".au3", "_Obfuscated.au3"), $FILE_AU3_OB)
	$Include_NotOb = ''
	If IsArray($Include) Then ReDim $Include[0]
EndFunc   ;==>OB

Func Compile()
	GUICtrlSetData($Progress, 70)
	WinSetTitle($DTGui, "", "Auto Compile - Compiling...")
	FileCopy(@TempDir & "\Aut2exe.exe", $Path & "\Aut2exe.exe", 1)
	FileCopy(@TempDir & "\Aut2exe_x64.exe", $Path & "\Aut2exe_x64.exe", 1)
	FileCopy(@TempDir & "\upx.exe", $Path & "\upx.exe", 1)
	FileCopy(@TempDir & "\icon.ico", $Path & "\icon.ico", 1)
	GUICtrlSetData($Progress, 80)
	If GUICtrlRead($x32) = $GUI_CHECKED Then
		$OsArch = 'x86'
	Else
		$OsArch = 'x64'
	EndIf
	If GUICtrlRead($UPX) = $GUI_CHECKED Then
		$Pack = ' /pack'
	Else
		$Pack = ''
	EndIf

	Local $Msgbox = 6
	If FileGetSize($Path_Exe) Then
		$Msgbox = MsgBox(4 + 48 + 262144, "Cảnh báo", "File exe đã tồn tại !" & @CRLF & "Bạn có muốn ghi đè lên không ?")
	EndIf
	If GUICtrlRead($Obfuscator) = $GUI_CHECKED Then
		$PATH__ = StringRegExpReplace($Path_Au3, ".au3", "_Obfuscated.au3")
	Else
		$PATH__ = $Path_Au3
	EndIf

	If $Msgbox = 6 Then
		AdlibRegister("Check")
		If GUICtrlRead($Obfuscator_2) = $GUI_CHECKED Then
			WinSetTitle($DTGui, "", "Auto Compile - HomeMade...")
			If StringRegExp($FILE_AU3, "(?m)^\#NoTrayIcon$") Then
				$NewCode &= "#NoTrayIcon"
			EndIf
			If StringRegExp(FileRead($PATH__), 'FileInstall\((.*?),.+\)') Then
				$Box = MsgBox(4 + 48 + 262144, "Cảnh báo", "Trong Script có chứa FileInstall nên không đóng gói chuẩn được !" & @CRLF & "Bạn có muốn tiếp tục không ?")
				If $Box = 6 Then
					$DUMI = Run('"' & $Path & '\Aut2exe.exe" /in "' & $PATH__ & '" /out "' & StringTrimRight($PATH__, 4) & '.a3x"', '', @SW_HIDE)
					GUICtrlSetData($Progress, 90)
					ProcessWaitClose($DUMI)
					$NewCode &= @CRLF & '#include "' & StringTrimRight($PATH__, 4) & '.a3x"' & @CRLF & "#EndRegion"
					Write_File_Ob(StringRegExpReplace($Path_AU3, ".au3", "_Obfuscated.au3"), $NewCode)
				Else
					Exit
				EndIf
			Else
				$DUMI = Run('"' & $Path & '\Aut2exe.exe" /in "' & $PATH__ & '" /out "' & StringTrimRight($PATH__, 4) & '.a3x"', '', @SW_HIDE)
				GUICtrlSetData($Progress, 90)
				ProcessWaitClose($DUMI)
				$NewCode &= @CRLF & '#include "' & StringTrimRight($PATH__, 4) & '.a3x"' & @CRLF & "#EndRegion"
				Write_File_Ob(StringRegExpReplace($Path_AU3, ".au3", "_Obfuscated.au3"), $NewCode)
			EndIf
		EndIf
		If @OSArch = 'X86' Then
			$DUH = Run('"' & $Path & '\Aut2exe.exe" /in "' & $PATH__ & '" /out "' & $Path_Exe & '" /icon "' & $Path_Icon & '"' & $Pack & " /" & $OsArch & ' /comments "Compile by AutoCompile - Jackson Võ" /companyname "' & $Company & '" /filedescription "' & $Description & '" /legalcopyright "' & $Copyright & '" /productname "' & $ProductName & '" /fileversion ' & $Version & ' /productversion ' & $ProductVersion, '', @SW_HIDE)
		Else
			$DUH = Run('"' & $Path & '\Aut2exe_x64.exe" /in "' & $PATH__ & '" /out "' & $Path_Exe & '" /icon "' & $Path_Icon & '"' & $Pack & " /" & $OsArch & ' /comments "Compile by AutoCompile - Jackson Võ" /companyname "' & $Company & '" /filedescription "' & $Description & '" /legalcopyright "' & $Copyright & '" /productname "' & $ProductName & '" /fileversion ' & $Version & ' /productversion ' & $ProductVersion, '', @SW_HIDE)
		EndIf
		ProcessWaitClose($DUH)
		GUICtrlSetData($Progress, 100)
		Sleep(500)
	EndIf
	If $Check = 0 Then FileDelete(StringRegExpReplace($Path_Au3, ".au3", "_Obfuscated.au3"))
	If $Check = 0 And FileExists(StringRegExpReplace($Path_AU3, ".au3", "DF257695J.ini")) Then FileDelete(StringRegExpReplace($Path_AU3, ".au3", "DF257695J.ini"))
	If GUICtrlRead($Obfuscator_2) = $GUI_CHECKED Then FileDelete(StringRegExpReplace($Path_Au3, ".au3", "_Obfuscated.a3x"))
	$NewCode = ''
EndFunc   ;==>Compile

Func WINRAR()
	WinSetTitle($DTGui, "", "Auto Compile - Adding To Archive...")
	If @OSArch = 'X86' Then
		$Path_Winrar = RegRead('HKEY_LOCAL_MACHINE\SOFTWARE\WinRAR', 'exe32')
	Else
		$Path_Winrar = RegRead('HKEY_LOCAL_MACHINE\SOFTWARE\WinRAR', 'exe64')
	EndIf
	If $Path_Winrar = '' Then
		MsgBox(0 + 48 + 262144, "Cảnh báo", "Không tìm thấy WinaRAR trong hệ thống !")
	Else
		$Data = $Path_Winrar & ' a'
		If GUICtrlRead($Delete_Exe_After) = $GUI_CHECKED Then $Data &= ' -df'
		If GUICtrlRead($Add_Pass) = $GUI_CHECKED Then $Data &= ' -hp' & $PassRAR & ''
		$Data &= ' -ep'
		If GUICtrlRead($Add_Info) = $GUI_CHECKED Then
			FileCopy($Info, @HomeDrive & '\jackson.txt', 1)
			$Data &= ' -z' & @HomeDrive & '\jackson.txt'
		EndIf
		Local $sDrive = "", $sDir = "", $sFilename = "", $sExtension = ""
		$Path_FileRar = _PathSplit(GUICtrlRead($Input_Path_Exe), $sDrive, $sDir, $sFilename, $sExtension)
		_ArrayDelete($Path_FileRar, UBound($Path_FileRar) -1)
		_ArrayDelete($Path_FileRar, UBound($Path_FileRar) -1)
		_ArrayDelete($Path_FileRar, 0)
		$Path_FileRar = _ArrayToString($Path_FileRar, "") & $NameRAR
		$Data &= ' "' & $Path_FileRar & '.' & GUICtrlRead($Format) & '" "' & GUICtrlRead($Input_Path_Exe) & '"'
		RunWait($Data, '', @SW_HIDE)
		FileDelete(@HomeDrive & '\jackson.txt')
	EndIf
EndFunc

Func Check()
	If WinGetTitle("Aut2Exe") Then
		$Check = 1
		AdlibUnRegister("Check")
		ProcessClose('Aut2exe.exe')
		ProcessClose('Aut2exe_x64.exe')
		$Loi = 1
		MsgBox(0 + 48 + 262144, "Error", "Đã có lỗi xảy ra !")
		ShellExecute($Path)
	EndIf
EndFunc   ;==>Check

Func _pIncluded($File, $WorkingDir)
	Local $icl = StringRegExp($File, "([<'""])((?:.*\\)*(.*?))[>'""]", 3)
	Local $nName = $icl[2]
	If StringRegExp($icl[1], "\w{1}\:\\.*") Then $WorkingDir = ''
	If $icl[0] = "<" Then
		If FileGetSize($Path_Include & $icl[1]) Then
		Else
			If Not FileGetSize($WorkingDir & $icl[1]) Then _MsgboxError("Không thể mở file include: " & $icl[1])
		EndIf
	Else
		If FileGetSize($WorkingDir & $icl[1]) Then
		Else
			If Not FileGetSize($Path_Include & $icl[1]) Then _MsgboxError("Không thể mở file include : " & $icl[1])
		EndIf
	EndIf

	$Path____ = $Path_Include & $nName
	If Not FileExists($Path____) Then
		FileCopy($WorkingDir & "\" & $nName, $Path & '\' & $nName, 1)
		$Path____ = $Path & '\' & $nName
	EndIf
	If StringRegExp($File, 'Zlib.au3') Then
		FileCopy(@TempDir & "\ZLIB.au3", $Path & '\Zlib.au3', 1)
		$Path____ = $Path & '\Zlib.au3'
	EndIf
	If StringRegExp($File, 'WinHttp.au3') Then
		FileCopy(@TempDir & "\WinHttp.au3", $Path & '\WinHttp.au3', 1)
		$Path____ = $Path & '\WinHttp.au3'
	EndIf
	If StringRegExp($File, 'WinHttpConstants.au3') Then
		FileCopy(@TempDir & "\WinHttpConstants.au3", $Path & '\WinHttpConstants.au3', 1)
		$Path____ = $Path & '\WinHttpConstants.au3'
	EndIf
	Return $Path____
EndFunc   ;==>_pIncluded

Func ARRADD($ARRAY, $VALUE)
	If IsArray($ARRAY) Then
		_ArrayAdd($ARRAY, $VALUE)
		Return $ARRAY
	Else
		Dim $RT[1] = [$VALUE]
		Return $RT
	EndIf
EndFunc   ;==>ARRADD

Func Write_File($_Path, $_File)
	FileDelete($_Path)
	$hFileOpen = FileOpen($_Path, 10 + 128 + 16384)
	FileWrite($_Path, $_File)
	FileClose($hFileOpen)
EndFunc   ;==>Write_File

Func Write_File_Ob($_Path, $_File)
	FileDelete($_Path)
	$hFileOpen = FileOpen($_Path, 10)
	FileWrite($_Path, $_File)
	FileClose($hFileOpen)
EndFunc   ;==>Write_File_Ob

Func Delete_Comment($Au3)
	$Au3 = StringRegExpReplace($Au3, "(?s)(?i)(\s*#cs\s*.+?\#ce\s*)(\r\n)", "\2")
	$Au3 = StringRegExpReplace($Au3, "(?s)(?i)(\s*#comments-start\s*.+?\#comments-end\s*)(\r\n)", "\2")
	$Au3 = StringRegExpReplace($Au3, "(?s)(?i)" & '("")|(".*?")|' & "('')|('.*?')|" & "(\s*;.*?)(\r\n)", "\1\2\3\4\6")
	$Au3 = StringRegExpReplace($Au3, "(\r\n){2,}", @CRLF)
	$Au3 = StringRegExpReplace(StringRegExpReplace($Au3, "(\v)+", @CRLF), "\A\v|\v\Z", "")
	Return $Au3
EndFunc   ;==>Delete_Comment

Func _CutString_TBL($sString)
	Local $StringCut_ReturnValue = ""
	Local $sLen = StringLen($sString)
	If $sLen < 1000 Then
		Return $sString
	Else
		If Not IsDeclared("StringCut_Count") Then
			$StringCut_Count = 1
		EndIf
		For $i = 1 To Ceiling($sLen / 1000)
			$StringCut_ReturnValue &= '"' & StringMid($sString, $StringCut_Count, 1000) & '"' & '& _' & @CRLF
			$StringCut_Count += 1000
		Next
		$StringCut_ReturnValue = StringTrimRight($StringCut_ReturnValue, 5)
		Return $StringCut_ReturnValue
	EndIf
EndFunc   ;==>_CutString_TBL

Func CutString($String)
	Local $E_Str = StringLeft($String, 1), $Return[3] = [StringRegExpReplace($String, "['""](.*)['""]", "$1")], $Len = StringLen($Return[0])
	If $Len < 1001 Then Return $String
	For $i = 1 To (Int($Len / 1000) + 1)
		$Return[1] = StringMid($Return[0], ($i - 1) * 1000 + 1, 1000)
		If $Return[1] Then $Return[2] &= $E_Str & $Return[1] & $E_Str & " & _ " & @CRLF
	Next
	Return StringTrimRight($Return[2], 7)
EndFunc   ;==>_CutString

Func _CutString($sString)
	Local $StringCut_ReturnValue = ""
	Local $sLen = StringLen($sString)
	If $sLen < 1000 Then
		If StringInStr($sString, "'") Then
			$sString = '"' & $sString & '"'
		Else
			$sString = "'" & $sString & "'"
		EndIf

		Return $sString
	Else
		$StringCut_Count = 1
		For $i = 1 To Ceiling($sLen / 500)
			If StringInStr($sString, "'") Then
				$StringCut_ReturnValue &= '"' & StringMid($sString, $StringCut_Count, 500) & '"' & '& _' & @CRLF
			Else
				$StringCut_ReturnValue &= "'" & StringMid($sString, $StringCut_Count, 500) & "'" & '& _' & @CRLF
			EndIf

			$StringCut_Count += 500
		Next
		$StringCut_ReturnValue = StringTrimRight($StringCut_ReturnValue, 5)
		Return $StringCut_ReturnValue
	EndIf
EndFunc   ;==>_CutString

Func _BruteForce($iBruteLenght = 4)
	Dim $Array
	Local $aBruteArray[$iBruteLenght]

	Local $Jackson_String = ""
	Do
		Do
			$NewChar = Chr(Random(97, 122, 1))
		Until Not StringRegExp($Jackson_String, $NewChar)
		$Jackson_String &= $NewChar
	Until StringLen($Jackson_String) = 26

	Local $aCharSet = StringSplit($Jackson_String, "", 2)
	Local $iCharSetCount = UBound($aCharSet) - 1
	Local $sBruteString = ""
	For $iii = 0 To UBound($aBruteArray) - 1
		$aBruteArray[$iii] = -1
	Next

	Do
		$sBruteString = ""
		$aBruteArray[0] += 1
		For $i = 0 To $iBruteLenght - 1
			If $aBruteArray[$i] > $iCharSetCount Then
				$aBruteArray[$i] = 0
				$aBruteArray[$i + 1] += 1
			ElseIf $aBruteArray[$i] = -1 Then
				ExitLoop (1)
			EndIf
		Next
		For $i = 0 To $iBruteLenght - 1
			If $aBruteArray[$i] > -1 Then
				$sBruteString &= $aCharSet[$aBruteArray[$i]]
			Else
				ExitLoop 1
			EndIf
		Next
		$Array = ARRADD($Array, '_' & $sBruteString)
	Until StringRegExp($sBruteString, "\Q" & $aCharSet[$iCharSetCount] & "\E{" & $iBruteLenght & "}")
	Return $Array
EndFunc   ;==>_BruteForce

Func Convert($text)
	$text = StringRegExpReplace($text, "[á|à|ạ|ả|ã|â|ấ|ầ|ậ|ẩ|ẫ|ă|ắ|ằ|ặ|ẳ]", "a")
	$text = StringRegExpReplace($text, "[é|è|ẹ|ẻ|ẽ|ê|ế|ề|ệ|ể|ễ]", "e")
	$text = StringRegExpReplace($text, "[í|ì|ị|ỉ|ĩ]", "i")
	$text = StringRegExpReplace($text, "[ó|ò|ọ|ỏ|õ|ô|ố|ồ|ộ|ổ|ỗ|ơ|ớ|ờ|ợ|ở]", "o")
	$text = StringRegExpReplace($text, "[ú|ù|ụ|ủ|ũ|ư|ứ|ừ|ự|ử|ữ]", "u")
	$text = StringRegExpReplace($text, "[ý|ỳ|ỵ|ỷ|ỹ]", "y")
	$text = StringRegExpReplace($text, "[đ]", "d")
	$text = StringRegExpReplace($text, "[Á|À|Ạ|Ả|Ã|Â|Ấ|Ầ|Ậ|Ẩ|Ẫ|Ă|Ắ|Ằ|Ặ|Ẳ]", "A")
	$text = StringRegExpReplace($text, "[É|È|Ẹ|Ẻ|Ẽ|Ê|Ế|Ề|Ệ|Ể|Ễ]", "E")
	$text = StringRegExpReplace($text, "[Í|Ì|Ị|Ỉ|Ĩ]", "I")
	$text = StringRegExpReplace($text, "[Ó|Ò|Ọ|Ỏ|Õ|Ô|Ố|Ồ|Ộ|Ổ|Ỗ|Ơ|Ớ|Ờ|Ợ|Ở]", "O")
	$text = StringRegExpReplace($text, "[Ú|Ù|Ụ|Ủ|Ũ|Ư|Ứ|Ừ|Ự|Ử|Ữ]", "U")
	$text = StringRegExpReplace($text, "[Ý|Ỳ|Ỵ|Ỷ|Ỹ]", "Y")
	$text = StringRegExpReplace($text, "[Đ]", "D")
	$text = StringRegExpReplace($text, " ", "_")
	Return ($text)
EndFunc   ;==>Convert

Func OnTop()
	Global $Handle = ControlGetHandle('', '', $DTGui)
	$Moment = GUICtrlRead($OnTop)
	If $Old_OnTop <> $Moment Then
		$Old_OnTop = $Moment
		If $Moment = $GUI_CHECKED Then
			WinSetOnTop($Handle, '', 1)
		Else
			WinSetOnTop($Handle, '', 0)
		EndIf
	EndIf
EndFunc   ;==>OnTop

Func addpass()
	If GUICtrlRead($Add_Pass) = $GUI_CHECKED And GUICtrlRead($Input_Add_Pass) = '' Then
		GUICtrlSetData($Input_Add_Pass, 'dsoftware')
	EndIf
EndFunc

Func Change_Path_InfoRAR()
	If GUICtrlRead($OnTop) = $GUI_CHECKED Then WinSetOnTop($Handle, '', 0)
	$p = FileOpenDialog('Chọn đường dẫn đến file txt', Default, '(*.txt)')
	GUICtrlSetData($Input_Add_Info, $p)
	WinSetOnTop($Handle, '', 1)
EndFunc   ;==>Change_Path_Au3

Func Change_Path_Au3()
	If GUICtrlRead($OnTop) = $GUI_CHECKED Then WinSetOnTop($Handle, '', 0)
	$p = FileOpenDialog('Chọn đường dẫn đến file au3', Default, '(*.au3)')
	GUICtrlSetData($Input_Path_Au3, $p)
	GUICtrlSetData($Input_Path_Exe, StringTrimRight($p, 4) & '.exe')
	Input()
	GetInfo($p)
	WinSetOnTop($Handle, '', 1)
EndFunc   ;==>Change_Path_Au3

Func Change_Path_Exe()
	If GUICtrlRead($OnTop) = $GUI_CHECKED Then WinSetOnTop($Handle, '', 0)
	$p = FileOpenDialog('Chọn đường dẫn đến file exe', Default, '(*.exe)')
	GUICtrlSetData($Input_Path_Exe, $p)
	Input()
	WinSetOnTop($Handle, '', 1)
EndFunc   ;==>Change_Path_Exe

Func Change_Path_Icon()
	If GUICtrlRead($OnTop) = $GUI_CHECKED Then WinSetOnTop($Handle, '', 0)
	$p = FileOpenDialog('Chọn đường dẫn đến file ico', Default, '(*.ico)')
	GUICtrlSetData($Input_Path_Icon, $p)
	WinSetOnTop($Handle, '', 1)
EndFunc   ;==>Change_Path_Icon

Func DrapAndDrop()
	If StringRight(@GUI_DragFile, 4) = ".au3" Then
		GUICtrlSetData($Input_Path_Au3, @GUI_DragFile)
		GUICtrlSetData($Input_Path_Exe, StringTrimRight(@GUI_DragFile, 4) & '.exe')
		GetInfo(@GUI_DragFile)
	EndIf
	If StringRight(@GUI_DragFile, 4) = ".exe" Then GUICtrlSetData($Input_Path_Exe, @GUI_DragFile)
	If StringRight(@GUI_DragFile, 4) = ".ico" Then GUICtrlSetData($Input_Path_Icon, @GUI_DragFile)
EndFunc   ;==>DrapAndDrop

Func GetInfo($sPath)
	$Source = FileRead($sPath)
	If StringInStr($Source, '#cs [AutoCompileFileInfo]') Then
		GUICtrlSetData($Input_Path_Exe, RegExp($Source, 'Path_Exe=(.+)'))
		GUICtrlSetData($Input_Path_Icon, RegExp($Source, 'Path_Icon=(.+)'))
		GUICtrlSetData($Input_Company, RegExp($Source, 'Company=(.*?)[\r\n]+'))
		GUICtrlSetData($Input_Copyright, RegExp($Source, 'Copyright=(.*?)[\r\n]+'))
		GUICtrlSetData($Input_Description, RegExp($Source, 'Description=(.*?)[\r\n]+'))
		GUICtrlSetData($Input_Version, RegExp($Source, 'Version=(.*?)[\r\n]+'))
		GUICtrlSetData($Input_ProductName, RegExp($Source, 'ProductName=(.*?)[\r\n]+'))
		GUICtrlSetData($Input_ProductVersion, RegExp($Source, 'ProductVersion=(.*?)[\r\n]+'))
	EndIf
EndFunc   ;==>GetInfo

Func RegExp($test, $pattern, $Flag = 3)
	Local $A = StringRegExp($test, $pattern, $Flag)
	If UBound($A) > 0 Then
		Return $A[0]
	Else
		Return ''
	EndIf
EndFunc   ;==>RegExp

Func C()
	If StringInStr(GUICtrlRead($Input_Copyright), '©') = 0 Then GUICtrlSetData($Input_Copyright, 'Copyright © ' & GUICtrlRead($Input_Copyright))
EndFunc   ;==>C

Func _Exit()
	Save()
	Exit
EndFunc   ;==>_Exit

Func Save()
	Global $Path_Au3 = GUICtrlRead($Input_Path_Au3)
	Global $Path_Exe = GUICtrlRead($Input_Path_Exe)
	Global $Path_Icon = GUICtrlRead($Input_Path_Icon)

	Global $Company = GUICtrlRead($Input_Company)
	Global $Copyright = GUICtrlRead($Input_Copyright)
	Global $Description = GUICtrlRead($Input_Description)
	Global $Version = GUICtrlRead($Input_Version)
	Global $ProductName = GUICtrlRead($Input_ProductName)
	Global $ProductVersion = GUICtrlRead($Input_ProductVersion)

	If $Path_Au3 <> '' And ($Path_Exe <> '' Or $Path_Icon <> '' Or $Company <> '' Or $Copyright <> '' Or $Description <> '' Or $Version <> '' Or $ProductName <> '' Or $ProductVersion <> '') Then
		Local $Save_Old = _
				'#cs [AutoCompileFileInfo]' & @CRLF & _
				'	Path_Exe=' & $Path_Exe & @CRLF & _
				'	Path_Icon=' & $Path_Icon & @CRLF & _
				'	Company=' & $Company & @CRLF & _
				'	Copyright=' & $Copyright & @CRLF & _
				'	Description=' & $Description & @CRLF & _
				'	Version=' & $Version & @CRLF & _
				'	ProductName=' & $ProductName & @CRLF & _
				'	ProductVersion=' & $ProductVersion & @CRLF & _
				'#ce'
		If Not StringInStr(FileRead($Path_Au3), $Save_Old) Then
			Local $RequestBox = MsgBox(4 + 64 + 262144, "Thông báo", "Bạn có muốn lưu lại thông tin file không ?")
			If $RequestBox = 6 Then
				If StringInStr(FileRead($Path_Au3), '#cs [AutoCompileFileInfo]') Then
					$_Save = $Save_Old & StringRegExpReplace(FileRead($Path_Au3), "(?s)(?i)(\s*#cs \[AutoCompileFileInfo\]\s*.+?\#ce\s*)(\r\n)", "\2")
				Else
					$_Save = $Save_Old & @CRLF & FileRead($Path_Au3)
				EndIf
				Write_File($Path_Au3, $_Save)
			EndIf
		EndIf
	EndIf
EndFunc

Func EncodeOld($String)
	If StringLen($String) <= 0 Then Return ""
	Local $result, $proc
	For $String_Count = 1 To StringLen($String)
		$proc = StringToBinary(StringMid($String, $String_Count, 1), 4)
		If StringLen($proc) > 4 Then
			$proc = StringTrimLeft($proc, 2)
			For $i = 1 To StringLen($proc) Step 2
				$result &= "%" & StringMid($proc, $i, 2)
			Next
		Else
			$result &= BinaryToString($proc, 4)
		EndIf
	Next
	Return $result
EndFunc   ;==>Encode

Func encode($String)
	If $String = "" Then Return
	Global $rdm
	Do
		$rdm = Random(Asc("Jackson"), 255, 1)
	Until $rdm <> 144
	Global $Chr
	Do
		$Chr = Random(97, 121, 1)
	Until $Chr <> 144 And $Chr <> $rdm
	$String = StringToBinary($String, 4)
	Local $data = ""
	Local $len = StringLen($String)
	Local $split = StringSplit($String, "")
	$String = ""
	For $JDH = 1 To UBound($split) - 1
		$String &= Chr($rdm) & $rdm - (Asc($split[$JDH])) & Chr($Chr)
	Next
	$split = StringSplit($String, "")
	$len = StringLen($String)
	Local $len2 = $len
	For $JDH = 1 To $len / 2
		$data &= $split[$JDH]
		$data &= $split[$len2]
		$len2 -= 1
	Next
	If Not (StringRight($len, 1) = 0 Or StringRight($len, 1) = 2 Or StringRight($len, 1) = 4 Or StringRight($len, 1) = 6 Or StringRight($len, 1) = 8) Then
		$data &= $split[$len / 2 + 1]
	EndIf
	$data &= Chr(144) & Chr($Chr)
	$data = StringTrimLeft(StringToBinary($data), 2)
	Return $data
EndFunc   ;==>encode

Func decode($String)
	If $String = "" Then Return
	$String = BinaryToString("0x" & $String)
	Local $data = ""
	Local $Jackson = StringSplit($String, Chr(144), 1)
	Local $chr = Asc($Jackson[2])
	$String = $Jackson[1]
	Local $len = StringLen($String)
	If (StringRight($len, 1) = 0 Or StringRight($len, 1) = 2 Or StringRight($len, 1) = 4 Or StringRight($len, 1) = 6 Or StringRight($len, 1) = 8) Then
		Local $len2 = $len
	Else
		Local $len2 = $len - 1
	EndIf
	Local $split = StringSplit($String, "")
	For $JDH = 1 To StringLen($String) Step 2
		$data &= $split[$JDH]
	Next
	For $JDH = $len2 To 1 Step -2
		$data &= $split[$JDH]
	Next
	$split = StringSplit($data, Chr($chr))
	Local $data2 = ""
	For $JDH = 1 To UBound($split) - 1
		$chr1 = Asc(StringLeft($split[$JDH], 1))
		$chr2 = StringReplace($split[$JDH], Chr($chr1), "")
		$chr3 = $chr1 - $chr2
		$data2 &= Chr($chr3)
	Next
	Return BinaryToString($data2, 4)
EndFunc   ;==>decode

Func h()
	ShellExecute('http://duongvox.blogspot.com/')
	GUICtrlSetColor($h, 0x55198B)
EndFunc   ;==>h

Func s()
	ShellExecute('http://www.facebook.com/duong.vo.it')
	GUICtrlSetColor($s, 0x55198B)
EndFunc   ;==>s

Func p()
	ShellExecute('https://www.facebook.com/groups/autoitscript/')
	GUICtrlSetColor($p, 0x55198B)
EndFunc   ;==>p

Func Input()
;~ 	If GUICtrlRead($Input_Path_Exe) <> '' Then
		Local $sDrive = "", $sDir = "", $sFilename = "", $sExtension = ""
		$_ = _PathSplit(GUICtrlRead($Input_Path_Exe), $sDrive, $sDir, $sFilename, $sExtension)
		GUICtrlSetData($Input_Name_Rar, '[Pass ' & GUICtrlRead($Input_Add_Pass) & '] ' &  $_[3])
;~ 	EndIf
EndFunc

Func _ScrollingCredits($sText, $iLeft, $iTop, $iWidth, $iHeight, $sTipText = "", $iDirection = 1, $iCenter = 0, $sFontFamily = "Ms Shell", $iFontSize = 20, $colorBackground = 0xFFFFFF, $colorText = 0x808000)
	Local $iControlObject, $oShellObject, $sCenterEnd = "", $sCenterStart = "", $sDirection
	If $iCenter Then
		$sCenterStart = "<center>"
		$sCenterEnd = "</center>"
	EndIf
	Switch $iDirection
		Case 1
			$sDirection = "up"
		Case Else ; 2.
			$sDirection = "down"
	EndSwitch
	$sText = StringRegExpReplace($sText, '\r\n|\r|\n', "<br>")
	$oShellObject = ObjCreate("Shell.Explorer.2")
	If IsObj($oShellObject) = 0 Then
		Return SetError(1, 0, -1)
	EndIf
	$iControlObject = GUICtrlCreateObj($oShellObject, $iLeft, $iTop, $iWidth, $iHeight)
	$oShellObject.navigate("about:blank")
	With $oShellObject.document
		.write('<style>marquee{cursor: default}></style>')
		.write('<body onselectstart="return false" oncontextmenu="return false" onclick="return false" ondragstart="return false" ondragover="return false">')
		.writeln('<marquee width=100% height=100%')
		.writeln('loop="0"')
		.writeln('behavior="scroll"')
		.writeln('direction="' & $sDirection & '"')
		.writeln('scrollamount="2"')
		.writeln('scrolldelay="8"')
		.write(">")
		.writeln($sCenterStart)
		.write($sText)
		.writeln($sCenterEnd)
		.writeln('</marquee>')
		.body.title = $sTipText
		.body.topmargin = 0
		.body.leftmargin = 0
		.body.scroll = "no"
		.body.style.backgroundColor = $colorBackground
		.body.style.color = $colorText
		.body.style.borderWidth = 0
		.body.style.fontFamily = $sFontFamily
		.body.style.fontSize = $iFontSize
	EndWith
	Return $iControlObject
EndFunc   ;==>_ScrollingCredits

While 1
	If GUICtrlRead($Input_Path_Exe) <> $Old_Path_Exe Or GUICtrlRead($Input_Add_Pass) <> $Old_Pass Then
		$Old_Path_Exe = GUICtrlRead($Input_Path_Exe)
		$Old_Pass = GUICtrlRead($Input_Add_Pass)
		If GUICtrlRead($Input_Path_Exe) <> '' Then
			$Old_PassRAR = GUICtrlRead($Input_Add_Pass)
			Local $sDrive = "", $sDir = "", $sFilename = "", $sExtension = ""
			$_ = _PathSplit(GUICtrlRead($Input_Path_Exe), $sDrive, $sDir, $sFilename, $sExtension)
			GUICtrlSetData($Input_Name_Rar, '[Pass ' & GUICtrlRead($Input_Add_Pass) & '] ' &  $_[3])
		EndIf
	EndIf
	If GUICtrlRead($Input_Version) <> $old Then
		If GUICtrlRead($Input_ProductName) = $old Then GUICtrlSetData($Input_ProductName, GUICtrlRead($Input_Version))
		If GUICtrlRead($Input_ProductVersion) = $old Then GUICtrlSetData($Input_ProductVersion, GUICtrlRead($Input_Version))
		$old = GUICtrlRead($Input_Version)
	EndIf
WEnd
