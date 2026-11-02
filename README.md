# Win Explorer AutoFix

A lightweight background utility designed to resolve the black screen issue on Windows 10 and 11 startup caused by unresponsive `explorer.exe` shell initialization.

<p align="center">
  <img src="images/sample.png" alt="Win Explorer AutoFix Preview" width="650" />
</p>

---

## Overview

### Problem
On certain Windows 10 and Windows 11 configurations, the desktop shell (`explorer.exe`) fails to load during user logon, resulting in a black screen without desktop icons or the taskbar. Manually launching Task Manager (`Ctrl + Shift + Esc`) and restarting `explorer.exe` is typically required to restore normal shell operation.

### Solution
Win Explorer AutoFix automates this recovery process in the background:
- **Silent Execution**: Executes minimized without displaying console windows or interrupting the startup process.
- **Pure Native Implementation**: Built entirely on native PowerShell and .NET components with zero external dependencies (no VBScript/MSHTA), ensuring full compatibility with Windows 11 24H2+.
- **User-Level Scope**: Deploys to `%LOCALAPPDATA%` and the user startup folder without requiring Administrator (UAC) elevation.
- **Process State Validation**: Confirms that the hung process has terminated completely before relaunching the shell, followed by a secondary health check.
- **Self-Contained Deployment**: Automatically places necessary runtime components into the local application directory.

---

## Installation

1. Download the repository source or latest release archive.
2. Extract the archive.
3. Run `Install.bat`.

The installation script registers the background launcher to execute at user logon. The extracted directory may be safely deleted after installation.

## Uninstallation

To remove the utility and all associated startup entries:
1. Run `Uninstall.bat`.

---

## Tiếng Việt

### Tổng quan

#### Vấn đề
Trên một số cấu hình Windows 10 và 11, tiến trình shell hệ thống (`explorer.exe`) có thể bị treo trong giai đoạn đăng nhập, dẫn đến tình trạng màn hình đen không hiển thị thanh tác vụ (Taskbar) và biểu tượng màn hình. Người dùng thường phải mở Task Manager thủ công để khởi động lại tiến trình.

#### Giải pháp
Win Explorer AutoFix tự động hóa quá trình khôi phục:
- **Thực thi ngầm**: Hoạt động ở chế độ thu nhỏ không hiển thị giao diện console hay làm gián đoạn màn hình đăng nhập.
- **Thuần Native PowerShell**: Loại bỏ hoàn toàn VBScript/MSHTA, tương thích tốt với các bản Windows 11 mới nhất (24H2+).
- **Phân quyền người dùng**: Cài đặt trong phạm vi tài khoản hiện tại (`%LOCALAPPDATA%`), không yêu cầu nâng quyền Administrator (UAC).
- **Kiểm tra trạng thái tiến trình**: Đảm bảo tiến trình lỗi đã dừng hẳn trước khi khởi chạy lại shell, kèm bước xác nhận trạng thái hoạt động.
- **Tự động lưu trữ**: Tự sao chép các tệp thực thi vào thư mục hệ thống người dùng sau khi cài đặt.

### Hướng dẫn cài đặt
1. Tải về mã nguồn hoặc bản phát hành.
2. Giải nén thư mục.
3. Chạy tệp `Install.bat`.

### Gỡ cài đặt
Chạy tệp `Uninstall.bat` để loại bỏ toàn bộ tệp và mục khởi động liên quan khỏi hệ thống.

---

## Project Structure

```text
win-explorer-autofix/
├── Install.bat
├── Uninstall.bat
├── core/
│   ├── fix.ps1
│   ├── install.ps1
│   └── uninstall.ps1
├── images/
│   └── sample.png
├── README.md
└── LICENSE
```

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for details.
