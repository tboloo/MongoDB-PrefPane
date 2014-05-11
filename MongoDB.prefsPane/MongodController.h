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

@property (nonatomic, copy) NSNumber *isRunning;
@property (nonatomic, copy) NSString *mongodPath;
@property (nonatomic, copy) NSString *dbPath;
@property (nonatomic, copy) NSNumber *port;

@end
