#ifndef ADMINTHREAD_H
#define ADMINTHREAD_H

#include <QThread>
#include <QMutex>
#include <QWaitCondition>
#include <QProcess>

class AdminThread : public QThread
{
    Q_OBJECT
public:
    explicit AdminThread(QObject *parent = 0);
    ~AdminThread();

    int runScript(const QString &command, bool detached);
    int stopScript();

    // useful constants
    static const int ADMIN_ERR = 1; // error

signals:
    void signalOutput(const QString &output);
    void signalStatus(const int status);
    void signalRunning(const bool running);
    void signalResult(const int status);

public slots:

protected:
    void run();

private:
    int executeScript(const QString &command);
    int executeScriptDetached(const QString &command);

    QMutex mutex;
    QWaitCondition condition;
    bool restart;
    bool stop;
    bool abort;
    bool running;
    bool detached;

    QString command;
    QString output;
    int status;
    QProcess process;

};

#endif // ADMINTHREAD_H
