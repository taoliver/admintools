TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    adminscript.cpp \
    adminthread.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += \
    .gitignore \
    TODO \
    README

HEADERS += \
    adminscript.h \
    adminthread.h
