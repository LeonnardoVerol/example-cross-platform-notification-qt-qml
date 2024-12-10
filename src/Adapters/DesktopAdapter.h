#ifndef DESKTOPADAPTER_H
#define DESKTOPADAPTER_H

#include <QObject>
#include <QSystemTrayIcon>

class DesktopAdapter : public QObject
{
    Q_OBJECT

public:
    explicit DesktopAdapter(QObject *parent = nullptr);

    void setIcon(const QIcon &icon);

    void createSystemNotification(const QString &title, const QString &message, int notificationId = 1);
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
