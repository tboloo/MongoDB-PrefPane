//
//  IsRunningToFontColorValueTransformer.m
//  MongoDB.prefsPane
//
//  Created by Bolesław Tekielski on 11/05/14.
//  Copyright (c) 2014 Bolesław Tekielski. All rights reserved.
//

#import "IsRunningToFontColorValueTransformer.h"

@implementation IsRunningToFontColorValueTransformer
+ (Class)transformedValueClass { return [NSColor class]; }
+ (BOOL)allowsReverseTransformation { return YES; }
- (id)transformedValue:(id)value {
	
	BOOL isWorking = [value boolValue];
    
	if(isWorking){
		return [NSColor greenColor];
	}else{
		return [NSColor redColor];
	}
	
	return nil;
}
@end
