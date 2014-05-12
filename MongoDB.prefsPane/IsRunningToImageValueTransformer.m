//
//  IsRunningToImageValueTransformer.m
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 11/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import "IsRunningToImageValueTransformer.h"

@implementation IsRunningToImageValueTransformer
+ (Class)transformedValueClass { return [NSImage class]; }
+ (BOOL)allowsReverseTransformation { return YES; }
- (id)transformedValue:(id)value {
	
	BOOL isWorking = [value boolValue];
    NSString *startedPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"instance_started" ofType:@"tiff"];
    NSString *stoppedPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"instance_stopped" ofType:@"tiff"];
	if(isWorking){
        return [[NSImage alloc] initWithContentsOfFile:startedPath];
    } else {
		return [[NSImage alloc] initWithContentsOfFile:stoppedPath];
	}
	
	return nil;
}

@end
