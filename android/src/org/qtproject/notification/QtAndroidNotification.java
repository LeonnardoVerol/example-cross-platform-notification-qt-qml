package org.qtproject.notification;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.NotificationChannel;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.BitmapFactory;
import android.app.NotificationChannel;

import android.content.Context;
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Build;

import org.qtproject.R;

public class QtAndroidNotification
{
    private static String channelId = "channelId";
    private static String channelName = "Cross Platform Notification";

    public static void notify(Context context, String title, String messageBody, int id)
    {
        try
        {
            NotificationManager m_notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
            Notification.Builder m_builder;

            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O)
            {
                int importance = NotificationManager.IMPORTANCE_DEFAULT;
                NotificationChannel notificationChannel;
                notificationChannel = new NotificationChannel(channelId, channelName, importance);

                notificationChannel.enableLights(true);
                notificationChannel.enableVibration(true);
                notificationChannel.setLightColor(Color.GREEN);
                notificationChannel.setVibrationPattern(new long[]{500,500,500,500,500});
                notificationChannel.setLockscreenVisibility(Notification.VISIBILITY_PUBLIC);

                m_notificationManager.createNotificationChannel(notificationChannel);
                m_builder = new Notification.Builder(context, notificationChannel.getId());
            }
            else
            {
                m_builder = new Notification.Builder(context);
            }

            // Good Explanation:
            // https://developer.android.com/develop/ui/views/notifications/build-notification
            // https://developer.android.com/develop/ui/views/notifications/expanded
            //
            // Updated API:
            // https://developer.android.com/reference/android/app/Notification
            // https://developer.android.com/reference/android/app/Notification.Builder
            Bitmap icon = BitmapFactory.decodeResource(context.getResources(), R.drawable.icon);
            m_builder.setSmallIcon(R.drawable.icon);
            m_builder.setLargeIcon(icon);
            m_builder.setContentTitle(title);
            m_builder.setContentText(messageBody);
            m_builder.setStyle(new Notification.BigTextStyle().bigText(messageBody)); // Required to show the "full message"
            m_builder.setDefaults(Notification.DEFAULT_SOUND);
            m_builder.setColor(Color.GREEN);
            m_builder.setAutoCancel(true);

            m_notificationManager.notify(0, m_builder.build());
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
