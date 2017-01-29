//
//  APIDeepDetectParameters.h
//  DeepDetectChatBots
//
//  Created by yangboz on 29/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "APIDeepDetectParametersInput.h"
#import "APIDeepDetectParametersOutput.h"
#import "APIDeepDetectParametersMLlib.h"

@protocol APIDeepDetectParametersInput
@end
@protocol APIDeepDetectParametersOutput
@end
@protocol APIDeepDetectParametersMLlib
@end

@interface APIDeepDetectParameters : JSONModel
@property(nonatomic) APIDeepDetectParametersInput *input;
@property(nonatomic) APIDeepDetectParametersOutput *output;
@property(nonatomic) APIDeepDetectParametersMLlib *mllib;
@end
