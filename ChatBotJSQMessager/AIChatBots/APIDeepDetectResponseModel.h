//
//  APIDeepDetectResponseModel.h
//  DeepDetectChatBots
//
//  Created by yangboz on 29/01/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "APIDeepDetectResponseHead.h"
#import "APIDeepDetectResponseBody.h"
#import "APIDeepDetectResponseStatus.h"

@protocol APIDeepDetectResponseStatus
@end
@protocol APIDeepDetectResponseHead
@end
@protocol APIDeepDetectResponseBody
@end

@interface APIDeepDetectResponseModel : JSONModel
@property(nonatomic) APIDeepDetectResponseStatus *status;
@property(nonatomic) APIDeepDetectResponseHead *head;
@property(nonatomic) APIDeepDetectResponseBody *body;
@end
