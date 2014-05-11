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
    
	if(isWorking){
        return [NSImage imageNamed:@"instance_started.tiff"];
    } else {
		return [NSImage imageNamed:@"instance_stopped.tiff"];
	}
	
	return nil;
}

@end
