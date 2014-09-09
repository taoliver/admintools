#ifndef SCRIPTLIST_H
#define SCRIPTLIST_H

#include <QObject>
#include <QQmlListProperty>
#include "adminscript.h"

// nasty, hacky global data for now....
//extern QList<int> m_data;
extern QList<AdminScript *> m_scripts;
//extern QList<AdminScript> m_scripts;

class ScriptList : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QQmlListProperty<AdminScript> scripts READ scripts)
    Q_CLASSINFO("DefaultProperty", "scripts")

public:
    explicit ScriptList(QObject *parent = 0);

    QQmlListProperty<AdminScript> scripts();

signals:

public slots:

private:
    void scriptAppend(AdminScript *script); // const;
    AdminScript *scriptAt(int); //const;
    void scriptClear(); //const;
    int scriptCount(); //const;

    //AdminScript *m_script;
//    QList<AdminScript *> m_scripts;
    //int* m_data;
};

#endif // SCRIPTLIST_H
