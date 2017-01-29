//
//  APIDeepDetectResponseBodyPredictionClass.h
//  DeepDetectChatBots
//
//  Created by yangboz on 29/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "JSONModel.h"

@interface APIDeepDetectResponseBodyPredictionClass : JSONModel
@property (nonatomic) float prob;
@property (nonatomic) NSString *cat;
@property (nonatomic) BOOL last;
@end
