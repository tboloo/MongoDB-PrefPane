//
//  ProcessController.m
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 12/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import "ProcessController.h"

@implementation ProcessController
+(NSNumber*)checkProcessWithPid:(NSNumber*)pid {
    if(pid == nil) {
        return NO;
    } else {
//        NSWorkspace *workSpace = [NSWorkspace sharedWorkspace];
//        for( NSRunningApplication *app in [workSpace runningApplications]) {
//            NSLog(@"app: %@", app);
//        }
        NSRunningApplication *app = [NSRunningApplication runningApplicationWithProcessIdentifier:[pid intValue]];
        NSLog(@"%@ is %d", app, app != nil);
        return [NSNumber numberWithBool:(app != nil)];
    }
}

+(void)killProcessWithPid:(NSNumber*)pid {
    if(pid != nil) {
        NSRunningApplication *app = [NSRunningApplication runningApplicationWithProcessIdentifier:[pid intValue]];
        [app terminate];
    }
}
@end
