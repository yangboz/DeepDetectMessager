//
//  SearchResponseImageHitVO.m
//  DeepDetectChatBots
//
//  Created by yangboz on 26/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "SearchResponseImageHitVO.h"

@implementation SearchResponseImageHitVO
@synthesize id,type,index,score,source;
-(NSDictionary *)keyMapping {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"id", @"id",
            @"type", @"type",
            @"index", @"index",
            @"score", @"score",
            @"source", @"source",
            nil];
}
+(SearchResponseImageHitVO *)getModelFromDictionary:(NSDictionary *)dictionary {
    
    SearchResponseImageHitVO *obj = [[SearchResponseImageHitVO alloc] init];
    NSDictionary *mapping = [obj keyMapping];
    
    for (NSString *attribute in [mapping allKeys]){
        
        NSString *classProperty = [mapping objectForKey:attribute];
        NSString *attributeValue = [dictionary objectForKey:attribute];
        
        if (attributeValue!=nil&&!([attributeValue isKindOfClass:[NSNull class]])) {
            
            [obj setValue:attributeValue forKeyPath:classProperty];
        }
    }
    
    return obj;
    
}

@end
