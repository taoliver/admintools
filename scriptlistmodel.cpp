#include "scriptlistmodel.h"

#include <QTextStream>
#include <QColor>
#include <QString>
#include <QMetaProperty>
//#include "utils.h"

void extractObjectProperties(const QMetaObject *object,
                             QStringList *list,
                             bool cleanup,
                             const char *prefix)
{
    QStringList &properties = *list;
    const int count = object->propertyCount();
    for (int i = 0; i < count; ++i) {
        QString propertyName = object->property(i).name();
        if (propertyName.startsWith(prefix)) {
            properties << propertyName;
        }
    }

    if (cleanup) {
        properties.replaceInStrings(prefix, "");
    }
}

ScriptListModel::ScriptListModel(QObject *parent) :
    QAbstractListModel(parent)
{
    // Qt standard stream output
    QTextStream out(stdout);

    AdminScript script;
    //m_data << 1 << 2 << 3 << 4 << 5; // test data
    //emit countChanged(rowCount());

    out <<  "hello" << QString::number(Qt::UserRole) << endl;

    extractObjectProperties(script.metaObject(), &properties, false, "");

    for (int i = 1; i < properties.count(); ++i) {
        roles[Qt::UserRole+i] = properties[i].toUtf8();
        out << roles[Qt::UserRole+i] << "hello";
    }

    out << "goodbye";

}

QHash<int, QByteArray> ScriptListModel::roleNames() const
{
    // Qt standard stream output
    QTextStream out(stdout);
/*
    QHash<int, QByteArray> roles;
    QStringList properties;
    AdminScript script;

    out <<  "hello";

//    Utils::extractObjectProperties(script.metaObject(), &properties, false, "");
    extractObjectProperties(script.metaObject(), &properties, false, "");

    for (int i = 0; i < properties.count(); ++i) {
        roles[i] = properties[i].toUtf8();
        out << roles[i] << "hello";
    }

    out << "goodbye";


*/
    return roles;
}

QVariant ScriptListModel::data(const QModelIndex &index, int role) const
{
    // Qt standard stream output
    QTextStream out(stdout);

    if (!index.isValid() || index.row() < 0 || index.row() >= rowCount())
        return QVariant();

    //int val = m_data.at(index.row());
    AdminScript* s = m_scripts.at(index.row());
    QString val = s->command();
    //bool val = s->detached();
    //QString val = "10";

    //qDebug("role: %d".arg(role));
    out << "role: " + QString::number(role) << roles[role] << endl;

    switch (role) {
    case Qt::DisplayRole:
        return QString("commandit: %1").arg(val);
        break;
    //case Qt::DecorationRole:
    //    return QColor(val & 0x1 ? Qt::red : Qt::green);
    //    break;
    case Qt::EditRole:
        return val;
        break;
    case commandRole:
        out << "it wants command role " << endl;
        return s->command();
    case detachedRole:
        out << "it wants detached role " << endl;
        if (s->detached())
            return "True";
        else
            return "False";
    case outputRole:
        out << "it wants output role " << endl;
        return s->output();
    case statusRole:
        out << "it wants status role " << endl;
        return QString("%1").arg(s->status());
    case runningRole:
        out << "it wants running role " << endl;
        if (s->running())
            return "True";
        else
            return "False";
    case startTimeRole:
        out << "it wants startTime role " << endl;
        return s->startTime();
    case elapsedTimeRole:
        out << "it wants elapsedTime role " << endl;
        return s->elapsedTime();
    default:
        return QVariant();
    }
}
