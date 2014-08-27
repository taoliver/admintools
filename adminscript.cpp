#include "adminscript.h"

#include <unistd.h>
#include <QString>
#include <QEventLoop>
#include <QApplication>

AdminScript::AdminScript(QObject *parent) :
    QObject(parent)
{
    // connect signals from thread
    connect(&thread, SIGNAL(signalOutput(QString)),
            this, SLOT(updateOutput(QString)));
    connect(&thread, SIGNAL(signalStatus(int)),
            this, SLOT(updateStatus(int)));
    connect(&thread, SIGNAL(signalResult(int)),
            this, SLOT(updateResult(int)));
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
}

// the only entry point to execute the current command in a thread
// called from QML
void AdminScript::runCommand()
{
    // run script in this thread
    //this->runAdminScript(m_command);
    // run script in thread
    thread.runScript(m_command);
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

// slot function called by thread signalOutput
void AdminScript::updateOutput(const QString &output)
{
    setOutput(output);
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

// slot function called by thread signalStatus
void AdminScript::updateStatus(const int &status)
{
    setStatus(status);
}

// slot function called by thread signalResult
void AdminScript::updateResult(const int &result)
{
    //
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
