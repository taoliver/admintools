#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QIcon>
#include <iostream>
#include <QTextStream>
#include <cstdlib>

using namespace std;

// definition of admin script class
#include "adminscript.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // set application icon
    //app.setWindowIcon(QIcon("/usr/share/icons/hicolor/32x32/apps/vlc.xpm"));
    //app.setWindowIcon(QIcon("/usr/share/icons/hicolor/32x32/apps/kfind.png"));
    //app.setWindowIcon(QIcon("/usr/share/icons/hicolor/32x32/apps/cantor.png"));
    app.setWindowIcon(QIcon(":/admintools.png"));
    //app.setWindowIcon(QIcon("/home/oliver/projects/qt/admintools/admintools/admintools.png"));

    // debug logging to QtCreator console or command line if invoked from command line
    qDebug("Hello world!");

    // C++ standard stream output
    std::cout << "Goodbye World!" << endl;
    std::cout << "Goodbye World!" << endl;
    fflush(stdout);

    // Qt standard stream output
    QTextStream out(stdout);
    out << "Qt signing out!" << endl;

    // register AdminScript type for use in QML
    qmlRegisterType<AdminScript>("Scripts", 1, 0, "AdminScript");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
