#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

#include "src/Managers/ApplicationManager.h"

void registerTypes()
{
    static ApplicationManager *applicationManager = new ApplicationManager();

    qmlRegisterSingletonType<ApplicationManager>("Manager.Application", 1, 0, "ApplicationManager", [&](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        return applicationManager;
    });
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QQuickStyle::setStyle("Material");
    registerTypes();

    const QUrl url(QStringLiteral("qrc:/src/ui/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
