//
//  ProcessController.h
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 12/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessController : NSObject
+(NSNumber*)checkProcessWithPid:(NSNumber*)pid;
+(void)killProcessWithPid:(NSNumber*)pid;
@end
