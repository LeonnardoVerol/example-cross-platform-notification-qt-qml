#ifndef OSADAPTER_H
#define OSADAPTER_H

#include <QObject>

class OSAdapter : public QObject
{
    Q_OBJECT

public:
    virtual void createSystemNotification(const QString& title, const QString& message, int notificationId = 1) = 0;
};

#endif // OSADAPTER_H
