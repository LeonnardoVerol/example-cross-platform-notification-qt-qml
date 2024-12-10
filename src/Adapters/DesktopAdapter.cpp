#include "DesktopAdapter.h"

#include <qDebug>
#include <QMenu>
#include <QAction>
#include <QApplication>

DesktopAdapter::DesktopAdapter(QObject *parent)
{
    QMenu *trayIconMenu = new QMenu();

    QAction * openAction = new QAction(tr("Open"), this);
    trayIconMenu->addAction(openAction);
    QObject::connect(openAction, &QAction::triggered, this, &DesktopAdapter::showNormal);

    QAction * quitAction = new QAction(tr("Quit"), this);
    trayIconMenu->addAction(quitAction);
    QObject::connect(quitAction, &QAction::triggered, this, &DesktopAdapter::quit);

    this->trayIcon = new QSystemTrayIcon(this);
    this->trayIcon->setToolTip(QApplication::applicationName());
    this->trayIcon->setContextMenu(trayIconMenu);

    QObject::connect(trayIcon, &QSystemTrayIcon::activated, this, &DesktopAdapter::iconActivated);
    QObject::connect(trayIcon, &QSystemTrayIcon::messageClicked, this, &DesktopAdapter::notificationClicked);
}

void DesktopAdapter::setIcon(const QIcon &icon)
{
    this->trayIcon->setIcon(icon);
    this->trayIcon->show();
}

void DesktopAdapter::createSystemNotification(const QString &title, const QString &message, int notificationId)
{
    Q_UNUSED(notificationId);
    this->createSystemNotification(title, message, QSystemTrayIcon::MessageIcon::Information);
}

void DesktopAdapter::createSystemNotification(const QString &title, const QString &message, const QIcon &icon, int secs)
{
    this->trayIcon->showMessage(title, message, icon, secs * 1000);
}
