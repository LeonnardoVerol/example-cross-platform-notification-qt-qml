#ifndef APPLICATIONMANAGER_H
#define APPLICATIONMANAGER_H

#include <QObject>

#include "src/Adapters/OSAdapter.h"

class ApplicationManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString iconSource READ iconSource WRITE setIconSource NOTIFY iconSourceChanged FINAL)

    Q_PROPERTY(int notificationId READ notificationId WRITE setNotificationId NOTIFY notificationIdChanged FINAL)
    Q_PROPERTY(int notificationType READ notificationType WRITE setNotificationType NOTIFY notificationTypeChanged FINAL)
    Q_PROPERTY(int notificationDuration READ notificationDuration WRITE setNotificationDuration NOTIFY notificationDurationChanged FINAL)

    Q_PROPERTY(QString notificationTitle READ notificationTitle WRITE setNotificationTitle NOTIFY notificationTitleChanged FINAL)
    Q_PROPERTY(QString notificationBody READ notificationBody WRITE setNotificationBody NOTIFY notificationBodyChanged FINAL)

public:
    explicit ApplicationManager(QObject *parent = nullptr);

    Q_INVOKABLE void triggerNotification();

    QString iconSource() const;
    void setIconSource(const QString &newIconSource);

    int notificationId() const;
    void setNotificationId(int newNotificationId);

    int notificationType() const;
    void setNotificationType(int newNotificationType);

    int notificationDuration() const;
    void setNotificationDuration(int newNotificationDuration);

    QString notificationTitle() const;
    void setNotificationTitle(const QString &newNotificationTitle);

    QString notificationBody() const;
    void setNotificationBody(const QString &newNotificationBody);

signals:
    void iconSourceChanged();
    void notificationIdChanged();
    void notificationTypeChanged();
    void notificationDurationChanged();
    void notificationTitleChanged();
    void notificationBodyChanged();
    void createToastNotification(const QString &title, const QString &body, const int type, const int duration);
    void showNormal();
    void quit();

private slots:
    OSAdapter* buildAdapter();
    void iconActivated(int reason); // QSystemTrayIcon::ActivationReason
    void notificationClicked();
    void refreshIcon();

private:
    QString m_iconSource;
    int m_notificationId;
    int m_notificationType;
    int m_notificationDuration;
    QString m_notificationTitle;
    QString m_notificationBody;
    OSAdapter *osAdapter;
};

#endif // APPLICATIONMANAGER_H
