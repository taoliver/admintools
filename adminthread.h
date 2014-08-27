#ifndef ADMINTHREAD_H
#define ADMINTHREAD_H

#include <QThread>
#include <QMutex>
#include <QWaitCondition>

class AdminThread : public QThread
{
    Q_OBJECT
public:
    explicit AdminThread(QObject *parent = 0);
    ~AdminThread();

    int runScript(const QString &command);

signals:
    void signalOutput(const QString &output);
    void signalStatus(const int status);
    void signalResult(const int status);

public slots:

protected:
    void run();

private:
    int executeScript(const QString &command);
    int executeScript2(const QString &command);

    QMutex mutex;
    QWaitCondition condition;
    bool restart;
    bool abort;

    QString command;
    QString output;
    int status;

};

#endif // ADMINTHREAD_H
