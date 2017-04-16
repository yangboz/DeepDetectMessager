//
//  SocialUserInfo.h
//  DeepDetectChatBots
//
//  Created by yangboz on 16/04/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SocialUserInfo : JSONModel
@property(nonatomic) NSString *firstName;
@property(nonatomic) NSString *lastName;
@property(nonatomic) NSString *pictureUrl;
@end
