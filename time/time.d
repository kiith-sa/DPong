
//          Copyright Ferdinand Majerech 2010 - 2011.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)


///Time functions.
module time.time;
@safe


import std.conv;
import std.datetime;

import math.math;


///Time when the program started in tenths of microseconds since 00:00 1.1.1 AD.
private immutable long start_time_;

///Static ctor - initialize program start time.
private static this(){start_time_ = Clock.currStdTime();}

///Returns time since program start in seconds.
real get_time(){return (Clock.currStdTime() - start_time_) / 1_000_000_0.0L;}

/**
 * Converts a time value to a string in format mm:ss, or hh:mm:ss if hours is true.
 *
 * Seconds are always represented by two digits, even if the first one is zero, e.g. 01
 * Minutes are shown without the leading zero if hours is false (default), otherwise
 * same as seconds. Hours are always shown without leading zeroes.
 *
 * Params:  time  = Time value to convert.
 *          hours = Show hours (as opposed to only minutes, seconds).
 */
string time_string(in real time, in bool hours = false)
in
{
    assert(time >= 0, "Can't convert negative time value to a string");
}
body
{
    const uint total_s = round_s32(time);
    const uint s = total_s % 60;
    uint m = total_s / 60;
    string s_str = to!string(s);
    if(!hours)
    {
        if(s_str.length == 1){s_str = "0" ~ s_str;}
        return to!string(m) ~ ":" ~ s_str;
    }
    else
    {
        string m_str = to!string(m);
        if(m_str.length == 1){m_str = "0" ~ m_str;}
        const uint h = m / 60;
        m %= 60;
        return to!string(h) ~ ":" ~ m_str ~ ":" ~ s_str;
    }
}
