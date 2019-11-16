QT += quick qml sql network

CONFIG += c++11


DEFINES += QT_DEPRECATED_WARNINGS


HEADERS += sqlcontactmodel.h \
    sqlconversationmodel.h \
    connection.h \
    appsettings.h

SOURCES += main.cpp \
    sqlcontactmodel.cpp \
    sqlconversationmodel.cpp \
    connection.cpp \
    appsettings.cpp

RESOURCES += qml.qrc
#OTHER_FILES += _android/AndroidМanifest.xml


qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#DISTFILES +=
