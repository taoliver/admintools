#include "adminthread.h"

#include <iostream>
#include <QTextStream>
#include <cstdlib>

//using namespace std;

AdminThread::AdminThread(QObject *parent) :
    QThread(parent)
{
    restart = false;
    stop = false;
    abort = false;
    running = false;
    detached = false;

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
int AdminThread::runScript(const QString &command, bool detached)
{
    QMutexLocker locker(&mutex);

    this->command = command;
    this->detached = detached;

    if (!isRunning()) {
        start(LowPriority);
    }
    // keeping thread alive for more commands or....
/*    else {
        restart = true;
        condition.wakeOne();
    } */
    // an error - only run once - should never get here
    else {
        qDebug("thread already running somehow");
        return ADMIN_ERR;
    }
    return 0;
}

void AdminThread::run()
{
    // while loop not needed for single-command thread
    while (true) {

        // get command to execute
        mutex.lock();
        QString command = this->command;
        mutex.unlock();

        // check for abort to terminate thread
        if (abort)
            return;

        // execute command
        if (this->detached) {
            // execute detached
            executeScriptDetached(command);
        }
        else {
            // execute and stay attached for output
            executeScript(command);
        }

        // wait for next command
        // just finish for single-command threading
        break;
        /*
        mutex.lock();
        if (!restart)
            condition.wait(&mutex);
        restart = false;
        stop = false;
        mutex.unlock();
        */
    }
}

// actually execute the command here
int AdminThread::executeScriptDetached(const QString &command)
{
    // Qt standard stream output
    QTextStream out(stdout);
    //out << tr("Qt signing out from thread!!") << endl;

    int ec, es, er, st;
    int i;
    int &ref = i;
    QString str;
    emit signalOutput(command);
    emit signalOutput("\n");

    // debugging output in threads works
    //qDebug("Hello world from thread!");

    // C++ standard stream output
    //cout << "Goodbye World from thread!!" << endl;
    //str = tr("Goodbye World 2!");
    //cout << str.toStdString() << endl;
    //fflush(stdout);

    out << tr("about to start: %1").arg(command) << endl;

    QProcess process;
    //process.start("/home/oliver/projects/vm/test");
    process.startDetached(command);

    // now read the output line by line
    // and send to calling thread
    //char buf[1024];
    //qint64 lineLength;
    QString stdout;

    ec = process.exitCode();
    es = process.exitStatus();
    er = process.error();
    st = process.state();

    out << "Exit code: " + QString::number(ec) << endl;
    out << "Exit status: " + QString::number(es) << endl;
    out << "Error: " + QString::number(er) << endl;
    out << "State: " + QString::number(st) << endl;

    if (!process.waitForStarted())
        return false;

    // signal process is now running
    running = true;
    emit signalRunning(running);

    out << tr("started: %1").arg(command) << endl;

    ec = process.exitCode();
    es = process.exitStatus();
    er = process.error();
    st = process.state();

    out << "Exit code: " + QString::number(ec) << endl;
    out << "Exit status: " + QString::number(es) << endl;
    out << "Error: " + QString::number(er) << endl;
    out << "State: " + QString::number(st) << endl;

    // wait for process to terminate, if it hasn't stopped already
    //process.close();

    //out << tr("finished: %1").arg(command) << endl;

    ec = process.exitCode();    // exit code from process run eg
                                // 0 - exit OK
                                // 1 - exit with some error
    es = process.exitStatus();  // 0 - OK
                                // 1 - crash/kill
    er = process.error();       // 0 - failed to start
                                // 1 - crashed
                                // 2 - timedout - can recall waitFor
                                // 3 - write error
                                // 4 - read error
                                // 5 - unknown (default)
    st = process.state();       // 0 - not running
                                // 1 - starting
                                // 2 - running

    out << "Exit code: " + QString::number(ec) << endl;
    out << "Exit status: " + QString::number(es) << endl;
    out << "Error: " + QString::number(er) << endl;
    out << "State: " + QString::number(st) << endl;

    //if (!process.waitForFinished())
    //    return false;

    //process.waitForFinished(-1); // will wait forever until finished
    //QString stdout = process.readAllStandardOutput();
    //QString stderr = process.readAllStandardError();

    //emit signalStatus(i);
    //emit signalOutput(stdout);

    // signal process is now stopped - to reset buttons
    running = false;
    emit signalRunning(running);

    // successful execution - return 0
    emit signalResult(0);
    return 0;
}

// actually execute the command here
int AdminThread::executeScript(const QString &command)
{
    // Qt standard stream output
    QTextStream out(stdout);
    //out << tr("Qt signing out from thread!!") << endl;

    int i;
    int &ref = i;
    QString str;
    emit signalOutput(command);
    emit signalOutput("\n");

    // debugging output in threads works
    //qDebug("Hello world from thread!");

    // C++ standard stream output
    //cout << "Goodbye World from thread!!" << endl;
    //str = tr("Goodbye World 2!");
    //cout << str.toStdString() << endl;
    //fflush(stdout);

    out << tr("about to start: %1").arg(command) << endl;

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

    // signal process is now running
    running = true;
    emit signalRunning(running);

    out << tr("started: %1").arg(command) << endl;

    while (!stop && !abort) {
        // wait for output on timeout or process finished for some reason
        if (!process.waitForReadyRead()) {
            // process finished for some reason so exit from output loop
            out << tr("nothing left to read") << endl;
            break;
        }
        stdout = process.readAllStandardOutput();
        //lineLength = process.readLine(buf, sizeof(buf));
        //if (lineLength == -1) {
            // end of stream
        //    break;
        //}
        emit signalOutput(stdout);
        out << tr("line...") << endl;
        //emit signalOutput("zzz\n");
    }

    int  ec = process.exitCode();
    int  es = process.exitStatus();
    int  er = process.error();
    int  st = process.state();

    out << "Exit code: " + QString::number(ec) << endl;
    out << "Exit status: " + QString::number(es) << endl;
    out << "Error: " + QString::number(er) << endl;
    out << "State: " + QString::number(st) << endl;

    // wait for process to terminate, if it hasn't stopped already
    process.close();

    out << tr("finished: %1").arg(command) << endl;

    ec = process.exitCode();    // exit code from process run eg
                                // 0 - exit OK
                                // 1 - exit with some error
    es = process.exitStatus();  // 0 - OK
                                // 1 - crash/kill
    er = process.error();       // 0 - failed to start
                                // 1 - crashed
                                // 2 - timedout - can recall waitFor
                                // 3 - write error
                                // 4 - read error
                                // 5 - unknown (default)
    st = process.state();       // 0 - not running
                                // 1 - starting
                                // 2 - running

    out << "Exit code: " + QString::number(ec) << endl;
    out << "Exit status: " + QString::number(es) << endl;
    out << "Error: " + QString::number(er) << endl;
    out << "State: " + QString::number(st) << endl;

    //if (!process.waitForFinished())
    //    return false;

    //process.waitForFinished(-1); // will wait forever until finished
    //QString stdout = process.readAllStandardOutput();
    //QString stderr = process.readAllStandardError();

    //emit signalStatus(i);
    //emit signalOutput(stdout);

    // signal process is now stopped
    running = false;
    emit signalRunning(running);

    // successful execution - return 0
    emit signalResult(0);
    return 0;
}
