/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.sfml.gfuncs;

private
{
    import derelict.util.compat;
    import derelict.sfml.config;
    import derelict.sfml.wtypes;
    import derelict.sfml.gtypes;
}

version(D_Version2)
{
    mixin("alias const(sfUint8*) SFU8PTR;");
    mixin("alias const(sfView*) SFVPTR;");
}
else
{
    alias sfUint8* SFU8PTR;
    alias sfView* SFVPTR;
}

extern(C)
{
    mixin(gsharedString!() ~
    "
    // Color.h
    sfColor function(sfUint8, sfUint8, sfUint8, sfUint8) sfColor_FromRGBA;
    sfColor function(sfColor, sfColor) sfColor_Add;
    sfColor function(sfColor, sfColor) sfColor_Modulate;

    // Font.h
    sfFont* function() sfFont_Create;
    sfFont* function(CCPTR, uint, in sfUint32*) sfFont_CreateFromFile;
    sfFont* function(in ubyte*, size_t, uint, in sfUint32*) sfFont_CreateFromMemory;
    void function(sfFont*) sfFont_Destroy;
    uint function(sfFont*) sfFont_GetCharacterSize;
    sfFont* function() sfFont_GetDefaultFont;

    // Image.h
    sfImage* function() sfImage_Create;
    sfImage* function(uint, uint, sfColor) sfImage_CreateFromColor;
    sfImage* function(uint, uint, in sfUint8*) sfImage_CreateFromPixels;
    sfImage* function(CCPTR) sfImage_CreateFromFile;
    sfImage* function(in ubyte*, size_t) sfImage_CreateFromMemory;
    void function(sfImage*) sfImage_Destroy;
    sfBool function(sfImage*, CCPTR) sfImage_SaveToFile;
    void function(sfImage*, sfColor, sfUint8) sfImage_CreateMaskFromColor;
    void function(sfImage*, sfImage*, uint, uint, sfIntRect) sfImage_Copy;
    sfBool function(sfImage*, sfRenderWindow*, sfIntRect) sfImage_CopyScreen;
    void function(sfImage*, uint, uint, sfColor) sfImage_SetPixel;
    sfColor function(sfImage*, uint, uint) sfImage_GetPixel;
    SFU8PTR function(sfImage*) sfImage_GetPixelsPtr;
    void function(sfImage*) sfImage_Bind;
    void function(sfImage*, sfBool) sfImage_SetSmooth;
    uint function(sfImage*) sfImage_GetWidth;
    uint function(sfImage*) sfImage_GetHeight;
    sfBool function(sfImage*) sfImage_IsSmooth;

    // PostFX.h
    sfPostFX* function(CCPTR) sfPostFX_CreateFromFile;
    sfPostFX* function(ubyte*) sfPostFX_CreateFromMemory;
    void function(sfPostFX*) sfPostFX_Destroy;
    void function(sfPostFX*, CCPTR, float) sfPostFX_SetParameter1;
    void function(sfPostFX*, CCPTR, float, float) sfPostFX_SetParameter2;
    void function(sfPostFX*, CCPTR, float, float, float) sfPostFX_SetParameter3;
    void function(sfPostFX*, CCPTR, float, float, float, float) sfPostFX_SetParameter4;
    void function(sfPostFX*, CCPTR, sfImage*) sfPostFX_SetTexture;
    sfBool function() sfPostFX_CanUsePostFX;

    // Rect.h
    void function(sfFloatRect*, float, float) sfFloatRect_Offset;
    void function(sfIntRect*, int, int) sfIntRect_Offset;
    sfBool function(sfFloatRect*, float, float) sfFloatRect_Contains;
    sfBool function(sfIntRect*, int, int) sfIntRect_Contains;
    sfBool function(sfFloatRect*, sfFloatRect*, sfFloatRect*) sfFloatRect_Intersects;
    sfBool function(sfIntRect*, sfIntRect*, sfIntRect*) sfIntRect_Intersects;

    // RenderWindow
    sfRenderWindow* function(sfVideoMode, CCPTR, uint, sfWindowSettings) sfRenderWindow_Create;
    sfRenderWindow* function(sfWindowHandle, sfWindowSettings) sfRenderWindow_CreateFromHandle;
    void function(sfRenderWindow*) sfRenderWindow_Destroy;
    void function(sfRenderWindow*) sfRenderWindow_Close;
    sfBool function(sfRenderWindow*) sfRenderWindow_IsOpened;
    uint function(sfRenderWindow*) sfRenderWindow_GetWidth;
    uint function(sfRenderWindow*) sfRenderWindow_GetHeight;
    sfWindowSettings function(sfRenderWindow*) sfRenderWindow_GetSettings;
    sfBool function(sfRenderWindow*, sfEvent*) sfRenderWindow_GetEvent;
    void function(sfRenderWindow*, sfBool) sfRenderWindow_UseVerticalSync;
    void function(sfRenderWindow*, sfBool) sfRenderWindow_ShowMouseCursor;
    void function(sfRenderWindow*, uint, uint) sfRenderWindow_SetCursorPosition;
    void function(sfRenderWindow*, int, int) sfRenderWindow_SetPosition;
    void function(sfRenderWindow*, uint, uint) sfRenderWindow_SetSize;
    void function(sfRenderWindow*, sfBool) sfRenderWindow_Show;
    void function(sfRenderWindow*, sfBool) sfRenderWindow_EnableKeyRepeat;
    void function(sfRenderWindow*, uint, uint, sfUint8*) sfRenderWindow_SetIcon;
    sfBool function(sfRenderWindow*, sfBool) sfRenderWindow_SetActive;
    void function(sfRenderWindow*) sfRenderWindow_Display;
    sfInput* function(sfRenderWindow*) sfRenderWindow_GetInput;
    void function(sfRenderWindow*, uint) sfRenderWindow_SetFramerateLimit;
    float function(sfRenderWindow*) sfRenderWindow_GetFrameTime;
    void function(sfRenderWindow*, float) sfRenderWindow_SetJoystickThreshold;
    void function(sfRenderWindow*, sfPostFX*) sfRenderWindow_DrawPostFX;
    void function(sfRenderWindow*, sfSprite*) sfRenderWindow_DrawSprite;
    void function(sfRenderWindow*, sfShape*) sfRenderWindow_DrawShape;
    void function(sfRenderWindow*, sfString*) sfRenderWindow_DrawString;
    sfImage* function(sfRenderWindow*) sfRenderWindow_Capture;
    void function(sfRenderWindow*, sfColor) sfRenderWindow_Clear;
    void function(sfRenderWindow*, sfView*) sfRenderWindow_SetView;
    SFVPTR function(sfRenderWindow*) sfRenderWindow_GetView;
    sfView* function(sfRenderWindow*) sfRenderWindow_GetDefaultView;
    void function(sfRenderWindow*, uint, uint, float*, float*, float*, sfView*) sfRenderWindow_ConvertCoords;
    void function(sfRenderWindow*, sfBool) sfRenderWindow_PreserveOpenGLStates;

    // Shape.h
    sfShape* function() sfShape_Create;
    sfShape* function(float, float, float, float, float, sfColor, float, sfColor) sfShape_CreateLine;
    sfShape* function(float, float, float, float, sfColor, float, sfColor) sfShape_CreateRectangle;
    sfShape* function(float, float, float, sfColor, float, sfColor) sfShape_CreateCircle;
    void function(sfShape*) sfShape_Destroy;
    void function(sfShape*, float) sfShape_SetX;
    void function(sfShape*, float) sfShape_SetY;
    void function(sfShape*, float, float) sfShape_SetPosition;
    void function(sfShape*, float) sfShape_SetScaleX;
    void function(sfShape*, float) sfShape_SetScaleY;
    void function(sfShape*, float, float) sfShape_SetScale;
    void function(sfShape*, float) sfShape_SetRotation;
    void function(sfShape*, float, float) sfShape_SetCenter;
    void function(sfShape*, sfColor) sfShape_SetColor;
    void function(sfShape*, sfBlendMode) sfShape_SetBlendMode;
    float function(sfShape*) sfShape_GetX;
    float function(sfShape*) sfShape_GetY;
    float function(sfShape*) sfShape_GetScaleX;
    float function(sfShape*) sfShape_GetScaleY;
    float function(sfShape*) sfShape_GetRotation;
    float function(sfShape*) sfShape_GetCenterX;
    float function(sfShape*) sfShape_GetCenterY;
    sfColor function(sfShape*) sfShape_GetColor;
    sfBlendMode function(sfShape*) sfShape_GetBlendMode;
    void function(sfShape*, float, float) sfShape_Move;
    void function(sfShape*, float, float) sfShape_Scale;
    void function(sfShape*, float) sfShape_Rotate;
    void function(sfShape*, float, float, float*, float*) sfShape_TransformToLocal;
    void function(sfShape*, float, float, float*, float*) sfShape_TransformToGlobal;
    void function(sfShape*, float, float, sfColor, sfColor) sfShape_AddPoint;
    void function(sfShape*, sfBool) sfShape_EnableFill;
    void function(sfShape*, sfBool) sfShape_EnableOutline;
    void function(sfShape*, float) sfShape_SetOutlineWidth;
    float function(sfShape*) sfShape_GetOutlineWidth;
    uint function(sfShape*) sfShape_GetNbPoints;
    void function(sfShape*, uint, float*, float*) sfShape_GetPointPosition;
    sfColor function(sfShape*, uint) sfShape_GetPointColor;
    sfColor function(sfShape*, uint) sfShape_GetPointOutlineColor;
    void function(sfShape*, uint, float, float) sfShape_SetPointPosition;
    void function(sfShape*, uint, sfColor) sfShape_SetPointColor;
    void function(sfShape*, uint, sfColor) sfShape_SetPointOutlineColor;

    // Sprite.h
    sfSprite* function() sfSprite_Create;
    void function(sfSprite*) sfSprite_Destroy;
    void function(sfSprite*, float) sfSprite_SetX;
    void function(sfSprite*, float) sfSprite_SetY;
    void function(sfSprite*, float, float) sfSprite_SetPosition;
    void function(sfSprite*, float) sfSprite_SetScaleX;
    void function(sfSprite*, float) sfSprite_SetScaleY;
    void function(sfSprite*, float, float) sfSprite_SetScale;
    void function(sfSprite*, float) sfSprite_SetRotation;
    void function(sfSprite*, float, float) sfSprite_SetCenter;
    void function(sfSprite*, sfColor) sfSprite_SetColor;
    void function(sfSprite*, sfBlendMode) sfSprite_SetBlendMode;
    float function(sfSprite*) sfSprite_GetX;
    float function(sfSprite*) sfSprite_GetY;
    float function(sfSprite*) sfSprite_GetScaleX;
    float function(sfSprite*) sfSprite_GetScaleY;
    float function(sfSprite*) sfSprite_GetRotation;
    float function(sfSprite*) sfSprite_GetCenterX;
    float function(sfSprite*) sfSprite_GetCenterY;
    sfColor function(sfSprite*) sfSprite_GetColor;
    sfBlendMode function(sfSprite*) sfSprite_GetBlendMode;
    void function(sfSprite*, float, float) sfSprite_Move;
    void function(sfSprite*, float, float) sfSprite_Scale;
    void function(sfSprite*, float) sfSprite_Rotate;
    void function(sfSprite*, float, float, float*, float*) sfSprite_TransformToLocal;
    void function(sfSprite*, float, float, float*, float*) sfSprite_TransformToGlobal;
    void function(sfSprite*, sfImage*) sfSprite_SetImage;
    void function(sfSprite*, sfIntRect) sfSprite_SetSubRect;
    void function(sfSprite*, float, float) sfSprite_Resize;
    void function(sfSprite*, sfBool) sfSprite_FlipX;
    void function(sfSprite*, sfBool) sfSprite_FlipY;
    sfImage* function(sfSprite*) sfSprite_GetImage;
    sfIntRect function(sfSprite*) sfSprite_GetSubRect;
    float function(sfSprite*) sfSprite_GetWidth;
    float function(sfSprite*) sfSprite_GetHeight;
    sfColor function(sfSprite*, uint, uint) sfSprite_GetPixel;

    // String.h
    sfString* function() sfString_Create;
    void function(sfString*) sfString_Destroy;
    void function(sfString*, float) sfString_SetX;
    void function(sfString*, float) sfString_SetY;
    void function(sfString*, float, float) sfString_SetPosition;
    void function(sfString*, float) sfString_SetScaleX;
    void function(sfString*, float) sfString_SetScaleY;
    void function(sfString*, float, float) sfString_SetScale;
    void function(sfString*, float) sfString_SetRotation;
    void function(sfString*, float, float) sfString_SetCenter;
    void function(sfString*, sfColor) sfString_SetColor;
    void function(sfString*, sfBlendMode) sfString_SetBlendMode;
    float function(sfString*) sfString_GetX;
    float function(sfString*) sfString_GetY;
    float function(sfString*) sfString_GetScaleX;
    float function(sfString*) sfString_GetScaleY;
    float function(sfString*) sfString_GetRotation;
    float function(sfString*) sfString_GetCenterX;
    float function(sfString*) sfString_GetCenterY;
    sfColor function(sfString*) sfString_GetColor;
    sfBlendMode function(sfString*) sfString_GetBlendMode;
    void function(sfString*, float, float) sfString_Move;
    void function(sfString*, float, float) sfString_Scale;
    void function(sfString*, float) sfString_Rotate;
    void function(sfString*, float, float, float*, float*) sfString_TransformToLocal;
    void function(sfString*, float, float, float*, float*) sfString_TransformToGlobal;
    void function(sfString*, CCPTR) sfString_SetText;
    void function(sfString*, CDCPTR) sfString_SetUnicodeText;
    void function(sfString*, sfFont*) sfString_SetFont;
    void function(sfString*, float) sfString_SetSize;
    void function(sfString*, uint) sfString_SetStyle;
    CDCPTR function(sfString*) sfString_GetUnicodeText;
    CCPTR function(sfString*) sfString_GetText;
    sfFont* function(sfString*) sfString_GetFont;
    float function(sfString*) sfString_GetSize;
    uint function(sfString*) sfString_GetStyle;
    void function(sfString*, size_t, float*, float*) sfString_GetCharacterPos;
    sfFloatRect function(sfString*) sfString_GetRect;

    // View.h
    sfView* function() sfView_Create;
    sfView* function(sfFloatRect) sfView_CreateFromRect;
    void function(sfView*) sfView_Destroy;
    void function(sfView*, float, float) sfView_SetCenter;
    void function(sfView*, float, float) sfView_SetHalfSize;
    void function(sfView*, sfFloatRect) sfView_SetFromRect;
    float function(sfView*) sfView_GetCenterX;
    float function(sfView*) sfView_GetCenterY;
    float function(sfView*) sfView_GetHalfSizeX;
    float function(sfView*) sfView_GetHalfSizeY;
    sfFloatRect function(sfView*) sfView_GetRect;
    void function(sfView*, float, float) sfView_Move;
    void function(sfView*, float) sfView_Zoom;
    ");
}