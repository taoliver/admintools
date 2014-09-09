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
    connect(&thread, SIGNAL(signalRunning(bool)),
            this, SLOT(updateRunning(bool)));
    connect(&thread, SIGNAL(signalResult(int)),
            this, SLOT(updateResult(int)));
}

QString AdminScript::command() const
{
    return m_command;
}

void AdminScript::setCommand(const QString &command)
{
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
    thread.runScript(m_command, m_detached);
    // set start time for command
    QDateTime now = QDateTime::currentDateTime();
    setStartTime(now.toString());
}

// the only entry point to stop the current command and kill its thread
// called from QML
void AdminScript::stopCommand()
{
    // run script in thread
    thread.stopScript();
}

// detach process?
bool AdminScript::detached() const
{
    return m_detached;
}

void AdminScript::setDetached(const bool &detached)
{
    m_detached = detached;
    emit detachedChanged();
}

QString AdminScript::output() const
{
    return m_output;
}

void AdminScript::setOutput(const QString &output)
{
    m_output = output;
    emit outputChanged();
}

// slot function called by thread signalOutput
void AdminScript::updateOutput(const QString &output)
{
    m_output = m_output + output;
    emit outputChanged();
    // update elapsed time
    QDateTime now = QDateTime::currentDateTime();
    qint64 elapsed = m_startTime.msecsTo(now);
    setElapsedTime(QString::number(elapsed));
}

// progress towards completion or some integral value...
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

// process running or not?
bool AdminScript::running() const
{
    return m_running;
}

void AdminScript::setRunning(const bool &running)
{
    m_running = running;
    emit runningChanged();
}

// slot function called by thread signalRunning
void AdminScript::updateRunning(const bool &running)
{
    setRunning(running);
}

QString AdminScript::startTime() const
{
    return m_sstartTime;
}

void AdminScript::setStartTime(const QString &time)
{
    m_sstartTime = time;
    m_startTime = QDateTime::fromString(time);
    emit startTimeChanged();
}

QString AdminScript::elapsedTime() const
{
    return m_selapsedTime;
}

void AdminScript::setElapsedTime(const QString &time)
{
    qint64 t = time.toLongLong();
    m_elapsedTime = t;
    int ms = t%1000;
    t = (t/1000);
    int s = t%60;
    t = (t/60);
    int m = t%60;
    t = (t/60);
    int h = t/60;
    t = (t/60);
    QTime elapsed = QTime(h, m, s, ms);
    m_selapsedTime = elapsed.toString();
    emit elapsedTimeChanged();
}

// slot function called by thread signalResult
void AdminScript::updateResult(const int &result)
{
    //
}
