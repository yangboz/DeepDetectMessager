//
//  SearchResponseImageHitsVO.m
//  DeepDetectChatBots
//
//  Created by yangboz on 26/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "SearchResponseImageHitsVO.h"

@implementation SearchResponseImageHitsVO
@synthesize hits,maxScore,totalHits;
-(NSDictionary *)keyMapping {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"hits", @"hits",
            @"maxScore", @"maxScore",
            @"totalHits", @"totalHits",
            nil];
}
+(SearchResponseImageHitsVO *)getModelFromDictionary:(NSDictionary *)dictionary {
    
    SearchResponseImageHitsVO *obj = [[SearchResponseImageHitsVO alloc] init];
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
