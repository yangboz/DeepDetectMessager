//
//  DataModel.h
//  TGCameraViewController
//
//  Created by yangboz on 2016/12/1.
//  Copyright © 2016年 Tudo Gostoso Internet. All rights reserved.
//

#ifndef DataModel_h
#define DataModel_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AllChatBotsModel.h"
#import "SqootDeal.h"
#import "SocialUserInfo.h"

@interface DataModel : NSObject
{
    
}

+(DataModel *)sharedInstance;
//Set/Gets
-(void)setAllChatBots:(AllChatBotsModel *)value;
-(AllChatBotsModel *)getAllChatBots;
//Current selected chat bot
-(ChatBotVoModel *)getSelectedChatBot;
-(void)setSelectedChatBot:(ChatBotVoModel *)value;

-(NSArray *)getSelectedSqootDeals;
-(void)setSelectedSqootDeals:(NSArray *)value;
//
-(SocialUserInfo *)getSocialUserInfo;
-(void)setSocialUserInfo:(SocialUserInfo *)value;
@end



#endif /* DataModel_h */
