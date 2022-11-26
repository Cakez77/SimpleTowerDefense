#pragma once
#include "assets.h"
#include "my_math.h"
#include "shader_header.h"

//#############################################################
//                  Structures
//#############################################################
struct DrawData
{
  SpriteID spriteID = SPRITE_WHITE;
  Vec2 pos;
  Vec2 size;
  Vec2 vertexOffset = ORIGIN_CENTER;
  
  Vec4 color = COLOR_WHITE;
  RenderOptions renderOptions;
};

//#############################################################
//                  Draw Functions
//#############################################################
void draw_transform(DrawData drawData);
void draw_quad(Vec2 pos, Vec2 size, DrawData drawData = {});
void draw_sprite(SpriteID spriteID, Vec2 pos, Vec2 size, DrawData drawData = {});

void draw_line(Vec2 a, Vec2 b, Vec4 color = COLOR_WHITE);
void draw_circle(Circle c, Vec4 color = COLOR_WHITE);
void draw_box(Vec2 pos, Vec2 size, Vec4 color = COLOR_WHITE, float lineThickness = 5.0f);

//#############################################################
//                  Utility Functions
//#############################################################
bool renderer_get_vertical_sync();
void renderer_set_vertical_sync(bool vSync);
void renderer_resize();