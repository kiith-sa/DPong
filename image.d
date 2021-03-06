
//          Copyright Ferdinand Majerech 2010 - 2011.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)


///2D image struct.
module image;


import core.stdc.string;

import math.vector2;
import color;
import memory.memory;


//will be an RAII struct in D2
//could be optimized by adding a pitch data member (bytes per row)    
///Image object capable of storing images in various color formats.
struct Image
{
    //commented out due to a compiler bug
    //invariant(){assert(data_ !is null, "Image with NULL data");}

    private:
        ///Image data. Manually allocated.
        ubyte[] data_ = null;
        ///Size of the image in pixels.
        Vector2u size_;
        ///Color format of the image.
        ColorFormat format_;

    public:
        /**
         * Construct an image.
         *
         * Params:  width  = Width in pixels.
         *          height = Height in pixels.
         *          format = Color format of the image.
         */
        this(in uint width, in uint height, 
             in ColorFormat format = ColorFormat.RGBA_8)
        {
            data_ = alloc_array!ubyte(width * height * bytes_per_pixel(format));
            size_ = Vector2u(width, height);
            format_ = format;
        }

        ///Destroy the image and free its memory.
        ~this(){if(data !is null){free(data_);}}
        
        ///Get color format of the image.
        @property ColorFormat format() const {return format_;}

        ///Get size of the image in pixels.
        @property Vector2u size() const {return size_;}

        ///Get image width in pixels.
        @property uint width() const {return size_.x;}

        ///Get image height in pixels.
        @property uint height() const {return size_.y;}

        ///Get direct read-only access to image data.
        @property const(ubyte[]) data() const {return data_;}

        ///Get direct read-write access to image data.
        @property ubyte[] data_unsafe() {return data_;}

        /**
         * Set RGBA pixel color.
         *
         * Only valid on RGBA_8 images.
         *
         * Params:  x     = X coordinate of the pixel.
         *          y     = Y coordinate of the pixel.
         *          color = Color to set.
         */
        void set_pixel_rgba8(in uint x, in uint y, in Color color)
        in
        {
            assert(x < size_.x && y < size_.y, "Pixel out of range");
            assert(format == ColorFormat.RGBA_8, "Incorrect image format");
        }
        body
        {
            const uint offset = y * pitch + x * 4;
            data_[offset]     = color.r;
            data_[offset + 1] = color.g;
            data_[offset + 2] = color.b;
            data_[offset + 3] = color.a;
        }

        /**
         * Set grayscale pixel color.
         *
         * Only valid on GRAY_8 images.
         *
         * Params:  x     = X coordinate of the pixel.
         *          y     = Y coordinate of the pixel.
         *          color = Color to set.
         */
        void set_pixel_gray8(in uint x, in uint y, in ubyte color)
        in
        {
            assert(x < size_.x && y < size_.y, "Pixel out of range");
            assert(format == ColorFormat.GRAY_8, "Incorrect image format");
        }
        body{data_[y * pitch + x] = color;}

        /**
         * Get RGBA color of a pixel.
         *
         * Only supported on RGBA_8 images (can be improved).
         *
         * Params:  x = X coordinate of the pixel.
         *          y = Y coordinate of the pixel.
         *
         * Returns: Color of the pixel.
         */
        Color get_pixel(in uint x, in uint y) const
        in
        {
            assert(x < size_.x && y < size_.y, "Pixel out of range");
            assert(format == ColorFormat.RGBA_8,
                   "Getting pixel color only supported with RGBA_8");
        }
        body
        {
            const uint offset = y * pitch + x * 4;
            return Color(data_[offset], 
                         data_[offset + 1], 
                         data_[offset + 2], 
                         data_[offset + 3]);
        }
        
        //This is extremely ineffective/ugly, but not really a priority
        /**
         * Generate a black/transparent-white/opague checker pattern.
         *
         * Params:  size = Size of one checker square.
         */
        void generate_checkers(in uint size)
        {
            bool white;
            foreach(y; 0 .. size_.y) foreach(x; 0 .. size_.x)
            {
                white = cast(bool)(x / size % 2);
                if(cast(bool)(y / size % 2)){white = !white;}
                if(white) final switch(format_)
                {
                    case ColorFormat.RGB_565:
                        data_[y * pitch + x * 2] = 255;
                        data_[y * pitch + x * 2 + 1] = 255;
                        break;
                    case ColorFormat.RGB_8:
                        data_[y * pitch + x * 3] = 255;
                        data_[y * pitch + x * 3 + 1] = 255;
                        data_[y * pitch + x * 3 + 2] = 255;
                        break;
                    case ColorFormat.RGBA_8:
                        set_pixel_rgba8(x, y, Color.white);
                        break;
                    case ColorFormat.GRAY_8:
                        set_pixel_gray8(x, y, 255);
                        break;
                }
            }
        }

        //This is extremely ineffective/ugly, but not really a priority
        /**
         * Generate a black/transparent-white/opague stripe pattern
         *
         * Params:  distance = Distance between 1 pixel wide stripes.
         */
        void generate_stripes(in uint distance)
        {
            foreach(y; 0 .. size_.y) foreach(x; 0 .. size_.x)
            {
                if(cast(bool)(x % distance == y % distance)) final switch(format_)
                {
                    case ColorFormat.RGB_565:
                        data_[y * pitch + x * 2] = 255;
                        data_[y * pitch + x * 2 + 1] = 255;
                        break;
                    case ColorFormat.RGB_8:
                        data_[y * pitch + x * 3] = 255;
                        data_[y * pitch + x * 3 + 1] = 255;
                        data_[y * pitch + x * 3 + 2] = 255;
                        break;
                    case ColorFormat.RGBA_8:
                        set_pixel_rgba8(x, y, Color.white);
                        break;
                    case ColorFormat.GRAY_8:
                        set_pixel_gray8(x, y, 255);
                        break;
                }
            }
        }

        ///Gamma correct the image with specified factor.
        void gamma_correct(in real factor)
        in{assert(factor >= 0.0, "Gamma correction factor must not be negative");}
        body
        {
            Color pixel;
            foreach(y; 0 .. size_.y) foreach(x; 0 .. size_.x)
            {
                switch(format_)
                {
                    case ColorFormat.RGBA_8:
                        pixel = get_pixel(x, y);
                        pixel.gamma_correct(factor);
                        set_pixel_rgba8(x, y, pixel);
                        break;
                    case ColorFormat.GRAY_8:
                        set_pixel_gray8(x, y, 
                        Color.gamma_correct(data_[y * pitch + x], factor));
                        break;
                    default:
                        assert(false, "Unsupported color format for gamma correction");
                }
            }
        }

        ///Flip the image vertically.
        void flip_vertical()
        {
            const uint pitch = pitch();
            ubyte[] temp_row = alloc_array!ubyte(pitch);
            foreach(row; 0 .. size_.y / 2)
            {
                //swap row and size_.y - row
                ubyte* row_a = data_.ptr + pitch * row;
                ubyte* row_b = data_.ptr + pitch * (size_.y - row - 1);
                memcpy(temp_row.ptr, row_a, pitch);
                memcpy(row_a, row_b, pitch);
                memcpy(row_b, temp_row.ptr, pitch);
            }
            free(temp_row);
        }

    private:
        ///Get pitch (bytes per row) of the image.
        @property uint pitch() const {return bytes_per_pixel(format_) * size_.x;}
}
