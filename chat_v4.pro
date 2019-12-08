QT += quick qml sql network

CONFIG += c++11

TARGET = RearmChat

DEFINES += QT_DEPRECATED_WARNINGS


HEADERS += sqlcontactmodel.h \
    sqlconversationmodel.h \
    connection.h

SOURCES += main.cpp \
    sqlcontactmodel.cpp \
    sqlconversationmodel.cpp \
    connection.cpp

RESOURCES += qml.qrc


qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#DISTFILES +=

# uncomment this if you build to Android
DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}
