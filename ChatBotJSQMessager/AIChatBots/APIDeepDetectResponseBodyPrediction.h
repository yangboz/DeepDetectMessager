//
//  APIDeepDetectResponseBodyPrediction.h
//  DeepDetectChatBots
//
//  Created by yangboz on 29/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "APIDeepDetectResponseBodyPredictionClass.h"

@interface APIDeepDetectResponseBodyPrediction : JSONModel
@property(nonatomic) NSString *uri;
@property(nonatomic) NSArray <APIDeepDetectResponseBodyPredictionClass *> *classes;
@end
