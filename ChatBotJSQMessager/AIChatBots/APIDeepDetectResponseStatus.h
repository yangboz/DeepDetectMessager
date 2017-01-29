//
//  APIDeepDetectResponseStatus.h
//  DeepDetectChatBots
//
//  Created by yangboz on 29/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface APIDeepDetectResponseStatus : JSONModel
@property(nonatomic) int code;
@property(nonatomic) NSString *msg;
@end
