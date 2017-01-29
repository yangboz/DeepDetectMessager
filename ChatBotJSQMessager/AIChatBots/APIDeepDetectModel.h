//
//  APIDeepDetectModel.h
//  DeepDetectChatBots
//
//  Created by yangboz on 29/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "APIDeepDetectParameters.h"

@protocol APIDeepDetectParameters
@end
@protocol APIDeepDetectMLlib
@end


@interface APIDeepDetectModel : JSONModel
@property(nonatomic) NSString *service;
@property(nonatomic) APIDeepDetectParameters *parameters;
@property(nonatomic) NSArray <NSString *> *data;
@end
