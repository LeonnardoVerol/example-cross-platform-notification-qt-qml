#import <UserNotifications/UserNotifications.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include "IOSAdapter.h"

@interface NotificationDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>
{
    IOSAdapter *g_IosNotifier;
}
@end

@implementation NotificationDelegate

- (id) initWithObject:(IOSAdapter *)localNotification
{
    self = [super init];
    if (self) {
        g_IosNotifier = localNotification;
    }
    return self;
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center
        willPresentNotification:(UNNotification *)notification
            withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    Q_UNUSED(center)
    long var = [[notification.request.content.userInfo objectForKey:@"ID"] longValue];

    completionHandler(UNNotificationPresentationOptionAlert);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center
         didReceiveNotificationResponse:(UNNotificationResponse *)response
            withCompletionHandler:(void(^)())completionHandler
{
    Q_UNUSED(center)
    Q_UNUSED(response)
    completionHandler();
}
@end

IOSAdapter::IOSAdapter()
{
    m_Delegate = [[NotificationDelegate alloc] initWithObject:this];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error)
    {
        Q_UNUSED(granted);
        if (!error)
        {
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
    }];
}

void IOSAdapter::createSystemNotification(const QString &title, const QString &message, int notificationId)
{
    // create content
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title.toNSString();
    content.body = message.toNSString();
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);

    // create trigger time
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];

    // unique identifier
    QString identifier = QString::number(notificationId);
    NSString* identifierNSString = identifier.toNSString();

    // create notification request
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifierNSString
            content:content trigger:trigger];

    // add request
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = id(m_Delegate);

    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
    {
        if (error) {
            NSLog(@"Local Notification failed");
        }
    }];
}
