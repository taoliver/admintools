#ifndef ADMINSCRIPT_H
#define ADMINSCRIPT_H

#include <QObject>

class AdminScript : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString command READ command WRITE setCommand NOTIFY commandChanged)
    Q_PROPERTY(QString output READ output WRITE setOutput NOTIFY outputChanged)
    Q_PROPERTY(int status READ status WRITE setStatus NOTIFY statusChanged)
public:
    explicit AdminScript(QObject *parent = 0);

    QString command() const;
    void setCommand(const QString &command);
    QString output() const;
    void setOutput(const QString &output);
    int status() const;
    void setStatus(const int &status);

    Q_INVOKABLE void runCommand();


signals:
    void commandChanged();
    void outputChanged();
    void statusChanged();

public slots:

private:
    QString m_command;
    QString m_output;
    int m_status;

    int runAdminScript(const QString &command);

};

#endif // ADMINSCRIPT_H
