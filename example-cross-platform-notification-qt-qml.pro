QT += quick quickcontrols2 widgets

# Qt uses this to build Info.plist
VERSION = 1.0.0

ANDROID_VERSION_CODE = "1"
ANDROID_VERSION_NAME = $$VERSION
ANDROID_MIN_SDK_VERSION="24"
ANDROID_TARGET_SDK_VERSION="34"


HEADERS += \
    src/Adapters/OSAdapter.h \
    src/Managers/ApplicationManager.h

SOURCES += \
        src/main.cpp \
        src/Managers/ApplicationManager.cpp

RESOURCES += resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

android {
    HEADERS += \
    src/Adapters/AndroidAdapter.h \

    SOURCES += \
    src/Adapters/AndroidAdapter.cpp \

    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android

    contains(ANDROID_TARGET_ARCH,x86_64) {
        ANDROID_PACKAGE_SOURCE_DIR = \
            $$PWD/android
    }

    DISTFILES += \
        android/AndroidManifest.xml \
        android/src/org/qtproject/notification/QtAndroidNotification.java

    # https://bugreports.qt.io/browse/QTBUG-88583
    # ANDROID_ABIS = armeabi-v7a arm64-v8a x86 x86_64
    ANDROID_ABIS = x86_64
}

ios {
    QMAKE_INFO_PLIST = ios/Info.plist
    QMAKE_TARGET_BUNDLE_PREFIX = org.qtproject
    QMAKE_BUNDLE = viewer
    QMAKE_APPLICATION_BUNDLE_NAME = Cross Platform Notification

    LIBS += -framework UIKit
    LIBS += -framework Foundation
    LIBS += -framework UserNotifications

    HEADERS += \
    src/Adapters/IOSAdapter.h \

    SOURCES += \
    src/Adapters/IOSAdapter.mm \

    OBJECTIVE_SOURCES += \
    src/Adapters/IOSAdapter.mm \
}

!android:!ios {
    QT += widgets

    HEADERS += \
    src/Adapters/DesktopAdapter.h \

    SOURCES += \
    src/Adapters/DesktopAdapter.cpp \
}
