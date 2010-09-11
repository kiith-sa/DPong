module video.fontmanager;


import std.c.string;

import derelict.freetype.ft;
import derelict.util.loader;
import derelict.util.exception;

import video.font;
import video.texture;
import math.math;
import math.vector2;
import singleton;
import color;
import arrayutil;
import allocator;


///Used by VideoDriver implementations to draw a string.
package align(1) struct FontRenderer
{
    private:
        //Font we're drawing with.
        Font draw_font_;
        //FreeType font face of the font.
        FT_Face font_face_;
        //Does this font use kerning?
        bool kerning_;
        //Freetype index of the previously drawn glyph (0 at first glyph).
        uint previous_index_;
        //Current x position of the pen.
        uint PenX;

    public:
        ///Return height of the font we're drawing.
        uint height(){return draw_font_.height;}

        ///Start drawing a string.
        void start()
        {
            font_face_ = draw_font_.font_face;
            kerning_ = draw_font_.kerning && FontManager.get.kerning;
            previous_index_ = PenX = 0;
        }

        ///Get texture, offset (relative to string start) to draw a character at.
        Texture* glyph(dchar c, out Vector2u offset)
        {
            Glyph* glyph = draw_font_.get_glyph(c);
            uint glyph_index = glyph.freetype_index;

            //adjust pen with kering information
            if(kerning_ && previous_index_ != 0 && glyph_index != 0)
            {
                FT_Vector kerning;
                FT_Get_Kerning(font_face_, previous_index_, glyph_index, 
                               FT_Kerning_Mode.FT_KERNING_DEFAULT, &kerning);
                PenX += kerning.x / 64;
            }

            offset.x = PenX + glyph.offset.x;
            offset.y = glyph.offset.y;
            previous_index_ = glyph_index;

            //move pen to the next glyph
            PenX += glyph.advance;
            return &glyph.texture;
        }
}

///Handles all font resources. 
package final class FontManager
{
    mixin Singleton;
    private:
        static FT_Library freetype_lib_;
        Font[] fonts_;
        
        //Fallback font: fonts_[0] will be loaded with these parameters.
        string default_font_name_ = "DejaVuSans.ttf";
        uint default_font_size_ = 12;

        //Currently set font.
        Font current_font;

        //Currently set font name and size
        string font_name_;
        uint font_size_;

        //Default number of quickly accessible characters in fonts.
        //Glyphs up to this unicode index will be stored in a normal 
        //instead of associative array, speeding up their retrieval.
        //512 covers latin with most important extensions.
        uint fast_glyphs = 512;

        //Is font antialiasing enabled?
        bool antialiasing_ = true;
        //Is kerning enabled?
        bool kerning_ = true;
        
    public:
        //Construct the font manager, load default font.
        this()
        {
            singleton_ctor();
            try
            {
                //sometimes FreeType is missing a function we don't use, 
                //we don't want to crash in that case.
                Derelict_SetMissingProcCallback(function bool(string a, string b)
                                                {return true;});
                //load FreeType library
                DerelictFT.load(); 
                Derelict_SetMissingProcCallback(null);
                //initialize FreeType
                if(FT_Init_FreeType(&freetype_lib_) != 0 || freetype_lib_ is null)
                {
                    throw new Exception("FreeType initialization error");
                }
                try
                {
                    //load default font.
                    fonts_ ~= Font(default_font_name_, default_font_size_, fast_glyphs);
                    current_font = fonts_[$ - 1];
                    font_name_ = default_font_name_;
                    font_size_ = default_font_size_;
                }
                catch
                {
                    throw new Exception("Could not load default font.");
                }
            }
            catch(SharedLibLoadException e)
            {
                throw new Exception("Could not load FreeType library");
            }
        }

        ///Destroy the FontManager. Should only be called at shutdown.
        void die()
        {
            foreach(ref font; fonts_){font.die();}
            fonts_ = [];
            FT_Done_FreeType(freetype_lib_);
            DerelictFT.unload(); 
        }

        ///Set font to use. force_load will set font (load if needed) immediately.
        void font(string font_name, bool force_load = false)
        {
            //use default font
            if(font_name == "default"){font_name = default_font_name_;}
            font_name_ = font_name;
            if(force_load){load_font();}
        }

        ///Set font size to use. force_load will set font (load if needed) immediately.
        void font_size(uint size, bool force_load = false)
        in{assert(size < 128, "Font sizes greater than 127 are not supported");}
        body
        {
            //In optimized build, we don't have the assert so force size to at most 127
            size = min(size, 127u);
            font_size_ = size;
            if(force_load){load_font();}
        }

        ///Get size of text as it would be drawn in pixels.
        Vector2u text_size(string text)
        {
            load_font();
            return Vector2u(current_font.text_width(text), current_font.size);
        }

        ///Return renderer to draw text with.
        FontRenderer renderer()
        {
            load_font();
            return FontRenderer(current_font);
        }

        ///Try to set font according to font_name_ and font_size.
        /**
         * Will load the font if needed, and if it can't load, will
         * try to fall back to default font with font_size_. If that can't
         * be done either, will set the default font loaded at startup.
         */
        void load_font()
        {
            //Font is already set
            if(current_font.name == font_name_ && current_font.size == font_size_)
            {
                return;
            }

            bool find_font(ref Font font)
            {
                return font.name == font_name_ && font.size == font_size_;
            }
            int index = fonts_.find(&find_font);

            //Font is already loaded, set it
            if(index >= 0)
            {
                current_font = fonts_[index];
                return;
            }

            //Font is not loaded, try to load it
            Font new_font;
            try
            {
                new_font = Font(font_name_, font_size_, fast_glyphs);
                //Font was succesfully loaded, set it
                fonts_ ~= new_font;
                current_font = fonts_[$ - 1];
            }
            catch
            {
                //If we already have default font name and can't load it, 
                //try font 0 (default with default size)
                if(font_name_ == default_font_name_)
                {
                    current_font = fonts_[0];
                    return;
                }
                //Couldn't load the font, try default with our size
                font_name_ = default_font_name_;
                load_font();
            }
        }
    
        ///Return handle to FreeType library used by the manager.
        static FT_Library freetype(){return freetype_lib_;}

        ///Return bool specifying whether or not font antialiasing is enabled.
        bool antialiasing(){return antialiasing_;}
      
        ///Return bool specifying whether or not font antialiasing is enabled.
        bool kerning(){return kerning_;}
}