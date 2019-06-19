#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/imagepix.h"
#include "src/imageprovider.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ImageProvider* imageProvider = new ImageProvider();
    ImagePix* impix = new ImagePix();

    imageProvider->qImage = impix->qImage;

    engine.addImageProvider(QLatin1String("provider"), imageProvider);
    engine.rootContext()->setContextProperty("impix", impix);

    engine.load(QStringLiteral("qrc:/main.qml"));

    return app.exec();
}

