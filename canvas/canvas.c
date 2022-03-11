#include "canvas.h"
#include <stdint.h>

Color color_rgb(uint8_t r, uint8_t g, uint8_t b) {
    Color c = { r, g, b };
    return c;
}

BMPImage bmp_new(uint32_t w, uint32_t h) {
    BMPImage bmp = { w, h };
    bmp.pixel_data = calloc(sizeof(Color), w * h);

    return bmp;
}

void bmp_free(BMPImage *image) {
    free(image->pixel_data);

    image->w = 0;
    image->h = 0;
    image->pixel_data = NULL;
}

Canvas canvas_new(uint32_t w, uint32_t h) {
    BMPImage bmp = bmp_new(w, h);
    Canvas c = { w, h, bmp };

    return c;
}

void canvas_free(Canvas *canvas) {
    canvas->w = 0;
    canvas->h = 0;
    bmp_free(&canvas->image);
}