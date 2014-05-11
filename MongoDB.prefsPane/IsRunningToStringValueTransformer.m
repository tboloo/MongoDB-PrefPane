//
//  IsRunningToStringValueTransformer.m
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 11/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import "IsRunningToStringValueTransformer.h"

@implementation IsRunningToStringValueTransformer
+ (Class)transformedValueClass { return [NSString class]; }
+ (BOOL)allowsReverseTransformation { return YES; }
- (id)transformedValue:(id)value {
	
	BOOL isWorking = [value boolValue];
    
	if(isWorking){
		return @"running";
	}else{
		return @"stopped";
	}
	
	return nil;
}
@end
