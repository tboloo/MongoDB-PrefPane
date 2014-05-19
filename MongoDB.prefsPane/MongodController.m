//
//  MongodController.m
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 10/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import "MongodController.h"
#import "LaunchctlController.h"

@implementation MongodController
@synthesize isRunning, useSyslog = _useSyslog, enableHTTPInterface = _enableHTTPInterface, mongodPath = _mongodPath, dbPath = _dbPath, port = _port, mongodTask, pid, lastChecked;

-(id)init {
    self = [super init];
    if (self) {
        self.isRunning = @(NO);

        NSNumber *p = [[NSUserDefaults standardUserDefaults] valueForKey:@"port"];
        if (p != nil) {
            self.port = p;
        } else {
            self.port = @(27017);
        }
        
        NSString *m = [[NSUserDefaults standardUserDefaults] valueForKey:@"mongodPath"];
        if (m != nil) {
            self.mongodPath = [NSURL URLWithString:m];
        } else {
            self.mongodPath = [[[NSFileManager defaultManager] URLsForDirectory: NSApplicationDirectory inDomains:NSLocalDomainMask] lastObject];
        }
        
        NSString *d = [[NSUserDefaults standardUserDefaults] valueForKey:@"dbPath"];
        if (d != nil) {
            self.dbPath = [NSURL URLWithString:d];
        } else {
            self.dbPath = [[[NSFileManager defaultManager] URLsForDirectory: NSApplicationDirectory inDomains:NSLocalDomainMask] lastObject];

        }
        
        NSNumber *s = [[NSUserDefaults standardUserDefaults] valueForKey:@"useSyslog"];
        if (s != nil) {
            self.useSyslog = s;
        } else {
            self.useSyslog = @(NO);
        }

        NSNumber *h = [[NSUserDefaults standardUserDefaults] valueForKey:@"enableHTTPInteface"];
        if (h != nil) {
            self.enableHTTPInterface = h;
        } else {
            self.enableHTTPInterface = @(YES);
        }
        self.pid = [[NSUserDefaults standardUserDefaults] valueForKey:@"pid"];
        self.isRunning = [LaunchctlController isProcessRunning:self.pid];
        
        NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"dd/MM/yyyy" options:0                                                               locale:[NSLocale currentLocale]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatString];
        NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:421882210];
        self.lastChecked = [dateFormatter stringFromDate:date];
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
    self.mongodTask.launchPath = [mongodPath path];
}

-(void)setDbPath:(NSURL *)dbPath {
    _dbPath = dbPath;
    [[NSUserDefaults standardUserDefaults] setObject:[_dbPath path] forKey:@"dbPath"];
}

-(void)setUseSyslog:(NSNumber *)useSyslog {
    _useSyslog = useSyslog;
    [[NSUserDefaults standardUserDefaults] setObject:_useSyslog forKey:@"useSyslog"];
}

-(void)setEnableHTTPInterface:(NSNumber *)enableHTTPInterface {
    _enableHTTPInterface = enableHTTPInterface;
    [[NSUserDefaults standardUserDefaults] setObject:_enableHTTPInterface forKey:@"enableHTTPInteface"];
}

-(NSString*)version {
    NSDictionary* infoDict = [[NSBundle bundleForClass:[self class]] infoDictionary];
    return [infoDict objectForKey:@"CFBundleVersion"];
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
    if ([self.isRunning boolValue] == NO) {
        self.mongodTask = [[NSTask alloc] init];
        self.mongodTask.launchPath = [self.mongodPath path];
        NSMutableArray *arguments = [NSMutableArray new];
        [arguments addObject:@"--dbpath"];
        [arguments addObject:[self.dbPath path]];
        [arguments addObject:@"--port"];
        [arguments addObject:[self.port stringValue]];
//        if ([self.enableHTTPInterface boolValue] == YES) {
//            [arguments addObject:@"--httpinterface"];
//        }
        if ([self.useSyslog boolValue] == YES) {
            [arguments addObject:@"--syslog"];
        }
        self.mongodTask.arguments = arguments;
        [self.mongodTask launch];
        self.pid = @(self.mongodTask.processIdentifier);
        [[NSUserDefaults standardUserDefaults] setObject:self.pid forKey:@"pid"];
        self.isRunning = [LaunchctlController isProcessRunning:self.pid];
    } else {
        [LaunchctlController killProcess:self.pid];
        self.mongodTask = nil;
        self.isRunning = @(NO);
    }
}

@end
