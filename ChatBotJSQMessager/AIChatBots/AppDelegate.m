//
//  AppDelegate.m
//  AIChatBots
//
//  Created by yangboz on 2016/12/26.
//  Copyright © 2016年 ___SMARTKIT.INFO___. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "AllChatBotsModel.h"
#import "DataModel.h"
#import "MasterViewController.h"
#import "AFHTTPRequestOperationManager.h"
// access_token openid refresh_token unionid
#define WX_ACCESS_TOKEN @"access_token"
#define WX_OPEN_ID @"openid"
#define WX_REFRESH_TOKEN @"refresh_token"
#define WX_UNION_ID @"unionid"
#define WX_BASE_URL @"https://api.weixin.qq.com/sns"

@interface AppDelegate () <UISplitViewControllerDelegate>{
MasterViewController *masterViewController;
}
@end

@implementation AppDelegate

- (id)init{
    if(self = [super init]){
        _scene = WXSceneSession;
    }
    return self;
}


-(void)setMasterControllerData:(NSMutableArray *)data
{
    masterViewController.chatbots = data;
    NSLog(@"masterViewController.chatbots %@",data);
}

//#pragma mark ibeacon delegate
//- (void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
//{
//    NSLog(@"did start monitoring");
//    [self.locationManager requestStateForRegion:self.beaconRegion];
//}
//
//-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
//{
//    if (state == CLRegionStateInside)
//    {
//        //Start Ranging
//        NSLog(@"inside, start ranging");
//        [manager startRangingBeaconsInRegion:self.beaconRegion];
//    }
//    else
//    {
//        NSLog(@"outside, stop ranging");
//        //Stop Ranging here
//    }
//}
//
//-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
//    [manager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
//    [self.locationManager startUpdatingLocation];
//    
//    NSLog(@"You entered the region.");
//    [self sendLocalNotificationWithMessage:@"You entered the region."];
//}
//
//-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
//    [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
//    [self.locationManager stopUpdatingLocation];
//    
//    NSLog(@"You exited the region.");
//    [self sendLocalNotificationWithMessage:@"You exited the region."];
//}
//
//-(void)sendLocalNotificationWithMessage:(NSString*)message {
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    notification.alertBody = message;
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//}
//
//-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
//    NSString *message = @"";
//    
//    IMViewController *viewController = (IMViewController*)self.window.rootViewController;
//    viewController.beacons = beacons;
//    [viewController.tableView reloadData];
//    
//    if(beacons.count > 0) {
//        CLBeacon *nearestBeacon = beacons.firstObject;
//        if(nearestBeacon.proximity == self.lastProximity ||
//           nearestBeacon.proximity == CLProximityUnknown) {
//            return;
//        }
//        self.lastProximity = nearestBeacon.proximity;
//        
//        switch(nearestBeacon.proximity) {
//            case CLProximityFar:
//                message = @"You are far away from the beacon";
//                break;
//            case CLProximityNear:
//                message = @"You are near the beacon";
//                break;
//            case CLProximityImmediate:
//                message = @"You are in the immediate proximity of the beacon";
//                break;
//            case CLProximityUnknown:
//                return;
//        }
//    } else {
//        message = @"No beacons are nearby";
//    }
//    
//    NSLog(@"%@", message);
//    [self sendLocalNotificationWithMessage:message];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //
//    NSUUID *beaconUUID = [[NSUUID alloc] initWithUUIDString:@"9B2D1BB8-25AA-8EE5-2513-7C140B6B1801"];
//    NSString *regionIdentifier = @"MiniBeacon_04193";
//    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:beaconUUID
//                                                                           major:0 minor:0 identifier:regionIdentifier];
//    self.beaconRegion = beaconRegion;
//    self.beaconRegion.notifyOnEntry=YES;
//    self.beaconRegion.notifyOnExit=YES;
//    self.beaconRegion.notifyEntryStateOnDisplay=YES;
//    
//    switch ([CLLocationManager authorizationStatus]) {
//        case kCLAuthorizationStatusAuthorizedAlways:
//            NSLog(@"Authorized Always");
//            break;
//        case kCLAuthorizationStatusAuthorizedWhenInUse:
//            NSLog(@"Authorized when in use");
//            break;
//        case kCLAuthorizationStatusDenied:
//            NSLog(@"Denied");
//            break;
//        case kCLAuthorizationStatusNotDetermined:
//            NSLog(@"Not determined");
//            break;
//        case kCLAuthorizationStatusRestricted:
//            NSLog(@"Restricted");
//            break;
//            
//        default:
//            break;
//    }
//    self.locationManager = [[CLLocationManager alloc] init];
//    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//        [self.locationManager requestAlwaysAuthorization];
//    }
//    self.locationManager.delegate = self;
//    self.locationManager.pausesLocationUpdatesAutomatically = NO;
//    [self.locationManager startMonitoringForRegion:beaconRegion];
    
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    //SocialLoginClients register
    [WXApi registerApp:APP_ID_WX enableMTA:YES];
    //API json data initialization
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chatbots" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    AllChatBotsModel *allChatBotsModel = [[AllChatBotsModel alloc] initWithData:jsonData error:&error];
    // 4) Dump the contents of the person object
    // to thedebug console.
    NSLog(@"AllChatBotsVO => %@\n", allChatBotsModel);
    NSLog(@"AllChatBotsVO.chatbots: %@\n",[allChatBotsModel chatbots]);
    NSLog(@"AllChatBotsVO.chatbots[0]: %@\n", [[allChatBotsModel chatbots] objectAtIndex:0]);
    // 5) Model store
    [[DataModel sharedInstance] setAllChatBots:allChatBotsModel];
    
    // 6) Set delegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithArray:
                              [allChatBotsModel chatbots] ];
    //
    [appDelegate setMasterControllerData:mArray];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return  isSuc;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    if ([LISDKCallbackHandler shouldHandleUrl:url]) {
//        NSLog(@"LISDKCallbackHandler...");
//        return [LISDKCallbackHandler application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
//    }
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return YES;
}
#pragma mark WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    // 向微信请求授权后,得到响应结果
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp = (SendAuthResp *)resp;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *accessUrlStr = [NSString stringWithFormat:@"%@/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_BASE_URL, APP_ID_WX, APP_SECRET_WX, temp.code];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        [manager GET:accessUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"请求access的response = %@", responseObject);
            NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:responseObject];
            NSString *accessToken = [accessDict objectForKey:WX_ACCESS_TOKEN];
            NSString *openID = [accessDict objectForKey:WX_OPEN_ID];
            NSString *refreshToken = [accessDict objectForKey:WX_REFRESH_TOKEN];
            // 本地持久化，以便access_token的使用、刷新或者持续
            if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
                [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:WX_ACCESS_TOKEN];
                [[NSUserDefaults standardUserDefaults] setObject:openID forKey:WX_OPEN_ID];
                [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:WX_REFRESH_TOKEN];
                [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
            }
            [self wechatLoginByRequestForUserInfo];
                //
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"获取access_token时出错 = %@", error);
        }];
    }
}
- (void)wechatLoginByRequestForUserInfo {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    NSString *userUrlStr = [NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken, openID];
    // 请求用户数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:userUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求用户信息的response = %@", responseObject);
        //
        NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
//        NSError *error=nil;
        SocialUserInfo *sUserInfo = [[SocialUserInfo alloc] init];
        [sUserInfo setPictureUrl:[userDict objectForKey:@"headimgurl"]];
         [sUserInfo setLanguage:[userDict objectForKey:@"language"]];
         [sUserInfo setCity:[userDict objectForKey:@"city"]];
         [sUserInfo setCountry:[userDict objectForKey:@"country"]];
         [sUserInfo setNickName:[userDict objectForKey:@"nicName"]];
         [sUserInfo setOpenid:[userDict objectForKey:@"openid"]];
        [sUserInfo setPrivilege:[userDict objectForKey:@"privilege"]];
        [sUserInfo setProvince:[userDict objectForKey:@"province"]];
        [sUserInfo setSex:[userDict objectForKey:@"sex"]];
        [sUserInfo setUnionid:[userDict objectForKey:@"unionid"]];
        NSLog(@"store social user Info : %@", sUserInfo);
        //data store.
        [[DataModel sharedInstance] setSocialUserInfo:sUserInfo];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取用户信息时出错 = %@", error);
    }];
}
@end
