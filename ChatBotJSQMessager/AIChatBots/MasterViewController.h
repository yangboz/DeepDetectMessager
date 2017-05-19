//
//  MasterViewController.h
//  AIChatBots
//
//  Created by yangboz on 2016/12/26.
//  Copyright © 2016年 ___SMARTKIT.INFO___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "DataModel.h"
#import "UIImageUtils.h"
//#import <linkedin-sdk/LISDK.h>
#import "Constants.h"
#import "AppDelegate.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import <CoreBluetooth/CoreBluetooth.h>


@class DetailViewController;

@interface MasterViewController : UITableViewController<CBCentralManagerDelegate, CBPeripheralDelegate>
{
    NSMutableArray *_chatbots;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (nonatomic, retain) NSMutableArray *chatbots;

@property (nonatomic, retain) NSMutableArray *listOfRatings;
@property (nonatomic, retain) NSMutableArray *groupedChatbots;

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, retain) NSMutableArray *knownPeripherals;


@end

