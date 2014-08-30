#include "adminthread.h"

#include <iostream>
#include <QTextStream>
#include <cstdlib>

using namespace std;

AdminThread::AdminThread(QObject *parent) :
    QThread(parent)
{
    restart = false;
    stop = false;
    abort = false;

    QProcess process;
}

AdminThread::~AdminThread()
{
    mutex.lock();
    abort = true;
    condition.wakeOne();
    mutex.unlock();

    wait();
}

// called from AdminScript class object to stop command
int AdminThread::stopScript()
{

    mutex.lock();
    stop = true;
    condition.wakeOne();
    mutex.unlock();

    return 0;
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
        stop = false;
        mutex.unlock();
    }
}

// actually execute the command here
int AdminThread::executeScript(const QString &command)
{
    int i;
    int &ref = i;
    QString str;
    emit signalOutput(command);
    emit signalOutput("\n");

    // debugging output in threads works
    qDebug("Hello world from thread!");

    // C++ standard stream output
    cout << "Goodbye World from thread!!" << endl;
    str = tr("Goodbye World 2!");
    cout << str.toStdString() << endl;
    fflush(stdout);

    // Qt standard stream output
    QTextStream out(stdout);
    out << tr("Qt signing out from thread!!") << endl;

    QProcess process;
    //process.start("/home/oliver/projects/vm/test");
    process.start(command);

    // now read the output line by line
    // and send to calling thread
    //char buf[1024];
    //qint64 lineLength;
    QString stdout;

    if (!process.waitForStarted())
        return false;

    while (!stop && !abort) {
        if (!process.waitForReadyRead())
           return false;
        stdout = process.readAllStandardOutput();
        //lineLength = process.readLine(buf, sizeof(buf));
        //if (lineLength == -1) {
            // end of stream
        //    break;
        //}
        emit signalOutput(stdout);
        //emit signalOutput("zzz\n");
    }

    // terminate process, if it hasn't stopped already
    process.close();

    //if (!process.waitForFinished())
    //    return false;

    //process.waitForFinished(-1); // will wait forever until finished
    //QString stdout = process.readAllStandardOutput();
    //QString stderr = process.readAllStandardError();

    //emit signalStatus(i);
    emit signalOutput(stdout);
    // successful execution - return 0
    emit signalResult(0);
    return 0;
}

