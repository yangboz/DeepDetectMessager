//
//  SearchResponseVO.h
//  DeepDetectChatBots
//
//  Created by yangboz on 25/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResponseImageHitsVO.h"

@interface SearchResponseVO : NSObject
@property(nonatomic) NSNumber* took;
@property(nonatomic) BOOL timeout;
@property(nonatomic) NSObject* _shards;
@property(nonatomic) NSDictionary* hits;
-(NSDictionary *)keyMapping;
+(SearchResponseVO *)getModelFromDictionary:(NSDictionary *)dictionary;
@end
