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

    int runScript(const QString &command);
    int stopScript();

signals:
    void signalOutput(const QString &output);
    void signalStatus(const int status);
    void signalResult(const int status);

public slots:

protected:
    void run();

private:
    int executeScript(const QString &command);

    QMutex mutex;
    QWaitCondition condition;
    bool restart;
    bool stop;
    bool abort;

    QString command;
    QString output;
    int status;
    QProcess process;

};

#endif // ADMINTHREAD_H
