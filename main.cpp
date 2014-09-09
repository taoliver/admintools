#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QIcon>
#include <iostream>
#include <QTextStream>
#include <cstdlib>
#include <QTranslator>
#include <QString>

using namespace std;

// definition of admin script class
#include "adminscript.h"

// definition of script list class
#include "scriptlist.h"

// definition of script list model class
#include "scriptlistmodel.h"

// nasty, hacky global data for now....
QList<int> m_data;
QList<AdminScript *> m_scripts;
//QList<AdminScript> m_scripts;

int main(int argc, char *argv[])
{
    // nasty, hacky global data for now....
    //QList<int> m_data;

    QApplication app(argc, argv);

    // executable file directory
    QString base = QCoreApplication::applicationDirPath();

    // set application icon
    app.setWindowIcon(QIcon(":/admintools.png"));

    // debug logging to QtCreator console or command line if invoked from command line
    qDebug("Hello world!");

    // C++ standard stream output
    //cout << QObject::tr("Goodbye World!") << endl;
    //cout << app.tr("Goodbye World!") << endl;
    fflush(stdout);

    // Qt standard stream output
    QTextStream out(stdout);
    //out << app.tr("Qt signing out!") << endl;"Qt signing out!" << endl;

    // register ScriptList type for QML
    qmlRegisterType<ScriptList>("Scripts", 1, 0, "ScriptList");

    // register AdminScript type for use in QML
    qmlRegisterType<AdminScript>("Scripts", 1, 0, "AdminScript");

    // register AdminScript type for use in QML
    qmlRegisterType<ScriptListModel>("Scripts", 1, 0, "ScriptListModel");

    // get current locale
    QString locale = QLocale::system().name();

    // load translation for locale
    // use relative path while developing
    // use search path for proper deployment?
    QTranslator translator;
    QString trans = base + "/../admintools/admintools_" + locale;
    out << locale << endl;
    out << base << endl;
    out << trans << endl;
    translator.load(trans);
    app.installTranslator(&translator);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
