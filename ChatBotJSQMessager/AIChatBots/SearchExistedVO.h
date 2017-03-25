//
//  SearchExistedVO.h
//  DeepDetectChatBots
//
//  Created by yangboz on 24/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchExistedQueryVO.h"

@interface SearchExistedVO : NSObject
@property(nonatomic) NSNumber* from;
@property(nonatomic) NSNumber* size;
@property(nonatomic,strong)SearchExistedQueryVO *query;

@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *item;
@property (nonatomic, strong) NSString *esId;
@end
