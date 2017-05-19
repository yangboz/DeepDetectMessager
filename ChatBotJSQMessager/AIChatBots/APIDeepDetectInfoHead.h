//
//  APIDeepDetectInfoHead.h
//  DeepDetectChatBots
//
//  Created by yangboz on 17/05/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface APIDeepDetectInfoHead : JSONModel
@property(nonatomic) NSString *method;
@property(nonatomic) NSString *version;
@property(nonatomic) NSString *branch;
@property(nonatomic) NSString *commit;
@end
