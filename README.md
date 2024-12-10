# Cross Platform Notification Example in QT / QML

## About

This is a mix of public codes and examples put together and ported to QT 6+.

I intentionally decided to use QSystemTrayIcon (C++) instead of its QML counterpart, for the Desktop Enviroment.

I also tried to be most faithful to the original `System Tray Icon Example` but I didn't care for a few parts and I would definitely change others.

## Code Origin & Inspiration

- Toast Notification is a rework of an older adaptation of mine at [Authentication Example in QT / QML](https://github.com/LeonnardoVerol/example-authentication-qt-qml/tree/main)
- Mobile Code from [qt-notification](https://github.com/SidoPillai/qt-notification)
- [System Tray Icon Example (Qt 5.15 - Widgets)](https://doc.qt.io/qt-5/qtwidgets-desktop-systray-example.html)
- [Qt Notifier Qt 5.15](https://doc.qt.io/qt-5/qtandroidextras-notification-example.html)
- [Qt Android Notifier Qt 6+](https://doc.qt.io/qt-6/qtcore-platform-androidnotifier-example.html)

## TODO

- Background Service
- Notification Message Clicked Event for Android
- Notification Message Clicked Event for iOs
