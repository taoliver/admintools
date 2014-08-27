#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

// definition of admin script class
#include "adminscript.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // register AdminScript type for use in QML
    qmlRegisterType<AdminScript>("Scripts", 1, 0, "AdminScript");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
