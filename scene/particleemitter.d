
//          Copyright Ferdinand Majerech 2010 - 2011.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)


///Base class for particle emitters.
module scene.particleemitter;
@safe


import std.math;
import std.random;

import scene.actor;
import scene.scenemanager;
import scene.particlesystem;
import physics.physicsbody;
import math.math;
import math.vector2;
import time.timer;
import util.factory;
import containers.vector;


///Single particle of a particle system.
private struct Particle
{
    ///Timer determining life time of the particle.
    Timer timer;
    ///Position of the particle in world space.
    Vector2f position;
    ///Velocity of the particle in world space.
    Vector2f velocity;
    
    /**
     * Update the particle.
     *
     * Params:  time_step = Time step of the update.
     */
    void update(in real time_step){position += velocity * time_step;}
}

///Base class for particle emitters.
abstract class ParticleEmitter : ParticleSystem
{
    invariant()
    {
        assert(particle_life_ > 0.0, "Lifetime of particles emitted must be > 0");
        assert(emit_frequency_ >= 0.0, "Particle emit frequency must not be negative");
        assert(angle_variation_ >= 0.0, "Particle angle variation must not be negative");
    }

    private:
        ///Lifetime of particles emitted.
        real particle_life_    = 5.0;
        ///Time since the last particle was emitted.
        real time_accumulated_ = 0.0;
        ///Variation of angles of particles' velocities (in radians).
        real angle_variation_  = PI / 2;
        ///Emit frequency in particles per second.
        real emit_frequency_   = 10.0;

    protected:
        ///Particles in the system.
        Vector!Particle particles_;

        ///Velocity to emit particles at.
        Vector2f emit_velocity_ = Vector2f(1.0, 0.0);
        ///Current game time.
        real game_time_;

    public:
        ///Set life time of particles emitted.
        @property final void particle_life(in real life){particle_life_ = life;}
        
        ///Get life time of particles emitted.
        @property final real particle_life() const {return particle_life_;}

        ///Set number of particles to emit per second.
        @property void emit_frequency(in real frequency){emit_frequency_ = frequency;}
        
        ///Get number of particles emitted per second.
        @property final real emit_frequency() const {return emit_frequency_;}

        ///Set velocity to emit particles at.
        @property final void emit_velocity(in Vector2f velocity){emit_velocity_ = velocity;}

        ///Set angle variation of particles emitted in radians.
        @property final void angle_variation(in real variation){angle_variation_ = variation;}

    protected:
        /**
         * Construct a ParticleEmitter.
         *
         * Params:  physics_body    = Physics body of the emitter.
         *          owner           = Class to attach the emitter to. 
         *                            If null, the emitter is independent.
         *          life_time       = Life time of the emitter. 
         *                            If negative, lifetime is indefinite.
         *          particle_life   = Life time of particles emitted.
         *          emit_frequency  = Frequency to emit particles at in particles per second.
         *          emit_velocity   = Base velocity of particles emitted.
         *          angle_variation = Variation of angle of emit velocity in radians.
         */                          
        this(PhysicsBody physics_body, Actor owner, 
             in real life_time, in real particle_life, in real emit_frequency, 
             in Vector2f emit_velocity, in real angle_variation)
        {
            particle_life_   = particle_life;
            emit_frequency_  = emit_frequency;
            angle_variation_ = angle_variation;
            emit_velocity_   = emit_velocity;
            particles_.reserve(8);

            super(physics_body, owner, life_time);
        }

        override void update(SceneManager manager)
        {
            //if attached, get position from the owner.
            if(owner_ !is null){physics_body_.position = owner_.position;}

            game_time_ = manager.game_time;

            bool expired(ref Particle p){return p.timer.expired(manager.game_time);}
            //remove expired particles
            particles_.remove(&expired);
                              
            //emit new particles
            emit(manager.time_step);

            //update particles
            foreach(ref particle; particles_){particle.update(manager.time_step);}

            super.update(manager);
        }

        /**
         * Emit particles if any should be emitted this frame.
         * 
         * Params:  time_step = Time step in seconds.
         */
        void emit(in real time_step)
        {
            time_accumulated_ += time_step;
            if(equals(emit_frequency_, 0.0L)){return;}
            const real emit_period = 1.0 / emit_frequency_;
            while(time_accumulated_ >= emit_period)
            {
                //add a new particle
                Particle particle;
                with(particle)
                {
                    timer          = Timer(particle_life_, game_time_);
                    position       = physics_body_.position;
                    velocity       = emit_velocity_;
                    velocity.angle = particle.velocity.angle + 
                                     uniform(-angle_variation_, angle_variation_);
                }
                particles_ ~= particle;

                time_accumulated_ -= emit_period;
            }
        }
}

/**
 * Base class for factories producing ParticleEmitter derived classes.
 *
 * Params:  particle_life   = Life time of particles emitted in seconds.
 *                            Default; 5.0
 *          emit_frequency  = Frequency to emit particles at in particles per second.
 *                            Default; 10.0
 *          emit_velocity   = Base velocity of particles emitted.
 *                            Default; Vector2f(1.0f, 1.0f)
 *          angle_variation = Variation of angle of emit velocity in radians.
 *                            Default; PI / 2
 */                          
abstract class ParticleEmitterFactory(T) : ParticleSystemFactory!T
{
    mixin(generate_factory("real $ particle_life $ 5.0",
                           "real $ emit_frequency $ 10.0",
                           "Vector2f $ emit_velocity $ Vector2f(1.0f, 1.0f)",
                           "real $ angle_variation $ PI / 2"));
}
