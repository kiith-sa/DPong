
//          Copyright Ferdinand Majerech 2010 - 2011.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)


///Manual memory management functions.
module memory.memory;
@system:


import std.c.stdlib;
import std.c.string;

import std.algorithm;
import std.conv;
import std.stdio;
import std.string;
import std.traits;

import file.fileio;
debug{import time.time;}
private alias file.file.File File;



public:
    ///Allocate an object of a basic type, or a struct with default values.
    T* alloc(T, string file = __FILE__, uint line = __LINE__)() 
        if(!is(T == class)) 
    {
        return allocate!(T, file, line)();
    }

    template alloc_struct(T) if(is(T == struct))
    {
        /**
         * Allocate a struct with specified parameters to the structs' constructor.
         *
         * Params:  args = Arguments to structs' constructor.
         *
         * Returns: Pointer to allocated struct.
         */
        T* alloc_struct(string file = __FILE__, uint line = __LINE__, Args ...)(Args args)
        {
            return allocate_struct!(T, file, line)(args);
        }
    }

    ///Free an object (struct) allocated by alloc(). Will clear the object.
    void free(T)(T* ptr)
        if(is(T == struct))
    {
        deallocate(ptr);
    }

    ///Unittest for alloc_struct() and free calling dtor.
    unittest
    {
        static struct Test
        {
            static bool dead = false;
            int a, b;

            this(int a, int b)
            {
                this.a = a;
                this.b = b;
            }

            ~this(){dead = true;}
        }
        Test* test = alloc_struct!(Test)(12, 13);
        assert(*test == Test(12,13));
        free(test);
        assert(Test.dead == true);
    }

    /**
     * Allocate an array of objects. 
     *
     * Arrays allocated with alloc must NOT be resized.
     *
     * Params:  elems = Number of objects to allocate space for.
     *
     * Returns: Allocated array.
     */
    T[] alloc_array(T, string file = __FILE__, uint line = __LINE__)(in uint elems)
    {
        return allocate!(T, file, line)(elems);
    }

    /**
     * Reallocate an array allocated by alloc() .
     *
     * Contents of the array are preserved but array itself might be moved in memory,
     * invalidating any pointers pointing to it.
     *
     * If the array is shrunk, any extra elements defining a die() method that
     * are not pointers or reference types (classes) will have that method called.
     *
     * Params:  array = Array to reallocate.
     *          elems = Number of objects for the reallocated array to hold.
     *
     * Returns: Reallocated array.
     */
    T[] realloc(T, string file = __FILE__, uint line = __LINE__)(T[] array, in uint elems)
    {
        return reallocate!(T, file, line)(array, elems);
    }

    /**
     * Free an array of objects allocated by alloc(). 
     *
     * If the type defines a die() method and is not a pointer or reference type
     * (e.g. class), that method will be called for all elements of the array.
     *
     * Params: array = Array to free.
     */
    void free(T)(T[] array){deallocate(array);}

    ///Unittest for alloc(), realloc() and free().
    unittest
    {
        uint[] test = alloc_array!uint(5);
        assert(test.length == 5 && test[3] == 0);
        test[3] = 5;
        test = realloc(test, 4);
        assert(test.length == 4 && test[3] == 5);
        test = realloc(test, 8);
        assert(test.length == 8 && test[3] == 5 && test[7] == 0);
        free(test);
    }

package:
    ///Get currently allocated memory in bytes.
    ulong currently_allocated(){return currently_allocated_;}

private:
    ///Total memory manually allocated over the whole run of the program, in bytes.
    ulong total_allocated_ = 0;
    ///Total memory manually freed over the whole run of the program, in bytes.
    ulong total_freed_ = 0;
    ///Currently allocated memory, in bytes.
    ulong currently_allocated_ = 0;

    ///48 bytes on 64-bit, 40 bytes on 23-bit
    /**
     * Struct holding information about a memory allocation.
     *
     * In release mode, this is simply a pointer to the allocated memory.
     * In debug mode, it holds detailed information about the allocation
     * and takes 48 bytes on 64-bit, 40 bytes on 32-bit.
     */
    align(1) struct Allocation
    {
        private:
        debug
        {
            ///Time when the program started.
            static real start_time_;
            ///Information about allocated type.
            TypeInfo type_; 
            ///Number of objects allocated.
            uint objects_;
            ///Line number where the allocation happened.
            ushort line_;
            ///Time, in seconds since start, when the allocation happened.
            ushort time_;
            ///Last characters of the file name where the allocation happened.
            char[24] file_ = "                        ";
        }

        public:
            ///Pointer to the allocated memory.
            void* ptr;

        public:
            /**
             * Construct an Allocation info object.
             *
             * Template parameters specify data type allocated,
             * file and line where the allocation happened.
             *
             * Params:
             *      ptr     = Pointer to allocated memory.
             *      objects = Number of objects allocated.
             *
             * Returns: Constructed Allocation.
             */
            static Allocation construct(T, string file, uint line) 
                                       (in T* ptr, in uint objects)
            {
                Allocation a;

                debug
                {
                    static if(file.length > 26){a.file_[0 .. 26] = file[$ - 26 .. $];}
                    else{a.file_[0 .. file.length] = file[];}
                    a.line_ = line;
                    a.type_ = typeid(T);
                    a.objects_ = objects;
                    a.time_ = cast(ushort)(get_time() - start_time_);
                }

                a.ptr = cast(void*)ptr;

                return a;
            }

            ///Get information string about the allocation.
            @property string info()
            {
                string meta = "";
                debug
                {
                    meta ~= "__FILE__: " ~ strip(cast(char[])file_) ~ "\n";
                    meta ~= "__LINE__: " ~ to!string(line_) ~ "\n";
                    meta ~= "type    : " ~ type_.toString() ~ "\n";
                    meta ~= "objects : " ~ to!string(objects_) ~ "\n";
                    meta ~= "bytes   : " ~ to!string(objects_ * type_.tsize) ~ "\n";
                    meta ~= "time    : " ~ to!string(time_) ~ "\n";
                    meta ~= "ptr     : ";
                }
                return meta ~ to!string(ptr);
            }

        private:
        debug
        {
            ///Static constructor - set start time.
            static this(){start_time_ = get_time();}
        }
    }

    debug
    {
        ///Information about allocations that have been freed.
        Allocation[] past_allocations_;
    }

    //set (RB tree) might work better if there are performance problems
    ///Information about current allocations.
    Allocation[] allocations_;

    ///Allocate one object and default-initialize it.
    T* allocate(T, string file, uint line)()
    {
        const bytes = T.sizeof;
        T* ptr = cast(T*)malloc(bytes);

        debug_allocate!(T, file, line)(ptr, 1);

        //default-initialize the object.
        *ptr = T.init;
        return ptr;
    }

    /**
     * Allocate a struct with specified parameters for the structs' constructor.
     *
     * Params:  args = Parameters for the structs' constructor.
     *
     * Returns: Pointer to the allocated struct.
     */
    T* allocate_struct(T, string file, uint line)(ParameterTypeTuple!(T.__ctor) args)
    {
        const bytes = T.sizeof;

        scope(failure){writeln("struct allocation failed");}

        T* ptr = cast(T*)malloc(bytes);
        *ptr = T.init;
        ptr.__ctor(args);

        debug_allocate!(T, file, line)(ptr, 1); 

        return ptr;
    }

    /**
     * Allocate an array with given number of elements.
     *
     * Arrays returned by allocate() must NOT be resized.
     *
     * Params:  elems = Number of objects for the array to hold.
     * 
     * Returns: Allocated array.
     */
    T[] allocate(T, string file, uint line)(in uint elems)
    out(result)
    {
        assert(result.length == elems, "Failed to allocate space for "
                                       "specified number of elements");
    }
    body
    {
        const bytes = T.sizeof * elems;
        //only 4G elems supported for now
        T[] array = (cast(T*)malloc(bytes))[0 .. elems];

        debug_allocate!(T, file, line)(array.ptr, elems); 

        //default-initialize the array.
        //using memset for ubytes as it's faster and ubytes are often used for large arrays.
        static if (is(T == ubyte)){memset(array.ptr, 0, bytes);}
        else{array[] = T.init;}
        return array;
    }

    /**
     * Reallocate an array allocated with allocate().
     *
     * Array data might move around the memory, invalidating any pointers to it.
     *
     * Params:  array = Array to reallocate.
     *          elems = Number of elements for the reallocated array to hold.
     *
     * Returns: Reallocated array.
     */
    T[] reallocate(T, string file, uint line)(T[] array, in uint elems)
    in
    {
        debug
        {
        //must be in a separate function due to a compiler bug
        bool match(ref Allocation a){return a.ptr == cast(void*)array.ptr;}
        assert(canFind!match(allocations_),
               "Trying to free a pointer that isn't allocated (or has been freed)");
        }
    }
    body
    {
        const old_bytes = T.sizeof * array.length;
        const new_bytes = T.sizeof * elems;
        T* old_ptr = array.ptr;
        const uint old_length = cast(uint)array.length;
                  
        //if we're shrinking, destroy extra elements unless this is 
        //an array of pointers or reference types.
        static if (!is(typeof(cast(T*)T))) 
        {
            if(old_length > elems)
            {
                foreach(ref T elem; array[elems .. $]){clear(elem);}
            }
        }

        array = (cast(T*)std.c.stdlib.realloc(cast(void*)array.ptr, new_bytes))[0 .. elems];

        debug_reallocate!(T, file, line)(array.ptr, cast(uint)array.length, old_ptr, old_length); 

        //default-initialize new elements, if any
        if(array.length > old_length)
        {
            //using memset for ubytes as it's faster and ubytes are often used for large arrays.
            static if (is(T == ubyte))
            {
                memset(array.ptr + old_length, 0, cast(uint)(new_bytes - old_bytes));
            }
            else if (is(typeof(T.init))) 
            {
                if(array.length > old_length)
                {
                    array[old_length .. $] = T.init;
                }
            }
        }
        return array;
    }

    ///Free an object allocated by allocate(). If a destructor is defined, it will be called.
    void deallocate(T)(ref T* ptr)
    in
    {
        debug
        {
        //must be in a separate function due to a compiler bug
        bool match(ref Allocation a){return a.ptr == cast(void*)ptr;}
        assert(canFind!match(allocations_),
               "Trying to free a pointer that isn't allocated (or has been freed)");
        }
    }
    body
    {
        //call dtor for structs
        clear(*ptr);

        debug_free(ptr, 1); 

        std.c.stdlib.free(ptr);
    }

    /**
     * Free an array allocated by allocate().
     *
     * If a destructor is defined for the array's type and the array doesn't hold
     * pointers or reference types, the destructor will be called for every object in the array.
     *
     * Params:  array = Array to deallocate.
     */
    void deallocate(T)(ref T[] array)
    in
    {
        //must be in a separate function due to a compiler bug
        debug
        {
        bool match(ref Allocation a){return a.ptr == cast(void*)array.ptr;}
        assert(canFind!match(allocations_),
               "Trying to free a pointer that isn't allocated (or has been freed)");
        }
    }
    body
    {
        const bytes = T.sizeof * array.length;

        //destroy the elements unless this is an array of pointers or reference types.
        static if (!is(typeof(cast(T*)(T))))
        {
            foreach(ref T elem; array){clear(elem);}
        }

        debug_free(array.ptr, cast(uint)array.length); 

        std.c.stdlib.free(array.ptr);
    }

    ///Return a string containing statistics about allocated memory.
    string statistics()
    {
        string stats = "Memory allocator statistics:";
        stats ~= "\nTotal allocated (bytes): " ~ to!string(total_allocated_);
        stats ~= "\nTotal freed (bytes): " ~ to!string(total_freed_);

        const non_freed = allocations_.length;
        stats ~= non_freed ? "\nLEAK: " ~ to!string(non_freed) ~ " pointers were not freed."
                           : "\nAll pointers have been freed, no memory leaks detected.";
        stats ~= "\n\n\n";

        if(non_freed)
        {
            stats ~= "Non-freed allocations (LEAKS):";
            foreach(ref allocation; allocations_)
            {
                stats ~= "\n\n" ~ allocation.info;
            }
            stats ~= "\n\n\n";
        }
        debug
        {
            stats ~= "Freed allocations:";
            foreach(ref allocation; past_allocations_)
            {
                stats ~= "\n\n" ~ allocation.info;
            }
        }

        return stats;
    }

    ///Write out allocator statistics at program exit.
    static ~this()
    {
        scope(failure){writeln("Error logging memory usage");}
        ensure_directory_user("main::logs");
        string stats = statistics();

        //using a scope
        {
            File file = File("main::logs/memory.log", FileMode.Write);
            file.write(stats);
        }

        if(allocations_.length > 0)
        {
            writeln("WARNING: MEMORY LEAK DETECTED, FOR MORE INFO SEE:\n"
                     "userdata::main::logs/memory.log");
        }
    }

    /**
     * Record data about an allocation.
     * 
     * Params:  ptr     = Pointer to the allocated memory.
     *          objects = Number of objects allocated.
     */
    void debug_allocate(T, string file, uint line)(in T* ptr, in uint objects)
    {
        allocations_ ~= Allocation.construct!(T, file, line)(ptr, objects);

        const bytes = objects * T.sizeof;
        total_allocated_ += bytes;
        currently_allocated_ += bytes;
    }

    //not the best way to go about recording reallocs, but sufficient for now
    /**
     * Record data about a reallocation.
     * 
     * Params:  new_ptr     = Pointer to the reallocated memory.
     *          new_objects = Number of objects in reallocated memory.
     *          old_ptr     = Pointer to original memory.
     *          old_objects = Number of objects in original memory.
     */
    void debug_reallocate(T, string file, uint line)
                         (in T* new_ptr, in uint new_objects,
                          in T* old_ptr, in uint old_objects)
    {
        //find and replace allocation info corresponding to reallocated data
        bool found = false;
        foreach(ref allocation; allocations_)
        {
            if(allocation.ptr == old_ptr)
            {
                debug{past_allocations_ ~= allocation;}
                //replace allocation info
                allocation = Allocation.construct!(T, file, line)(new_ptr, new_objects);
                found = true;
                break;
            }
        }
        assert(found, "No match found for a pointer to reallocate");

        const old_bytes = old_objects * T.sizeof;
        const new_bytes = new_objects * T.sizeof;
        const diff = new_bytes - old_bytes;
        total_allocated_ += diff;
        currently_allocated_ += diff;
    }

    /**
     * Record data about a deallocation.
     * 
     * Params:  ptr     = Pointer to deallocated memory.
     *          objects = Number of objects deallocated.
     */
    void debug_free(T)(in T* ptr, in uint objects)
    {
        //remove allocation info
        bool found = false;
        foreach(ref allocation; allocations_)
        {
            if(allocation.ptr == ptr)
            {
                debug{past_allocations_ ~= allocation;}
                //remove by rewriting by the last allocation
                allocation = allocations_[$ - 1];
                found = true;
                break;
            }
        }
        assert(found, "No match found for pointer to free");
        allocations_ = allocations_[0 .. $ - 1];

        const bytes = objects * T.sizeof;
        total_freed_ += bytes;
        currently_allocated_ -= bytes;
    }
