; Win Explorer AutoFix - Inno Setup Script
#define MyAppName "Win Explorer AutoFix"
#define MyAppVersion "1.1.0"
#define MyAppPublisher "Bravee9"
#define MyAppURL "https://github.com/Bravee9/black-screen-windows-10-11-fix"

[Setup]
AppId={{C68D37F2-4EA8-46FE-85E5-7B27C12DF31A}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}/issues
AppUpdatesURL={#MyAppURL}/releases
DefaultDirName={localappdata}\AutoFixExplorer
DisableDirPage=yes
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
OutputDir=release
OutputBaseFilename=WinExplorerAutoFix-Setup
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
UninstallDisplayName={#MyAppName}
CloseApplications=no

[Languages]
Name: "vi"; MessagesFile: "compiler:Default.isl"
Name: "en"; MessagesFile: "compiler:Default.isl"

[Messages]
vi.SetupWindowTitle=%1 - Trình cài đặt
vi.WelcomeLabel1=Chào mừng đến với trình cài đặt %1
vi.WelcomeLabel2=Tiện ích này tự động phát hiện và khôi phục sự cố màn hình đen khi khởi động Windows 10 & 11 thông qua cơ chế giám sát Win32 API thông minh.%n%nBấm "Tiếp tục" để bắt đầu cài đặt.
vi.ClickNext=Bấm "Cài đặt" để tiến hành, hoặc "Hủy" để thoát.
vi.ButtonNext=Tiếp tục >
vi.ButtonInstall=Cài đặt
vi.ButtonCancel=Hủy
vi.FinishedHeadingLabel=Cài đặt thành công!
vi.FinishedLabel=%1 đã được cấu hình hoàn tất. Tiến trình sẽ tự động chạy ngầm bảo vệ Windows mỗi khi bạn đăng nhập.%n%nBạn có thể gỡ cài đặt bất kỳ lúc nào trong Windows Settings > Installed Apps.
vi.ButtonFinish=Hoàn tất

en.SetupWindowTitle=%1 Setup
en.WelcomeLabel1=Welcome to the %1 Setup
en.WelcomeLabel2=This utility automatically detects and resolves the Windows 10 & 11 startup black screen issue using intelligent Win32 API shell inspection.%n%nClick Next to proceed with installation.
en.ClickNext=Click Install to proceed, or Cancel to exit.
en.FinishedHeadingLabel=Installation Complete
en.FinishedLabel=%1 has been configured successfully. It will now protect your Windows startup silently in the background.

[Files]
Source: "core\fix.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "core\config.json"; DestDir: "{app}"; Flags: onlyifdoesntexist

[Icons]
Name: "{userstartup}\AutoFixExplorer"; Filename: "powershell.exe"; Parameters: "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File ""{app}\fix.ps1"""; WorkingDir: "{app}"; IconFilename: "{sys}\shell32.dll"; IconIndex: 238; Comment: "Win Explorer AutoFix background recovery utility"

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
Type: files; Name: "{userstartup}\AutoFixExplorer.lnk"
