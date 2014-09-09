TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    adminscript.cpp \
    adminthread.cpp \
    scriptlist.cpp \
    scriptlistmodel.cpp

RESOURCES += qml.qrc

# by Tim
# specify translations to include
TRANSLATIONS = admintools_fr.ts \
               admintools_de.ts

# specify additional source files for lupdate (but not C++ compiler)
lupdate_only {
SOURCES = *.qml \
          *.js \
          content/*.qml \
          content/*.js
}

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
    adminthread.h \
    scriptlist.h \
    scriptlistmodel.h
