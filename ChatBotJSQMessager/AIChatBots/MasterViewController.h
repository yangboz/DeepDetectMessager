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
// Blance Vehicle05 UUIDs
#define UUID_SERVICE_BT05 @"FFE0"
#define UUID_DATA_BT05    @"FFE1"
#define UUID_CONFIG_BT05  @"F000AA02-0451-4000-B000-000000000000"
//#define DNAME_BT05 @"F000AA00-0451-4000-B000-000000000000"
#define UUID_BT05 @"9E745F45-6483-4836-95B5-71B6149DFC2B"


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
@property (strong,nonatomic) CBPeripheral *curPeripheral;
@property (strong,nonatomic) NSMutableArray *knownPeripherals;
@property (nonatomic) BOOL keepScanning;


@end

