//
//  LaunchctlController.h
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 14/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LaunchctlController : NSObject
+(NSNumber *)isProcessRunning:(NSNumber *)pid;
@end
