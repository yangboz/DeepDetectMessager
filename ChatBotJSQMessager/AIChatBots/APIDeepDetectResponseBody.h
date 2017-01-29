//
//  APIDeepDetectResponseBody.h
//  DeepDetectChatBots
//
//  Created by yangboz on 29/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "APIDeepDetectResponseBodyPrediction.h"

@interface APIDeepDetectResponseBody : JSONModel
@property(nonatomic) NSArray <APIDeepDetectResponseBodyPrediction *> *predictions;
@end
