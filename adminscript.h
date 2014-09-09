#ifndef ADMINSCRIPT_H
#define ADMINSCRIPT_H

#include <QObject>
#include <QDateTime>
#include <QTime>

#include "adminthread.h"

class AdminScript : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString command READ command WRITE setCommand NOTIFY commandChanged)
    Q_PROPERTY(bool detached READ detached WRITE setDetached NOTIFY detachedChanged)
    Q_PROPERTY(QString output READ output WRITE setOutput NOTIFY outputChanged)
    Q_PROPERTY(int status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(bool running READ running WRITE setRunning NOTIFY runningChanged)
    Q_PROPERTY(QString startTime READ startTime WRITE setStartTime NOTIFY startTimeChanged)
    Q_PROPERTY(QString elapsedTime READ elapsedTime WRITE setElapsedTime NOTIFY elapsedTimeChanged)

public:
    explicit AdminScript(QObject *parent = 0);

    QString command() const;
    void setCommand(const QString &command);
    bool detached() const;
    void setDetached(const bool &detached);
    QString output() const;
    void setOutput(const QString &output);
    int status() const;
    void setStatus(const int &status);
    bool running() const;
    void setRunning(const bool &running);
    QString startTime() const;
    void setStartTime(const QString &time);
    QString elapsedTime() const;
    void setElapsedTime(const QString &time);

    Q_INVOKABLE void runCommand();
    Q_INVOKABLE void stopCommand();


signals:
    void commandChanged();
    void detachedChanged();
    void outputChanged();
    void statusChanged();
    void runningChanged();
    void startTimeChanged();
    void elapsedTimeChanged();

public slots:

private slots:
    void updateOutput(const QString &command);
    void updateStatus(const int &status);
    void updateRunning(const bool &running);
    void updateResult(const int &result);

private:
    QString m_command;
    bool m_detached;
    QString m_output;
    int m_status;
    bool m_running;
    QString m_sstartTime;
    QString m_selapsedTime;
    QDateTime m_startTime;
    qint64 m_elapsedTime;

    // command execution thread
    AdminThread thread;

    int runAdminScript(const QString &command);

};

#endif // ADMINSCRIPT_H
