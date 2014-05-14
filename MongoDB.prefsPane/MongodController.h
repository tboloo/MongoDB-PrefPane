//
//  MongodController.h
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 10/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PreferencePanes/PreferencePanes.h>

@interface MongodController : NSObject

@property (nonatomic, copy) NSNumber *isRunning;
@property (nonatomic, copy) NSNumber *useSyslog;
@property (nonatomic, copy) NSNumber *enableHTTPInterface;
@property (nonatomic, copy) NSNumber *port;
@property (nonatomic, copy) NSURL *mongodPath;
@property (nonatomic, copy) NSURL *dbPath;
@property (nonatomic, strong) NSTask *mongodTask;
@property (nonatomic, copy) NSNumber *pid;
@property (nonatomic, readonly) NSString *version;
@end
