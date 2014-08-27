#include "adminscript.h"
#include <unistd.h>
#include <QString>
#include <QEventLoop>
#include <QApplication>

AdminScript::AdminScript(QObject *parent) :
    QObject(parent)
{
}

QString AdminScript::command() const
{
    return m_command;
}

void AdminScript::setCommand(const QString &command)
{
    //int res;
    m_command = command;
    emit commandChanged();
    // run script
    //runAdminScript(m_command);
}

void AdminScript::runCommand()
{
    // run script
    this->runAdminScript(m_command);
}

QString AdminScript::output() const
{
    return m_output;
}

void AdminScript::setOutput(const QString &output)
{
    m_output = m_output + output;
    emit outputChanged();
}

int AdminScript::status() const
{
    return m_status;
}

void AdminScript::setStatus(const int &status)
{
    m_status = status;
    emit statusChanged();
}

int AdminScript::runAdminScript(const QString &command)
{
    int i;
    int &ref = i;
    QString str;
    for (i=0;i<5;i++)
    {
        str = str.setNum(i);
        this->setStatus(ref);
        this->setOutput(str);
        QApplication::processEvents(QEventLoop::AllEvents);
        sleep(1);
    }
    return 0;
}
