//
//  SearchResponseImageHitVO.h
//  DeepDetectChatBots
//
//  Created by yangboz on 26/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResponseImageHitVO : NSObject
@property(nonatomic,strong) NSString* index;
@property(nonatomic,strong) NSString* type;
@property(nonatomic,strong) NSString* id;
@property(nonatomic) NSNumber* score;
@property(nonatomic,strong) NSObject* source;
-(NSDictionary *)keyMapping;
+(SearchResponseImageHitVO *)getModelFromDictionary:(NSDictionary *)dictionary;
@end
