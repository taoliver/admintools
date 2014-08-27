#include "adminthread.h"

AdminThread::AdminThread(QObject *parent) :
    QThread(parent)
{
    restart = false;
    abort = false;
}

AdminThread::~AdminThread()
{
    mutex.lock();
    abort = true;
    condition.wakeOne();
    mutex.unlock();

    wait();
}

// called from AdminScript class object to run command
int AdminThread::runScript(const QString &command)
{
    QMutexLocker locker(&mutex);

    this->command = command;

    if (!isRunning()) {
        start(LowPriority);
    } else {
        restart = true;
        condition.wakeOne();
    }
    return 0;
}

void AdminThread::run()
{
    while (true) {

        // get command to execute
        mutex.lock();
        QString command = this->command;
        mutex.unlock();

        // check for abort to terminate thread
        if (abort)
            return;

        // execute command
        executeScript(command);

        // wait for next command
        mutex.lock();
        if (!restart)
            condition.wait(&mutex);
        restart = false;
        mutex.unlock();
    }
}

int AdminThread::executeScript(const QString &command)
{
    int i;
    int &ref = i;
    QString str;
    emit signalOutput(command);
    emit signalOutput("\n");
    for (i=0;i<10;i++)
    {
        str = str.setNum(i);
        output = str;
        emit signalOutput(output);
        emit signalStatus(i);
        sleep(1);
    }
    emit signalOutput("\n");
    // successful execution - return 0
    emit signalResult(0);
    return 0;
}

int AdminThread::executeScript2(const QString &command)
{
    int i;
    int &ref = i;
    QString str;
    //if (!restart) {
        emit signalOutput(command);
        emit signalOutput("\n");
    //}
    for (i=0;i<10;i++)
    {
        str = str.setNum(i);
        output = str;
        //if (!restart) {
            emit signalOutput(output);
            emit signalStatus(i);
        //}
        sleep(1);
    }
    //if (!restart) {
        emit signalOutput("\n");
        // successful execution - return 0
        emit signalResult(0);
    //}
    return 0;
}
