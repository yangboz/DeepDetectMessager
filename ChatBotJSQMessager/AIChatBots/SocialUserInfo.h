//
//  SocialUserInfo.h
//  DeepDetectChatBots
//
//  Created by yangboz on 16/04/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SocialUserInfo : JSONModel
//LinkedIn
@property(nonatomic) NSString *firstName;
@property(nonatomic) NSString *lastName;
@property(nonatomic) NSString *pictureUrl;
//WeChat
@property(nonatomic) NSString *language;
@property(nonatomic) NSString *nickName;
@property(nonatomic) NSNumber *sex;
@property(nonatomic) NSString *country;
@property(nonatomic) NSString *province;
@property(nonatomic) NSString *city;
@property(nonatomic) NSObject *privilege;
@property(nonatomic) NSString *unionid;
@property(nonatomic) NSString *openid;
//Facebook
//@property(nonatomic) NSString *id;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *email;
@property(nonatomic) NSString *gender;
@end
