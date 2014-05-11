//
//  MongodController.m
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 10/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import "MongodController.h"


@implementation MongodController
@synthesize isRunning, mongodPath, dbPath, port;

-(id)init {
    self = [super init];
    if (self) {
        self.port = [NSNumber numberWithInt:27017];
        self.isRunning = [NSNumber numberWithBool:NO];
    }
    return self;
}
@end
