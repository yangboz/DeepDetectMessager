//
//  APIDeepDetectResponseBodyPredictionClass.m
//  DeepDetectChatBots
//
//  Created by yangboz on 29/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "APIDeepDetectResponseBodyPredictionClass.h"

@implementation APIDeepDetectResponseBodyPredictionClass
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ([propertyName isEqualToString: @"last"]) return YES;
    return NO;
}
@end
