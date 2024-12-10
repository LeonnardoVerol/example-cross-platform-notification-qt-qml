#ifndef DESKTOPADAPTER_H
#define DESKTOPADAPTER_H

#include <QObject>
#include <QSystemTrayIcon>
#include "src/Adapters/OSAdapter.h"

class DesktopAdapter : public OSAdapter
{
    Q_OBJECT

public:
    explicit DesktopAdapter(QObject *parent = nullptr);

    void setIcon(const QIcon &icon);

    virtual void createSystemNotification(const QString &title, const QString &message, int notificationId = 1) override;
    void createSystemNotification(const QString &title, const QString &message, const QIcon &icon, int secs = 5);

signals:
    void iconActivated(int reason); // QSystemTrayIcon::ActivationReason
    void showNormal();
    void quit();
    void notificationClicked();

private:
    QSystemTrayIcon *trayIcon;
};

#endif // DESKTOPADAPTER_H
