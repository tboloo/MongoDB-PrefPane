//
//  MongodController.h
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 10/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MongodController : NSObject {
    
}

@property (nonatomic) BOOL isRunning;
@property (nonatomic, ) NSString *mongodPath;
@property NSString *dbPath;
@property NSNumber *port;

@end
