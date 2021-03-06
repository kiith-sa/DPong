
//          Copyright Ferdinand Majerech 2010 - 2011.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)


///Base class for actors in the scene.
module scene.actor;
@safe


import std.string;
import std.stdio;

import scene.scenemanager;
import physics.physicsbody;
import video.videodriver;
import math.vector2;
import math.rectangle;
import util.factory;


/** 
 * Base class for all game objects.
 *
 * Actor with a physics body.
 */
abstract class Actor
{
    protected:
        ///Physics body of this actor.
        PhysicsBody physics_body_;

        ///Index of update when the actor is dead (to be removed).
        size_t dead_at_update_ = size_t.max;

    public:
        ///Get position of this actor.
        @property final Vector2f position() const {return physics_body_.position;}

        ///Get velocity of this actor.
        @property final Vector2f velocity() const {return physics_body_.velocity;}

        ///Get a reference to physics body of this actor.
        @property final PhysicsBody physics_body() {return physics_body_;}

        /**
         * Destroy the actor at the end of specified update.
         *
         * This can be used to destroy the actor at the current update by passing
         * current update_index from the SceneManager.
         * 
         * Note that the actor will not be destroyed immediately -
         * At the end of update, all dead actors' on_die() methods are called 
         * first, and then the actors are destroyed.
         *
         * Params: update_index  = Update to destroy the actor at.
         */
        final void die(size_t update_index)
        {
            physics_body_.die(update_index);
            dead_at_update_ = update_index;
        }

    protected:
        /**
         * Construct an Actor.
         *
         * Params:  physics_body = Physics body of the actor.
         */
        this(PhysicsBody physics_body) 
        in
        {
            assert(physics_body !is null, "Can't construct an actor without a physics body");
        }
        body
        {
            physics_body_ = physics_body;
        };

        /**
         * Called at the end of the update after the actors' die() method is called.
         *
         * This is used to handle any game logic that needs to happen when an 
         * actor dies, for instance detaching particle systems from an actor or
         * spawning new actors.
         *
         * The physics body of the actor is not yet destroyed at on_die().
         *
         * Params:  manager = SceneManager to get time information and add new actors.
         */
        void on_die(SceneManager manager){};

        /**
         * Update this Actor.
         *
         * Params:  manager   = SceneManager to get time information from and/or add new actors.
         */
        void update(SceneManager manager);

        ///Draw this actor.
        void draw(VideoDriver driver);

    package:
        ///Is the actor dead at specified update?
        @property final bool dead (in size_t update_index) const
        {
            return update_index >= dead_at_update_;
        }

        /**
         * Used by SceneManager to update the actor.
         *
         * Params:  manager   = SceneManager to get time information from and/or add new actors.
         */
        final void update_package(SceneManager manager){update(manager);}

        /**
         * Used by SceneManager to call on_die() of the actor.
         *
         * Params:  manager   = SceneManager to get time information from and/or add new actors.
         */
        final void on_die_package(SceneManager manager){on_die(manager);}


        ///Interface used by SceneManager to draw the actor.
        final void draw_actor(VideoDriver driver){draw(driver);}
}

/**
 * Base class for actor factories, template type T specifies type the factory constructs.
 *
 * Params:  position = Starting position of the actor. 
 *                     Default; zero vector
 *          velocity = Starting velocity of the actor.
 *                     Default; zero vector
 */
abstract class ActorFactory(T)
{
    mixin(generate_factory("Vector2f $ position $ Vector2f(0.0f, 0.0f)", 
                           "Vector2f $ velocity $ Vector2f(0.0f, 0.0f)"));

    /**
     * Do any work required on the new actor to be produced and return it.
     *
     * This is used as a shortcut to add a produced actor to the scene manager
     * and do any other work that needs to be done on all new actors.
     */
    protected final T new_actor(SceneManager manager, T actor)
    {
        manager.add_actor(actor);
        return actor;
    }

    /**
     * Return a new instance of the actor type produced with factory parameters.
     *
     * Params:  manager = Scene manager to manage the actor and any actors it creates. 
     */
    public T produce(SceneManager manager);
}
