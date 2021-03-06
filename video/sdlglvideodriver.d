
//          Copyright Ferdinand Majerech 2010 - 2011.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)


///GLVideoDriver using SDL to set up video mode.
module video.sdlglvideodriver;
@trusted


import derelict.sdl.sdl;

import std.stdio;
import std.string;

import video.videodriver;
import video.glvideodriver;
import video.fontmanager;
import color;


///GLVideoDriver implementation using SDL to set up video mode.
final class SDLGLVideoDriver : GLVideoDriver
{
    public:
        /**
         * Construct a SDLGLVideoDriver.
         *
         * Params:  font_manager = Font manager to use for font rendering and management.
         */
        this(FontManager font_manager)
        {
            writeln("Initializing SDLGLVideoDriver");
            super(font_manager);
        }

        ~this()
        {
            writeln("Destroying SDLGLVideoDriver");
        }

        override void set_video_mode(in uint width, in uint height, 
                                     in ColorFormat format, in bool fullscreen)
        {
            assert(width >= 80 && width <= 65536, 
                   "Can't set video mode with such ridiculous width");
            assert(height >= 60 && width <= 49152, 
                   "Can't set video mode with such ridiculous height");

            //determine bit depths of color channels.
            uint red, green, blue, alpha;
            switch(format)
            {
                case ColorFormat.RGB_565:
                    red = 5;
                    green = 6;
                    blue = 5;
                    alpha = 0;
                    break;
                case ColorFormat.RGBA_8:
                    red = 8;
                    green = 8;
                    blue = 8;
                    alpha = 8;
                    break;
                default:
                    assert(false, "Unsupported video mode color format");
            }

            SDL_GL_SetAttribute(SDL_GL_RED_SIZE, red);
            SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE, green);
            SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE, blue);
            SDL_GL_SetAttribute(SDL_GL_ALPHA_SIZE, alpha);
            SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);

            const uint bit_depth = red + green + blue + alpha;

            uint flags = SDL_OPENGL;
            if(fullscreen){flags |= SDL_FULLSCREEN;}

            if(SDL_SetVideoMode(width, height, bit_depth, flags) is null)
            {
                string msg = std.string.format("Could not set video mode: %d %d %dbpp",
                                               width, height, bit_depth);
                writeln(msg);
                throw new VideoDriverException(msg);
            }

            screen_width_ = width;
            screen_height_ = height;
            
            init_gl();
        }

        override void end_frame()
        {
            super.end_frame();
            SDL_GL_SwapBuffers();
        }
}
