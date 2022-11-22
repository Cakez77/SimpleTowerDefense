
// Output
layout (location = 0) out vec4 color;
layout (location = 1) out vec2 textureCoordsOut;

// Input Uniforms
uniform vec2 screenSize;

// Input Buffers
layout(std430, binding = 0) buffer TransfromSBO
{
    Transform transforms[];
};

layout(std430, binding = 1) buffer MaterialSBO
{
    Material materials[];
};

void main()
{
  // From -0.5 to 0.5 -> 1.0 -> size is 1 unit length, Counter Clockwise
  float v_size = 1.0;
  vec2 vertices[6] = 
  {
    vec2(-v_size,  v_size), // Top Left
    vec2(-v_size, -v_size), // Bottom Left
    vec2( v_size,  v_size), // Top Right
    vec2( v_size,  v_size), // Top Right
    vec2(-v_size, -v_size), // Bottom Left
    vec2( v_size, -v_size)  // Bottom Right
  };

  Transform t = transforms[gl_InstanceID];

  // Inverts the Y- Coordinate, so that y = 0 is on the top
  t.pos.y = -t.pos.y + screenSize.y;
  vec2 pos = t.pos * (2.0 / screenSize) - 1.0;
  vec2 size = t.size / screenSize;

  color = materials[t.materialIdx].color;

  // Texture Coords, with flipping
  float left;
  float right;
  float top;
  float bottom;
  if(bool(t.renderOptions & RENDER_OPTION_FLIP_X))
  {
    left = t.atlasOffset.x + t.spriteSize.x;
    right = t.atlasOffset.x;
  }
  else
  {
    left = t.atlasOffset.x;
    right = t.atlasOffset.x + t.spriteSize.x;
  }
  if(bool(t.renderOptions & RENDER_OPTION_FLIP_Y))
  {
    top = t.atlasOffset.y + t.spriteSize.y;
    bottom = t.atlasOffset.y;
  }
  else
  {
    top = t.atlasOffset.y;
    bottom = t.atlasOffset.y + t.spriteSize.y;
  }
  ivec2 textureCoords[6] = 
  {
    ivec2(left, top),                                 
    ivec2(left, bottom),
    ivec2(right, top),
    ivec2(right, top),
    ivec2(left, bottom),
    ivec2(right, bottom)
  };
  textureCoordsOut = textureCoords[gl_VertexID];
  
  gl_Position = vec4(vertices[gl_VertexID] * size + pos, 0.0, 1.0);
}