#include "ApplicationManager.h"

#include <QApplication>
#include <QSystemTrayIcon>
#include <QStyle>

ApplicationManager::ApplicationManager(QObject *parent)
    : QObject{parent}
{
    QApplication::setApplicationName("Cross Platform Notification Example in QT/QML");

    this->setIconSource(":/images/heart.png");
    this->setNotificationId(1);
    this->setNotificationType(QSystemTrayIcon::NoIcon);
    this->setNotificationDuration(5);
    this->setNotificationTitle(tr("Notification Title"));
    this->setNotificationBody(tr("Notification Body"));

#if defined(IS_DESKTOP)
    this->desktopAdapter = std::make_shared<DesktopAdapter>();
#endif

    this->refreshIcon();

    QObject::connect(this, &ApplicationManager::iconSourceChanged, this, &ApplicationManager::refreshIcon );

    QObject::connect(this->desktopAdapter.get(), &DesktopAdapter::iconActivated, this, &ApplicationManager::iconActivated );
    QObject::connect(this->desktopAdapter.get(), &DesktopAdapter::showNormal, this, &ApplicationManager::showNormal );
    QObject::connect(this->desktopAdapter.get(), &DesktopAdapter::quit, this, &ApplicationManager::quit );
    QObject::connect(this->desktopAdapter.get(), &DesktopAdapter::notificationClicked, this, &ApplicationManager::notificationClicked );
}

void ApplicationManager::triggerNotification()
{
#if defined(IS_DESKTOP)

    int typeIcon = this->notificationType();
    QIcon icon;

    if (typeIcon == -1) // custom icon
    {
        icon = QIcon(QString(this->iconSource()).replace("qrc:/", ":/"));
    }
    else
    {
        switch (typeIcon)
        {
        default: // Intentional Fallthrough
        case QSystemTrayIcon::MessageIcon::NoIcon:
            icon = QIcon();
            break;
        case QSystemTrayIcon::MessageIcon::Information:
            icon = QApplication::style()->standardIcon(QStyle::SP_MessageBoxInformation);
            break;
        case QSystemTrayIcon::MessageIcon::Warning:
            icon = QApplication::style()->standardIcon(QStyle::SP_MessageBoxWarning);
            break;
        case QSystemTrayIcon::MessageIcon::Critical:
            icon = QApplication::style()->standardIcon(QStyle::SP_MessageBoxCritical);
            break;
        }
    }

    this->desktopAdapter->createSystemNotification(this->notificationTitle(), this->notificationBody(), icon,
                                                   this->notificationDuration());
#endif

    emit createToastNotification(this->notificationTitle(), this->notificationBody(), this->notificationType(), this->notificationDuration());
}

QString ApplicationManager::iconSource() const
{
    return m_iconSource;
}

void ApplicationManager::setIconSource(const QString &newIconSource)
{
    if (m_iconSource == newIconSource)
        return;

    m_iconSource = newIconSource;
    emit iconSourceChanged();
}

int ApplicationManager::notificationId() const
{
    return m_notificationId;
}

void ApplicationManager::setNotificationId(int newNotificationId)
{
    if (m_notificationId == newNotificationId)
        return;

    m_notificationId = newNotificationId;
    emit notificationIdChanged();
}

int ApplicationManager::notificationType() const
{
    return m_notificationType;
}

void ApplicationManager::setNotificationType(int newNotificationType)
{
    if (m_notificationType == newNotificationType)
        return;

    m_notificationType = newNotificationType;
    emit notificationTypeChanged();
}

int ApplicationManager::notificationDuration() const
{
    return m_notificationDuration;
}

void ApplicationManager::setNotificationDuration(int newNotificationDuration)
{
    if (m_notificationDuration == newNotificationDuration)
        return;

    m_notificationDuration = newNotificationDuration;
    emit notificationDurationChanged();
}

QString ApplicationManager::notificationTitle() const
{
    return m_notificationTitle;
}

void ApplicationManager::setNotificationTitle(const QString &newNotificationTitle)
{
    if (m_notificationTitle == newNotificationTitle)
        return;

    m_notificationTitle = newNotificationTitle;
    emit notificationTitleChanged();
}

QString ApplicationManager::notificationBody() const
{
    return m_notificationBody;
}

void ApplicationManager::setNotificationBody(const QString &newNotificationBody)
{
    if (m_notificationBody == newNotificationBody)
        return;

    m_notificationBody = newNotificationBody;
    emit notificationBodyChanged();
}

void ApplicationManager::iconActivated(int reason)
{
    switch (reason)
    {
    case QSystemTrayIcon::Trigger:
        qDebug() << "iconActivated - Trigger";
        break;
    case QSystemTrayIcon::DoubleClick:
        qDebug() << "iconActivated - DoubleClick";
        break;
    case QSystemTrayIcon::MiddleClick:
        qDebug() << "iconActivated - MiddleClick";
        break;
    case QSystemTrayIcon::Context:
        qDebug() << "iconActivated - Context";
        break;
    default:
        qDebug() << "iconActivated - Unknown";
        break;
    }
}

void ApplicationManager::notificationClicked()
{
    qDebug() << "Notification Clicked";
}

void ApplicationManager::refreshIcon()
{
    QIcon icon(QString(this->iconSource()).replace("qrc:/", ":/"));

    QApplication::setWindowIcon(icon);

#if defined(IS_DESKTOP)
    this->desktopAdapter->setIcon(icon);
#endif

}