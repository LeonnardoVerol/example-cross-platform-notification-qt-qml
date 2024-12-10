#ifndef IOSADAPTER_H
#define IOSADAPTER_H

#include <QObject>
#include "src/Adapters/OSAdapter.h"

class IOSAdapter : public OSAdapter
{
    Q_OBJECT

public:
    explicit IOSAdapter(QObject *parent = nullptr);
    virtual void createSystemNotification(const QString& title, const QString& message, int notificationId = 1) override;

private:
    void *m_Delegate;
};

#endif // IOSADAPTER_H
