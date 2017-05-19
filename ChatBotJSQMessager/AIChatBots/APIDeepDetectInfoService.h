//
//  APIDeepDetectInfoService.h
//  DeepDetectChatBots
//
//  Created by yangboz on 17/05/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface APIDeepDetectInfoService : JSONModel
@property(nonatomic) NSString *mllib;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *description;
@end
