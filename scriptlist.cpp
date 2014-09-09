#include "scriptlist.h"

ScriptList::ScriptList(QObject *parent) :
    QObject(parent)
{
}

// return the scriptlist QQmlListProperty object
QQmlListProperty<AdminScript> ScriptList::scripts()
{
/*
    return QQmlListProperty<AdminScript>(this, (void*)m_data, &ScriptList::scriptAppend,
                                         &ScriptList::scriptCount, &ScriptList::scriptAt,
                                         &ScriptList::scriptClear);
                                         */
    //return QQmlListProperty<AdminScript>(this, (void*)m_data, &ScriptList::scriptAppend); //,0,0,0);

    return QQmlListProperty<AdminScript>(this, m_scripts);
}

// apend an item to script list
void ScriptList::scriptAppend(AdminScript *script) //const
{//
    m_scripts.append(script);
}

// return the script at position
AdminScript *ScriptList::scriptAt(int index) //const
{
    return m_scripts.at(index);
}

// clear script list
void ScriptList::scriptClear() //const
{
    m_scripts.clear();
}

// return the number of scripts in list
int ScriptList::scriptCount() //const
{
    return m_scripts.count();
}
