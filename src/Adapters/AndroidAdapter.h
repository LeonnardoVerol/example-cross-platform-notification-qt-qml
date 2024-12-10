#ifndef ANDROIDADAPTER_H
#define ANDROIDADAPTER_H

#include <QObject>
#include "src/Adapters/OSAdapter.h"

class AndroidAdapter : public OSAdapter
{
    Q_OBJECT

public:
    explicit AndroidAdapter(QObject *parent = nullptr);

    virtual void createSystemNotification(const QString& title, const QString& message, int notificationId = 1) override;
};

#endif // ANDROIDADAPTER_H
