/*
 * Secure Australasia PL
 * admin@delaneymorgan.com.au
 *
 * File: trace_def.h
 *
 * Description:
 * This module provides a simple tracing facility for Cocoa.
 *
 * Usage:
 * Simply include the header into your module body.
 *
 * Usage:
 * =====
 *
 * TRACE_START()    - put at top of function
 * TRACE_END()      - put at bottom of function
 * TRACE_CHECK(format,...) - use anywhere in-between, just like printf
 *
 * Control via definition of TRACE_FLAG in your module.
 *
 * #define TRACE_FLAG   YES
 *
 * ...to enable tracing, and...
 *
 * #define TRACE_FLAG   NO
 *
 * ...to disable it.
 */
#ifndef trace_def__h
#define trace_def__h


#ifdef __GNUC__

	#if defined( __APPLE__) && defined( __MACH__) && defined (__OBJC__)

        // MacOSX
        #define TRACE_START()					{if (TRACE_FLAG) { NSLog( @"trace: %s START", __func__);}}
        #define TRACE_END()						{if (TRACE_FLAG) { NSLog( @"trace: %s END", __func__);}}
        #define TRACE_CHECK( format, args...)	{if (TRACE_FLAG) { NSLog( @"trace: %s:%d CHECK - " format, __func__, __LINE__, ## args);}}

    #else
    
        #include <syslog.h>
        
        // some other OS
        #define TRACE_START()					{if (TRACE_FLAG) { syslog( LOG_NOTICE, "trace: %s START", __func__);}}
        #define TRACE_END()						{if (TRACE_FLAG) { syslog( LOG_NOTICE, "trace: %s END", __func__);}}
        #define TRACE_CHECK( format, args...)	{if (TRACE_FLAG) { syslog( LOG_NOTICE, "trace: %s:%d CHECK - " format, __func__, __LINE__, ## args);}}

    #endif
    
#else   // __GNUC__

        // some other compiler
        #define TRACE_START()					{}
        #define TRACE_END()						{}
        #define TRACE_CHECK( format, args...)	{}

#endif

#endif
