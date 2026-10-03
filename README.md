# KOReader Scriptlets

This repository contains custom scriptlets for jailbroken Amazon Kindle devices.

## 📦 Included Scriptlets

### `install_kindle_hid_passthrough.sh`
A one-click installer scriptlet that automatically downloads and installs the complete **Kindle HID Passthrough** suite directly from the device.

**Features:**
- Downloads the latest release tarball automatically.
- Installs the entire suite, including:
  - BTManager (Bluetooth Manager UI)
  - Button Mapper (Gamepad mapping)
  - KOReader Plugin
- Contains a customized minimal UI with small log outputs.
- Displays a custom "Bluetooth Installer" icon in the Kindle library.

## ⚙️ How to use
1. Copy `install_kindle_hid_passthrough.sh` to the `documents/` folder on your Kindle via USB.
2. Eject your Kindle safely and open your library.
3. Tap on the **Bluetooth Installer** item to run the script.
4. Ensure your Kindle is connected to WiFi before running, as it downloads the latest package directly from GitHub.
5. The device screen will clear after installation. Please restart your Kindle afterward.

## 🔗 Credits and Acknowledgements
This scriptlet relies heavily on the amazing [Kindle HID Passthrough](https://github.com/zampierilucas/kindle-hid-passthrough) project by [zampierilucas](https://github.com/zampierilucas). All core functionality, modules, and the main installation script belong to the original author. This scriptlet merely serves as an automated wrapper for convenience.
