#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <appmanager.h>


int main(int argc, char *argv[])
{
//    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    AppManager *appmanager = new AppManager(&app);
    engine.rootContext()->setContextProperty("appmanager", appmanager);

    const QUrl url(u"qrc:/cogen/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
