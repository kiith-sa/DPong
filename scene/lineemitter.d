
//          Copyright Ferdinand Majerech 2010 - 2011.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)


///Line emitter particle system.
module scene.lineemitter;
@safe


import std.math;

import scene.actor;
import scene.particleemitter;
import scene.scenemanager;
import physics.physicsbody;
import video.videodriver;
import math.vector2;
import color;
import util.factory;


/**
 * Particle emitter that emits lines.
 *
 * Emitted particles gradually blend color during their lifetime,
 * from specified start color to specified end color.
 */
class LineEmitter : ParticleEmitter
{
    invariant()
    {
        assert(line_length_ > 0.0, "LineEmitter line length must be greater than 0");
        assert(line_width_ > 0.0, "LineEmitter line width must be greater than 0");
        assert(emit_velocity_ != Vector2f(0.0, 0.0), "Can't emit particles with zero velocity");
    }

    protected:
        ///Length of line particles.
        float line_length_ = 8.0f;
        ///Width of line particles.
        float line_width_  = 2.0f;
        ///Color of particles at the beginning of their life.
        Color start_color_ = Color.white;
        ///Color of particles at the end of their life.
        Color end_color_   = rgba!"FFFFFF00";

    public:
        ///Set length of the line particles.
        @property final void line_length(in float length){line_length_ = length;}

        ///Set width of the line particles.
        @property final void line_width(in float width){line_width_ = width;}

        ///Set color the particles have at the beginning of their lifetimes.
        @property final void start_color(in Color color){start_color_ = color;}

        ///Set color the particles have at the end of their lifetimes.
        @property final void end_color(in Color color){end_color_ = color;}

    protected:
        /**
         * Construct a LineEmitter.
         *
         * Params:  physics_body    = Physics body of the emitter.
         *          owner           = Actor to attach the emitter to. 
         *                            If null, the emitter is independent.
         *          life_time       = Life time of the emitter in seconds. 
         *                            If negative, lifetime is indefinite.
         *          particle_life   = Life time of particles emitted.
         *          emit_frequency  = Frequency to emit particles at in particles per second.
         *          emit_velocity   = Base velocity of particles emitted.
         *          angle_variation = Variation of angle of emit velocity in radians.
         *          line_length     = Length of lines emitted in pixels.
         *          line_width      = Width of lines emitted in pixels.
         *          start_color     = Color at the beginning of particle lifetime.
         *          end_color       = Color at the end of particle lifetime.  
         */                          
        this(PhysicsBody physics_body, Actor owner, 
             in real life_time, in real particle_life, in real emit_frequency, 
             in Vector2f emit_velocity, in real angle_variation, in float line_length, 
             in float line_width, in Color start_color, in Color end_color)
        {
            line_length_ = line_length;
            line_width_  = line_width;
            start_color_ = start_color;
            end_color_   = end_color;
            super(physics_body, owner, life_time, particle_life,
                  emit_frequency, emit_velocity, angle_variation);
        }

        override void draw(VideoDriver driver)
        {
            driver.line_aa = true;
            driver.line_width = line_width_;
            Color color;
            //draw particles
            foreach(ref p; particles_)
            {
                color = end_color_.interpolated(start_color_, p.timer.age_relative(game_time_));
                //determine line from particle velocity
                //note that we assume that particle velocity is never zero,
                //otherwise normalization would break
                driver.draw_line(p.position, p.position + p.velocity.normalized * line_length_,
                                 color, color);
            }
            driver.line_width = 1.0f;
            driver.line_aa = false;
        }
}

/**
 * Base class for factories producing LineEmitter or derived classes.
 *
 * Params:  line_width  = Width of lines emitted in pixels.
 *                        Default; 1.0
 *          start_color = Color at the beginning of particle lifetime. 
 *                        Default; Color.white
 *          end_color   = Color at the end of particle lifetime. 
 *                        Default; Color.black
 */
abstract class LineEmitterFactoryBase(T) : ParticleEmitterFactory!T
{
    mixin(generate_factory("float $ line_width $ 1",
                           "Color $ start_color $ Color.white",
                           "Color $ end_color $ Color.black"));
    ///Return physics body constructed from factory parameters. Used by produce().
    protected PhysicsBody physics_body()
    {
        return new PhysicsBody(null, position_, velocity_, 10.0);
    }
}

/**
 * Factory producing line emitters.
 *
 * Params:  line_length = Length of the lines emitted in pixels.
 *                        Default; 5.0
 */
class LineEmitterFactory : LineEmitterFactoryBase!(LineEmitter)
{
    mixin(generate_factory("float $ line_length $ 5.0"));

    public override LineEmitter produce(SceneManager manager)
    {
        return new_actor(manager, 
                         new LineEmitter(physics_body, owner_, life_time_,
                                         particle_life_, emit_frequency_, emit_velocity_, 
                                         angle_variation_, line_length_, line_width_, 
                                         start_color_, end_color_));
    }
}
