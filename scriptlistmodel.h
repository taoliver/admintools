#ifndef SCRIPTLISTMODEL_H
#define SCRIPTLISTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QString>

//#include "scriptlist.h"
#include "adminscript.h"

// nasty, hacky global data for now....
//extern QList<int> m_data;
extern QList<AdminScript *> m_scripts;
//extern QList<AdminScript> m_scripts;

class ScriptListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)

public:
    explicit ScriptListModel(QObject *parent = 0);

    int rowCount(const QModelIndex & = QModelIndex()) const override { return m_scripts.count(); }
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const;

//    Q_INVOKABLE int get(int index) const { return m_scripts.at(index); }
    Q_INVOKABLE AdminScript* get(int index) const { return m_scripts.at(index); }
    //Q_INVOKABLE AdminScript get(int index) const { return m_scripts.at(index); }

signals:
    void countChanged(int c);

public slots:

private:

    enum Roles {
        commandRole = Qt::UserRole+1,
        detachedRole,
        outputRole,
        statusRole,
        runningRole,
        startTimeRole,
        elapsedTimeRole
    };

    //  QList<int> m_data;
//    extern QList<int> m_data;
    QHash<int, QByteArray> roles;
    QStringList properties;
};

#endif // SCRIPTLISTMODEL_H
