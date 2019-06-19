#include "imagepix.h"

ImagePix::ImagePix()
{
    qImage = new QImage(975,710,QImage::Format_ARGB32);
    qImage->fill(QColor(0, 0, 0, 0));
}

void ImagePix::setPixel(unsigned int x, unsigned int y, int rgba) {
    QRgb* px = (QRgb* )(qImage->scanLine(y) + x * 4);
    *px = rgba;
}
void ImagePix::setPixel(unsigned int x, unsigned int y, QString color) {
    QRgb* px = (QRgb* )(qImage->scanLine(y) + x * 4);
    *px = QColor(color).rgba();
}

void ImagePix::setPixel(unsigned int x, unsigned int y, unsigned int r, unsigned int g, unsigned int b) {
    QRgb* px = (QRgb* )(qImage->scanLine(y) + x * 4);
    *px = QColor(r, g, b).rgba();
}

void ImagePix::clear() {
    qImage->fill(QColor(0, 0, 0, 0));
}
