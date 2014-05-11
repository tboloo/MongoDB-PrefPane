//
//  MongodController.m
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 10/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import "MongodController.h"


@implementation MongodController
@synthesize isRunning, useSyslog, enableHTTPInterface, mongodPath = _mongodPath, dbPath = _dbPath, port = _port, mongodTask;

-(id)init {
    self = [super init];
    if (self) {
        NSNumber *p = [[NSUserDefaults standardUserDefaults] valueForKey:@"port"];
        if (p != nil) {
            self.port = p;
        } else {
            self.port = [NSNumber numberWithInt:27017];
        }
        
        NSString *m = [[NSUserDefaults standardUserDefaults] valueForKey:@"mongodPath"];
        if (m != nil) {
            self.mongodPath = [NSURL URLWithString:m];
        } else {
            self.mongodPath = [[[NSFileManager defaultManager] URLsForDirectory: NSApplicationDirectory inDomains:NSLocalDomainMask] lastObject];
        }
        
        NSString *d = [[NSUserDefaults standardUserDefaults] valueForKey:@"dbPath"];
        if (_mongodPath != nil) {
            self.dbPath = [NSURL URLWithString:d];
        } else {
            self.dbPath = [[[NSFileManager defaultManager] URLsForDirectory: NSApplicationDirectory inDomains:NSLocalDomainMask] lastObject];

        }
        
        self.isRunning = [NSNumber numberWithBool:NO];
        self.useSyslog = [NSNumber numberWithBool:NO];
        self.enableHTTPInterface = [NSNumber numberWithBool:YES];
        //self.mongodTask = [[NSTask alloc] init];
    }
    return self;
}

-(void)setPort:(NSNumber *)port {
    _port = port;
    [[NSUserDefaults standardUserDefaults] setObject:_port forKey:@"port"];
}

-(void)setMongodPath:(NSURL *)mongodPath {
    _mongodPath = mongodPath;
    [[NSUserDefaults standardUserDefaults] setObject:[_mongodPath path] forKey:@"mongodPath"];
}

-(void)setDbPath:(NSURL *)dbPath {
    _dbPath = dbPath;
    [[NSUserDefaults standardUserDefaults] setObject:[_dbPath path] forKey:@"dbPath"];
}

- (IBAction)showPathOpenPanel:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanChooseDirectories:NO];
    [panel setCanChooseFiles:YES];
    [panel setResolvesAliases:YES];
    [panel setAllowedFileTypes:@[@""]];
    
    NSString *panelTitle = @"Path to mongod executable";
    [panel setTitle:panelTitle];
    
    NSString *promptString = @"Select";
    [panel setPrompt:promptString];
    
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            
            for (NSURL *fileURL in [panel URLs]) {
                self.mongodPath = fileURL;
            }
        }
    }];

}

- (IBAction)showDbPathPanel:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:NO];
    [panel setResolvesAliases:YES];
    
    NSString *panelTitle = @"Path to database directory";
    [panel setTitle:panelTitle];
    
    NSString *promptString = @"Select";
    [panel setPrompt:promptString];
    
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            
            for (NSURL *fileURL in [panel URLs]) {
                self.dbPath = fileURL;
            }
        }
    }];
    
}

- (IBAction)startStopMongod:(id)sender {
    BOOL _isRunning = [self.isRunning boolValue];
    _isRunning ^= YES;
    self.isRunning = [NSNumber numberWithBool:_isRunning];
}

@end
