//
//  IsRunningToButtonCaptionValueTransformer.m
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 11/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import "IsRunningToButtonCaptionValueTransformer.h"

@implementation IsRunningToButtonCaptionValueTransformer
+ (Class)transformedValueClass { return [NSString class]; }
+ (BOOL)allowsReverseTransformation { return YES; }
- (id)transformedValue:(id)value {
	
	BOOL isWorking = [value boolValue];
    
	if(isWorking){
		return @"Stop";
	}else{
		return @"Start";
	}
	
	return nil;
}
@end
