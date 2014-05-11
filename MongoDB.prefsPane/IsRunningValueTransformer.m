//
//  IsRunningValueTransformer.m
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 11/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import "IsRunningValueTransformer.h"

@implementation IsRunningValueTransformer

+ (Class)transformedValueClass { return [NSNumber class]; }
+ (BOOL)allowsReverseTransformation { return YES; }
- (id)transformedValue:(id)value {
	
	BOOL _isWorking = [value boolValue];
    
	if(_isWorking){
		return [NSNumber numberWithBool:NO];
	}else{
		return [NSNumber numberWithBool:YES];
	}
	
	return nil;
}


@end
