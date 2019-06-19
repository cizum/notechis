TEMPLATE = app

QT += qml quick
CONFIG += c++11

# Default rules for deployment.
include(deployment.pri)

SOURCES += main.cpp \
    src/imagepix.cpp \
    src/imageprovider.cpp

HEADERS += \
    src/imagepix.h \
    src/imageprovider.h

RESOURCES += assets.qrc

