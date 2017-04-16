//
//  AppDelegate.h
//  AIChatBots
//
//  Created by yangboz on 2016/12/26.
//  Copyright © 2016年 ___SMARTKIT.INFO___. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <linkedin-sdk/LISDK.h>
#import "WxApi.h"
#import "Constants.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    enum WXScene _scene;
}

@property (strong, nonatomic) UIWindow *window;

-(void)setMasterControllerData:(NSMutableArray *)data;

@end

