# Win Explorer AutoFix

<p align="center">
  <b>A lightweight, zero-UAC background utility designed to fix the Windows 10 & 11 startup black screen issue caused by unresponsive <code>explorer.exe</code> shell initialization.</b>
</p>

<p align="center">
  <a href="https://github.com/Bravee9/win-explorer-autofix/releases/latest">
    <img src="https://img.shields.io/github/v/release/Bravee9/win-explorer-autofix?color=0078D4&logo=github&label=Release" alt="Latest Release">
  </a>
  <img src="https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011-0078D4?logo=windows&logoColor=white" alt="Platform: Windows 10/11">
  <img src="https://img.shields.io/badge/Zero--UAC-Native%20User%20Scope-success" alt="Zero UAC">
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License: MIT">
  </a>
</p>

<p align="center">
  <img src="images/sample.png" alt="Win Explorer AutoFix Preview" width="650" />
</p>

---

## 📥 Tải về / Downloads

Bấm vào nút bên dưới để tải trực tiếp phiên bản bạn mong muốn:

<p align="center">
  <a href="https://github.com/Bravee9/win-explorer-autofix/releases/latest/download/WinExplorerAutoFix-Setup.exe">
    <img src="https://img.shields.io/badge/TẢI_BẢN_CÀI_ĐẶT-.EXE%20(Khuyên%20Dùng)-0078D4?style=for-the-badge&logo=windows&logoColor=white" alt="Download Installer .exe" height="42">
  </a>
  &nbsp;&nbsp;
  <a href="https://github.com/Bravee9/win-explorer-autofix/releases/latest/download/WinExplorerAutoFix-Portable.zip">
    <img src="https://img.shields.io/badge/TẢI_BẢN_THỦ_CÔNG-.ZIP%20(Portable)-6c757d?style=for-the-badge&logo=archive&logoColor=white" alt="Download Portable .zip" height="42">
  </a>
</p>

| Phiên bản / Package | Định dạng | Dành cho ai | Tải nhanh |
| :--- | :---: | :--- | :---: |
| **Bản Cài Đặt (Installer)** ⭐ | `.exe` | **Người dùng phổ thông**: Chỉ cần tải về và nhấp đúp chuột để cài. Có hỗ trợ gỡ cài đặt chuẩn trong Windows Settings. | [**Tải về .EXE**](https://github.com/Bravee9/win-explorer-autofix/releases/latest/download/WinExplorerAutoFix-Setup.exe) |
| **Bản Thủ Công (Portable)** | `.zip` | **Người dùng nâng cao**: Muốn tự giải nén xem mã nguồn và chạy file kịch bản `.bat`. | [**Tải về .ZIP**](https://github.com/Bravee9/win-explorer-autofix/releases/latest/download/WinExplorerAutoFix-Portable.zip) |

> [!NOTE]
> *Nếu bạn không thể tải qua nút trên, hãy vào trang [**Releases**](https://github.com/Bravee9/win-explorer-autofix/releases) để chọn phiên bản mới nhất.*

---

## 🚀 Hướng Dẫn Sử Dụng (Dành Cho Mọi Người)

### Dành cho Bản Cài Đặt (.exe) — Khuyên dùng:
1. Bấm nút **[TẢI BẢN CÀI ĐẶT .EXE]** ở trên.
2. Nhấp đúp chuột vào file `WinExplorerAutoFix-Setup.exe` vừa tải về.
3. Bấm **Install** ➔ Hoàn tất!
4. *(Nếu xuất hiện thông báo xanh của Windows "Windows protected your PC")*:
   - Bấm vào dòng chữ **More info** (Thông tin khác).
   - Chọn **Run anyway** (Vẫn chạy).

### Dành cho Bản Thủ Công (.zip):
1. Bấm nút **[TẢI BẢN THỦ CÔNG .ZIP]** và giải nén (Extract All) thư mục tải về.
2. Nhấp đúp chuột vào file `Install.bat`.

---

## 🗑️ Cách Gỡ Cài Đặt (Uninstallation)

- **Nếu bạn cài bằng bản `.exe`**: Mở Windows **Settings** (Cài đặt) ➔ **Apps** (Ứng dụng) ➔ **Installed Apps** (Ứng dụng đã cài đặt) ➔ Tìm `Win Explorer AutoFix` và bấm **Uninstall**.
- **Nếu bạn dùng bản `.zip`**: Chỉ cần chạy file `Uninstall.bat`.

---

## 📖 English Documentation

### Problem
On certain Windows 10 and Windows 11 systems, the desktop shell (`explorer.exe`) fails to initialize during user logon, resulting in a black screen with no taskbar or desktop icons. Users typically have to launch Task Manager (`Ctrl + Shift + Esc`) and restart `explorer.exe` manually.

### Solution
**Win Explorer AutoFix** automates shell recovery completely in the background:
- **Silent & Background**: Executes minimized without console popups or disturbing your login experience.
- **Zero-UAC Requirement**: Deploys entirely within user profile scope (`%LOCALAPPDATA%`), requiring no administrator privileges.
- **Pure Native Implementation**: Built on native PowerShell without legacy VBScript/MSHTA dependencies, ensuring compatibility with Windows 11 24H2+.
- **Process Verification**: Verifies hung shell termination before relaunching, followed by a post-launch health check.

### Quick Start
1. Download [WinExplorerAutoFix-Setup.exe](https://github.com/Bravee9/win-explorer-autofix/releases/latest/download/WinExplorerAutoFix-Setup.exe).
2. Run the installer and click **Install**.
3. *(If Windows SmartScreen prompts "Windows protected your PC")*: Click **More info** ➔ **Run anyway**.

---

## 🇻🇳 Tiếng Việt (Chi Tiết Kỹ Thuật)

### Vấn đề
Trên một số phiên bản Windows 10 và 11, tiến trình `explorer.exe` có thể bị nghẽn trong giai đoạn khởi tạo đồ họa và nạp hồ sơ người dùng, dẫn đến hiện tượng màn hình đen không thanh Taskbar và icon.

### Giải pháp
Win Explorer AutoFix chạy ngầm một kịch bản nhẹ lúc đăng nhập:
1. Cho phép Windows hoàn tất khởi tạo driver đồ họa trong vài giây đầu.
2. Kiểm tra và giải phóng an toàn tiến trình `explorer.exe` đang bị treo.
3. Tự động tái khởi chạy `explorer.exe` từ thư mục gốc hệ thống (`%SystemRoot%`).
4. Kiểm tra sức khỏe tiến trình lần hai để đảm bảo giao diện Desktop đã hiện đầy đủ.

---

## 📁 Cấu Trúc Dự Án (Project Structure)

```text
win-explorer-autofix/
├── .github/
│   └── workflows/
│       └── release.yml        # CI/CD tự động đóng gói & xuất bản Release
├── core/
│   ├── fix.ps1                # Kịch bản khôi phục shell nền tảng
│   ├── install.ps1            # Cài đặt thủ công bằng PowerShell
│   └── uninstall.ps1          # Gỡ cài đặt thủ công bằng PowerShell
├── images/
│   └── sample.png             # Ảnh minh họa giao diện
├── build.ps1                  # Script đóng gói Setup .exe & Portable .zip
├── installer.iss              # Kịch bản đóng gói Inno Setup 6
├── Install.bat                # Trình khởi chạy cài đặt thủ công
├── Uninstall.bat              # Trình khởi chạy gỡ cài đặt thủ công
├── README.md                  # Tài liệu hướng dẫn
└── LICENSE                    # Giấy phép mã nguồn mở MIT
```

---

## 🛠️ Tự Đóng Gói Tại Máy (Building Locally)

Nếu bạn muốn tự biên dịch ra file `.exe` cài đặt:
1. Đảm bảo máy đã cài [Inno Setup 6](https://jrsoftware.org/isdl.php) (hoặc chạy: `winget install JRSoftware.InnoSetup`).
2. Mở PowerShell trong thư mục dự án và chạy:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\build.ps1
   ```
3. Toàn bộ file cài đặt `.exe` và file `.zip` sẽ nằm gọn trong thư mục `release/`.

---

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for details.
