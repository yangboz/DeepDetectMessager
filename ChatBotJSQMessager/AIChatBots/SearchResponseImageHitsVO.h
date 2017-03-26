//
//  SearchResponseImageHitsVO.h
//  DeepDetectChatBots
//
//  Created by yangboz on 26/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResponseImageHitVO.h"

@interface SearchResponseImageHitsVO : NSObject
@property(nonatomic) float totalHits;
@property(nonatomic) float maxScore;
@property(nonatomic,strong) NSMutableArray<SearchResponseImageHitVO*> *hits;
-(NSDictionary *)keyMapping;
+(SearchResponseImageHitsVO *)getModelFromDictionary:(NSDictionary *)dictionary;
@end
