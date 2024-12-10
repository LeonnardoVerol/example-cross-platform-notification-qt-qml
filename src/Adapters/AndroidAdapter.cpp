#include "AndroidAdapter.h"

AndroidAdapter::AndroidAdapter(QObject *parent)
{}

void AndroidAdapter::createSystemNotification(const QString &title, const QString &message, int notificationId)
{
    QJniObject jni_message = QJniObject::fromString(message);
    QJniObject jni_title   = QJniObject::fromString(title);

    // https://doc.qt.io/qt-5/qandroidjniobject.html
    // https://doc.qt.io/qt-6/qjniobject.html
    QJniObject::callStaticMethod<void>(
        "org/qtproject/notification/QtAndroidNotification",                     // Java Class/File Path
        "notify",                                                               // Method Name
        "(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)V",    // Parameters/Return Signature Types: "(string, string, int): void"
        QNativeInterface::QAndroidApplication::context(),
        jni_title.object<jstring>(),                                            // "title" Parameter
        jni_message.object<jstring>(),                                          // "message" Parameter
        static_cast<jint>(id));                                                 // "id" Parameter
    /*
     * The signature structure is "(A...)R", where A is the type of
     * the argument(s) and R is the return type. Array types in
     * the signature must have the [ suffix and the fully-qualified
     * type names must have the L prefix and ; suffix.
     *
     *
     * Object Types:
     *  jobject             = Ljava/lang/Object;
     *  jclass              = Ljava/lang/Class;
     *  jstring             = Ljava/lang/String;
     *  jthrowable          = Ljava/lang/Throwable;
     *  jobjectArray        = [Ljava/lang/Object;
     *  jarray              = [<type>
     *   jbooleanArray      = [Z
     *   jbyteArray         = [B
     *   jcharArray         = [C
     *   jshortArray        = [S
     *   jintArray          = [I
     *   jlongArray         = [J
     *   jfloatArray        = [F
     *   jdoubleArray       = [D
     *
     *
     * Primitive Types:
     *  jboolean            = Z
     *  jbyte               = B
     *  jchar               = C
     *  jshort              = S
     *  jint                = I
     *  jlong               = J
     *  jfloat              = F
     *  jdouble             = D
     *
     *
     * Other:
     *  void                = V
     *  Custom type         = L<fully-qualified-name>;
     *  Android Context     = Landroid/content/Context      [QtAndroid::androidContext().object()]
     *
    */
}
