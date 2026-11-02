# Win Explorer AutoFix 🚀

A lightweight, 1-click zero-friction utility to automatically fix Windows 10/11 black screen on boot caused by hung/delayed `explorer.exe` startup.

---

### 🇻🇳 Tiếng Việt

#### Vấn đề
Mỗi khi khởi động Windows 10/11, đôi khi màn hình bị đen, taskbar và desktop icon không xuất hiện. Người dùng phải mở Task Manager (`Ctrl + Shift + Esc`) và restart `explorer.exe` bằng tay rất ức chế.

#### Giải pháp
**Win Explorer AutoFix** giải quyết hoàn toàn vấn đề này một cách tự động và vô hình:
* **Cài đặt 1-Click**: Chỉ cần tải về và nhấp đúp vào `Install.bat`.
* **Chạy ngầm 100% (Silent)**: Không hiện cửa sổ đen CMD hay PowerShell nhấp nháy làm gián đoạn trải nghiệm.
* **Không cần quyền Administrator (Zero-UAC)**: Cài đặt và chạy an toàn trong không gian người dùng (`%LOCALAPPDATA%`).
* **Tự động sao chép**: Bạn có thể xóa file đã tải về sau khi cài đặt, công cụ sẽ tồn tại vĩnh viễn và tự kích hoạt mỗi khi mở máy.
* **Gỡ cài đặt sạch sẽ**: Nhấp đúp vào `Uninstall.bat` để xóa hoàn toàn không để lại rác.

#### Hướng dẫn cài đặt
1. Tải bản mới nhất từ [Releases](../../releases) (hoặc bấm **Code > Download ZIP**).
2. Giải nén file vừa tải.
3. Nhấp đúp vào file **`Install.bat`**.
4. Hộp thoại xác nhận sẽ hiện lên báo thành công. Xong!

---

### 🇬🇧 English

#### The Problem
On Windows 10/11 startup, you may occasionally encounter a black screen where desktop icons and the taskbar fail to load. The only workaround is opening Task Manager (`Ctrl + Shift + Esc`) and restarting `explorer.exe` manually.

#### The Solution
**Win Explorer AutoFix** automates this entirely:
* **1-Click Installation**: Simply run `Install.bat`.
* **100% Invisible**: Runs quietly in the background without any flashing console windows.
* **No Admin Privileges Needed**: Runs safely under the current user's profile without prompting UAC.
* **Self-Contained**: Automatically moves core scripts to `%LOCALAPPDATA%`. You can safely delete the downloaded folder after running `Install.bat`.
* **Clean Uninstaller**: Run `Uninstall.bat` to completely remove all traces.

#### Quick Start
1. Download or clone this repository.
2. Double-click **`Install.bat`**.
3. A confirmation dialog will pop up. You're all set!

---

### 📂 Repository Structure

```text
win-explorer-autofix/
├── Install.bat        # 1-Click installer
├── Uninstall.bat      # Clean uninstaller
├── core/
│   ├── fix.ps1        # Core logic: gracefully kills & restarts explorer.exe
│   └── silent.vbs     # Hidden runner: executes script invisibly
├── README.md
└── LICENSE
```

### 📄 License
This project is licensed under the [MIT License](LICENSE).
