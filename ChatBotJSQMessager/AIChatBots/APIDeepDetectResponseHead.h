//
//  APIDeepDetectResponseHead.h
//  DeepDetectChatBots
//
//  Created by yangboz on 29/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface APIDeepDetectResponseHead : JSONModel
@property(nonatomic) NSString *method;
@property(nonatomic) NSString *service;
@property(nonatomic) NSString *time;
@end
