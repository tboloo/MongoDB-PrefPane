//
//  LaunchctlController.m
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 14/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//
#import <sys/sysctl.h>

#import "LaunchctlController.h"

@interface LaunchctlController ()
+(NSMutableDictionary*)getBSDProcessList;
@end

@implementation LaunchctlController

/*! Gets the full list of running processes.
See: http://developer.apple.com/legacy/mac/library/#qa/qa2001/qa1123.html */
+ (NSMutableDictionary*)getBSDProcessList {
    int                 err;
    bool                done = false;
    static const int    name[] = { CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0 };
    // Declaring name as const requires us to cast it when passing it to
    // sysctl because the prototype doesn't include the const modifier.
    size_t              length;
    struct kinfo_proc   *procList = NULL;
    size_t              procCount = 0;
    
    // We start by calling sysctl with result == NULL and length == 0.
    // That will succeed, and set length to the appropriate length.
    // We then allocate a buffer of that size and call sysctl again
    // with that buffer.  If that succeeds, we're done.  If that fails
    // with ENOMEM, we have to throw away our buffer and loop.  Note
    // that the loop causes use to call sysctl with NULL again; this
    // is necessary because the ENOMEM failure case sets length to
    // the amount of data returned, not the amount of data that
    // could have been returned.
    
    do {
        // Call sysctl with a NULL buffer.
        
        length = 0;
        err = sysctl( (int *) name, (sizeof(name) / sizeof(*name)) - 1,
                     NULL, &length,
                     NULL, 0);
        if (err == -1) {
            err = errno;
        }
        
        // Allocate an appropriately sized buffer based on the results
        // from the previous call.
        
        if (err == 0) {
            procList = malloc(length);
            if (procList == NULL) {
                err = ENOMEM;
            }
        }
        
        // Call sysctl again with the new buffer.  If we get an ENOMEM
        // error, toss away our buffer and start again.
        
        if (err == 0) {
            err = sysctl( (int *) name, (sizeof(name) / sizeof(*name)) - 1,
                         procList, &length,
                         NULL, 0);
            if (err == -1) {
                err = errno;
            }
            if (err == 0) {
                done = true;
            } else if (err == ENOMEM) {
                assert(procList != NULL);
                free(procList);
                procList = NULL;
                err = 0;
            }
        }
    } while (err == 0 && ! done);
    
    // Clean up and establish post conditions.
    
    if (err != 0 && procList != NULL) {
        free(procList);
        procList = NULL;
    }
    
    if (err == 0) {
        procCount = length / sizeof(struct kinfo_proc);
    }
    
    NSMutableDictionary *runningProcesses = [NSMutableDictionary new];
    
    for (int i = 0; i < procCount; i++) {
        struct kinfo_proc *proc = NULL;
        proc = &procList[i];
        NSNumber *pid = @(proc->kp_proc.p_pid);
        NSString *procName = [NSString stringWithFormat:@"%s",proc->kp_proc.p_comm];
        [runningProcesses setObject:procName forKey:pid];
    }
    
    return runningProcesses;
}

+(NSNumber *)isProcessRunning:(NSNumber *)pid {
    return @([[LaunchctlController getBSDProcessList] objectForKey:pid] != nil);
}


@end
