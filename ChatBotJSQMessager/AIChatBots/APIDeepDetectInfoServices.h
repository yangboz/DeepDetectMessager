//
//  APIDeepDetectInfoServices.h
//  DeepDetectChatBots
//
//  Created by yangboz on 18/05/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "APIDeepDetectInfoHead.h"
#import "APIDeepDetectInfoStatus.h"
#import "APIDeepDetectInfoService.h"

@protocol APIDeepDetectInfoHead
@end
@protocol APIDeepDetectInfoStatus
@end

@interface APIDeepDetectInfoServices : JSONModel
@property(nonatomic) APIDeepDetectInfoHead *head;
@property(nonatomic) APIDeepDetectInfoStatus *status;
@property(nonatomic) NSArray <APIDeepDetectInfoService *> *services;
@end
