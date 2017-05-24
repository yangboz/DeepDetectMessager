//
//  MasterViewController.m
//  AIChatBots
//
//  Created by yangboz on 2016/12/26.
//  Copyright © 2016年 ___SMARTKIT.INFO___. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "btSimplePopUP.h"
//
#import "LinkedInHelper.h"
#import "SocialUserInfo.h"
//
#import "WxApi.h"
#import "AFHTTPRequestOperationManager.h"

#define RATINGS @"Ratings"
#define GROUP_TITLES  [NSArray arrayWithObjects: @"Human", @"Nature",@"Artifacts",@"Everyone",@"###",nil]

#define SOCIAL_TITLES  [NSArray arrayWithObjects: @"Facebook", @"LinkedIn",@"Wechat",@"Twitter",@"Instagram", @"Tumblr", @"Dribbble",@"Google+",@"Snapchat", @"Stumbleupon", @"Tumblr",@"Reddit",@"Vine", @"Yelp",@"Youtube",nil]
#define LINKEDIN_CLIENT_ID @"8101j3ul97nzwl"
#define LINKEDIN_CLIENT_SECRET @"9inLYd9rUUm6MTlJ"
#define LINKEDIN_CLIENT_STATE @"ddChatBotsLiState"
#define LINKEDIN_DIRECT_URL @"http://118.190.96.120/website/dd/"
// access_token openid refresh_token unionid
#define WX_ACCESS_TOKEN @"access_token"
#define WX_OPEN_ID @"openid"
#define WX_REFRESH_TOKEN @"refresh_token"
#define WX_UNION_ID @"unionid"
#define WX_BASE_URL @"https://api.weixin.qq.com/sns"



@interface MasterViewController ()<btSimplePopUpDelegate>
{
//    CBPeripheral *curPeripheral;
}
@property(nonatomic, retain) btSimplePopUP *popUp, *popUpWithDelegate;
@end

@implementation MasterViewController
//LIALinkedInHttpClient *SLClient_li;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    //chatbots data code
    _groupedChatbots = [self getGroupedChatBots];
    NSLog(@"_groupedChatbots:%@",_groupedChatbots);
    //SLClients
//    SLClient_li = [self getSLClient_li];
    //popup menu
    //@see: https://github.com/balram3429/btSimplePopUp
    _popUpWithDelegate = [[btSimplePopUP alloc]initWithItemImage:@[
                                                                   [UIImage imageNamed:@"Facebook.png"],
                                                                   [UIImage imageNamed:@"LinkedIn.png"],
                                                                   [UIImage imageNamed:@"Wechat.png"],
                                                                   [UIImage imageNamed:@"Twitter.png"],
                                                                   [UIImage imageNamed:@"Instagram.png"],
                                                                   [UIImage imageNamed:@"Tumblr.png"],
                                                                   [UIImage imageNamed:@"Dribbble.png"],
                                                                   [UIImage imageNamed:@"Google+.png"],
                                                                   [UIImage imageNamed:@"Snapchat.png"],
                                                                   [UIImage imageNamed:@"Stumbleupon.png"],
                                                                   [UIImage imageNamed:@"Pinterest.png"],
                                                                   [UIImage imageNamed:@"Reddit.png"],
                                                                   [UIImage imageNamed:@"Vine.png"],
                                                                   [UIImage imageNamed:@"Yelp.png"]
//                                                                   ,[UIImage imageNamed:@"Youtube.png"]
                                                                   ]
                                                       andTitles:    SOCIAL_TITLES
                          
                                                  andActionArray:nil addToViewController:self];
    _popUpWithDelegate.delegate = self;
    
    [self.view addSubview:_popUpWithDelegate];
    [_popUpWithDelegate setPopUpStyle:BTPopUpStyleDefault];
    [_popUpWithDelegate setPopUpBorderStyle:BTPopUpBorderStyleDefaultNone];
    //    [popUp setPopUpBackgroundColor:[UIColor colorWithRed:0.1 green:0.2 blue:0.6 alpha:0.7]];
    //    [_popUp show:BTPopUPAnimateNone];
    [_popUpWithDelegate show:BTPopUPAnimateNone];
    //
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.knownPeripherals = [NSMutableArray new];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)insertNewObject:(id)sender {
//    if (!self.chatbots) {
//        self.chatbots = [[NSMutableArray alloc] init];
//    }
//    [self.chatbots insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //        NSDate *object = self.chatbots[indexPath.row];
        
        //Update current selecte chat bot
        NSDictionary *dictionary = [_listOfRatings objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:RATINGS];
        ChatBotVoModel *selected = [array objectAtIndex:indexPath.row];
        //
        [[DataModel sharedInstance] setSelectedChatBot:selected];
        
        
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:selected];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        
        
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_listOfRatings count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dictionary = [_listOfRatings objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:RATINGS];
    return [array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //     if (cell == nil) {
    //         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    //     }
    //    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    //    NSLog(@"Current _chatbots:%@",_chatbots);
    //    NSLog(@"Current chatbots:%@",[self getChatBots]);
    //    if (cell == nil) {
    //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //    }
    // Configure the cell.
    NSDictionary *dictionary = [_listOfRatings objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:RATINGS];
    //    NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    int rowIndex = indexPath.row;
    //FIXME:    if(indexPath.row<0 || indexPath.row>3) rowIndex = 0;
    ChatBotVoModel *object = [array objectAtIndex:rowIndex];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",[object Name],[object numberOfClasses]];
    cell.imageView.image = [UIImage imageNamed:[object Image]];
    cell.detailTextLabel.text = [object Bio];
    //Disable
    if(object.Media & MediaOthers){
        cell.imageView.image=[cell.imageView.image imageWithRenderingMode:UIImageRenderingModeAutomatic];
        cell.imageView.image = [UIImageUtils grayishImage:cell.imageView.image];
        cell.textLabel.enabled = NO;
        cell.detailTextLabel.enabled = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
    }
    return cell;
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (NSString *) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section {
    return [GROUP_TITLES objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.chatbots removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark customize data assembly
-(NSArray *)getChatBots
{
    return [[[DataModel sharedInstance] getAllChatBots] chatbots];
}
-(NSMutableArray *)getGroupedChatBots
{
    _listOfRatings = [[NSMutableArray alloc] init];
    //Rating variables for grouping data set.
    NSMutableArray *humanRating = [[NSMutableArray alloc] init];
    NSMutableArray *natureRating = [[NSMutableArray alloc] init];
    NSMutableArray *artifactsRating = [[NSMutableArray alloc] init];
    NSMutableArray *othersRating = [[NSMutableArray alloc] init];
    //Grouping
    NSArray *listItems = [self getChatBots];
    ChatBotVoModel *object;
    for (int i=0; i<listItems.count; i++) {
        object = (ChatBotVoModel *)[listItems objectAtIndex:i];
        if ([object.Rating isEqualToString:@"A"]) {
            [artifactsRating addObject:object];
        }
        if ([object.Rating isEqualToString:@"N"]) {
            [natureRating addObject:object];
        }
        if ([object.Rating isEqualToString:@"H"]) {
            [humanRating addObject:object];
        }
        if ([object.Rating isEqualToString:@"E"]) {
            [othersRating addObject:object];
        }
    }
    //
    NSDictionary *humanRatingDict = [NSDictionary dictionaryWithObject:humanRating forKey:RATINGS];
    NSDictionary *natureRatingDict = [NSDictionary dictionaryWithObject:natureRating forKey:RATINGS];
    NSDictionary *artifactsRatingDict = [NSDictionary dictionaryWithObject:artifactsRating forKey:RATINGS];
    NSDictionary *othersRatingDict = [NSDictionary dictionaryWithObject:othersRating forKey:RATINGS];
    //
    [_listOfRatings addObject:othersRatingDict];
    [_listOfRatings addObject:humanRatingDict];
    [_listOfRatings addObject:natureRatingDict];
    [_listOfRatings addObject:artifactsRatingDict];
    
    //
    return _listOfRatings;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Update current selecte chat bot
    NSDictionary *dictionary = [_listOfRatings objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:RATINGS];
    ChatBotVoModel *selected = [array objectAtIndex:indexPath.row];
    //
    [[DataModel sharedInstance] setSelectedChatBot:selected];
}

#pragma mark popup
-(void)showAlert{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"PopItem" message:@" iAM from Block" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma -mark delegate btSimplePopUp

-(void)btSimplePopUP:(btSimplePopUP *)popUp didSelectItemAtIndex:(NSInteger)index{
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"PopItem" message:[NSString stringWithFormat:@"iAM from Delegate. My Index is %ld", (long)index] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    //    [alert show];
    if(0==index)//Facebook
    {
        [self socialFacebookAuthorize];
    }
    if(1==index)//LinkedIN
    {
        [self socialLinkedInAuthorize];
    }
    if(2==index)//WeChat
    {
        [self socialWeChatAuthorize];
    }
}
#pragma Social_Facebook
-(void)socialFacebookAuthorize{
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in,do fetch user info.
        [self fetchUserInfo];
    }else{
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                // Process error
                NSLog(@"FacebookLogin error %@",error);
            } else if (result.isCancelled) {
                // Handle cancellations
                NSLog(@"FacebookLogin Cancelled.");
            } else {
//                if ([result.grantedPermissions containsObject:@"email"]) {
                    // Do work
                    [self fetchUserInfo];
//                }
            }
        }];
    }
}

-(void)fetchUserInfo {
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"FBSDKAccessToken is available");
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name,email,first_name,last_name,gender"}]//@see:https://developers.facebook.com/docs/graph-api/reference/user
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSDictionary *userDict = (NSDictionary *)result;
                 NSLog(@"Fetched FBUser Information:%@", userDict);
                 //SocialUserInfo parse and store.
//                 NSError *error=nil;
                 SocialUserInfo *sUserInfo = [[SocialUserInfo alloc] init];
                 //http://graph.facebook.com/67563683055/picture?type=square
                 NSString *fbProfilePicUrl = [[@"http://graph.facebook.com/" stringByAppendingString:[userDict objectForKey:@"id"]] stringByAppendingString:@"/picture?type=square"];
                 [sUserInfo setPictureUrl:fbProfilePicUrl];
                 [sUserInfo setName:[userDict objectForKey:@"name"]];
                 [sUserInfo setFirstName:[userDict objectForKey:@"last_name"]];
                 [sUserInfo setLastName:[userDict objectForKey:@"first_name"]];
                 [sUserInfo setSex:[userDict objectForKey:@"gender"]];
                 [sUserInfo setEmail:[userDict objectForKey:@"email"]];
                NSLog(@"store social user Info : %@", sUserInfo);
                 //data store.
                 [[DataModel sharedInstance] setSocialUserInfo:sUserInfo];

                 //More:https://developers.facebook.com/docs/ios/graph
             }
             else {
                 NSLog(@"FbUserInfo Error %@",error);
             }
         }];
    } else {
        NSLog(@"User is not Logged in");
    }
}
#pragma Social_linkedIn
-(void)socialLinkedInAuthorize{
    LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
    
    // TODO:Logout
    [linkedIn logout];
    // If user has already connected via linkedin in and access token is still valid then
    // No need to fetch authorizationCode and then accessToken again!
    
    if (linkedIn.isValidToken) {
        
        linkedIn.customSubPermissions = [NSString stringWithFormat:@"%@,%@", first_name, last_name];
        
        // So Fetch member info by elderyly access token
        [linkedIn autoFetchUserInfoWithSuccess:^(NSDictionary *userInfo) {
            // Whole User Info
            
//            NSString * desc = [NSString stringWithFormat:@"first name : %@\n last name : %@", userInfo[@"firstName"], userInfo[@"lastName"] ];
//            [self showAlert:desc];
            
            NSLog(@"user Info : %@", userInfo);
        } failUserInfo:^(NSError *error) {
            NSLog(@"error : %@", error.userInfo.description);
        }];
    } else {
        
        linkedIn.cancelButtonText = @"Close"; // Or any other language But Default is Close
        
        NSArray *permissions = @[@(BasicProfile),
                                 @(EmailAddress),
                                 @(Share)
                                 ,@(CompanyAdmin)];
        
        linkedIn.showActivityIndicator = YES;
        
#warning - Your LinkedIn App ClientId - ClientSecret - RedirectUrl - And state
        
        [linkedIn requestMeWithSenderViewController:self
                                           clientId:LINKEDIN_CLIENT_ID
                                       clientSecret:LINKEDIN_CLIENT_SECRET
                                        redirectUrl:LINKEDIN_DIRECT_URL
                                        permissions:permissions
                                              state:LINKEDIN_CLIENT_STATE
                                    successUserInfo:^(NSDictionary *userInfo) {
                                        
//                                        self.btnLogout.hidden = !linkedIn.isValidToken;
                                        
//                                        NSString * desc = [NSString stringWithFormat:@"first name : %@\n last name : %@",
//                                                           userInfo[@"firstName"], userInfo[@"lastName"] ];
//                                        [self showAlert:desc];
                                        
                                        // Whole User Info
                                        NSLog(@"user Info : %@", userInfo);
                                        //SocialUserInfo parse and store.
                                        NSError *error=nil;
                                        SocialUserInfo *sUserInfo = [[SocialUserInfo alloc] initWithDictionary:userInfo error:&error];
                                        NSLog(@"store social user Info : %@", sUserInfo);
                                        //data store.
                                        [[DataModel sharedInstance] setSocialUserInfo:sUserInfo];
//                                        sUserInfo = [[DataModel sharedInstance] getSocialUserInfo];
//                                        NSLog(@"get social user Info : %@", sUserInfo);
                                        // You can also fetch user's those informations like below
                                        NSLog(@"job title : %@",     [LinkedInHelper sharedInstance].title);
                                        NSLog(@"company Name : %@",  [LinkedInHelper sharedInstance].companyName);
                                        NSLog(@"email address : %@", [LinkedInHelper sharedInstance].emailAddress);
                                        NSLog(@"Photo Url : %@",     [LinkedInHelper sharedInstance].photo);
                                        NSLog(@"Industry : %@",      [LinkedInHelper sharedInstance].industry);
                                    }
                                  failUserInfoBlock:^(NSError *error) {
                                      NSLog(@"error : %@", error.userInfo.description);
//                                      self.btnLogout.hidden = !linkedIn.isValidToken;
                                  }
         ];
    }
}
#pragma Social_wechat
-(void)socialWeChatAuthorize{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    // 如果已经请求过微信授权登录，那么考虑用已经得到的access_token
    if (accessToken && openID) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_REFRESH_TOKEN];
        NSString *refreshUrlStr = [NSString stringWithFormat:@"%@/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@", WX_BASE_URL, APP_ID_WX, refreshToken];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        [manager GET:refreshUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"请求reAccess的response = %@", responseObject);
            NSDictionary *refreshDict = [NSDictionary dictionaryWithDictionary:responseObject];
            NSString *reAccessToken = [refreshDict objectForKey:WX_ACCESS_TOKEN];
            // 如果reAccessToken为空,说明reAccessToken也过期了,反之则没有过期
            if (reAccessToken) {
                // 更新access_token、refresh_token、open_id
                [[NSUserDefaults standardUserDefaults] setObject:reAccessToken forKey:WX_ACCESS_TOKEN];
                [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:WX_OPEN_ID] forKey:WX_OPEN_ID];
                [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:WX_REFRESH_TOKEN] forKey:WX_REFRESH_TOKEN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                // 当存在reAccessToken不为空时直接执行AppDelegate中的wechatLoginByRequestForUserInfo方法
//                !self.requestForUserInfoBlock ? : self.requestForUserInfoBlock();
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate wechatLoginByRequestForUserInfo];
            }
            else {
                [self wechatLogin];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"用refresh_token来更新accessToken时出错 = %@", error);
        }];
    }
    else {
        [self wechatLogin];
    }
}
- (void)wechatLogin {
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"wechat_sdk_ddChatBots";
//        [WXApi sendAuthReq:req viewController:self delegate:self];
        [WXApi sendReq:req];
    }
    else {
        [self setupAlertController];
    }
}
- (void)setupAlertController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice" message:@"WeChat app did not installed" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark CoreBluetooth
- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            NSLog(@"CoreBluetooth BLE hardware is powered off");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"CoreBluetooth BLE hardware is resetting");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"CoreBluetooth BLE state is unauthorized");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"CoreBluetooth BLE state is unknown");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
            break;
        default:
            break;
    }
}
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    if(![self.knownPeripherals containsObject:_curPeripheral])
    {
        NSLog(@"didDiscoverPeripheral:%@",[peripheral debugDescription]);
        [self.knownPeripherals addObject:peripheral];
        
        if([peripheral.identifier.UUIDString isEqualToString:UUID_BT05]){//BT05 only.
            // 1 - we can stop scanning now.
            self.keepScanning = NO;
            // 2 - save a reference to the sensor tag
            _curPeripheral = peripheral;
            // 3 - set the delegate property to point to the view controller
            _curPeripheral.delegate = self;
            // 4 - Request a connection to the peripheral
            [self.centralManager connectPeripheral:_curPeripheral options:nil];
        }
    }
//    [self.centralManager retrievePeripheralsWithIdentifiers:self.knownPeripherals];
}
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    NSLog(@"Connection successfull to peripheral: %@",peripheral);
    //discoverServices().
    // 这里会触发外设的代理方法 - (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
//    [self.centralManager retrieveConnectedPeripheralsWithServices:@[peripheral.identifier]];
    [peripheral discoverServices:nil];
    //
}
- (void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"Connection didDisconnectPeripheral: %@",peripheral);
    //try again
    [self.centralManager connectPeripheral:self.curPeripheral options:nil];
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Connection failed to peripheral: %@",peripheral);
    //Do something when a connection to a peripheral failes.
}
//- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
//- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;
//- (void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;
//- (void) centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;
- (void) centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{
    NSLog(@"didRetrieveConnectedPeripherals:%@",[peripherals debugDescription]);
}
- (void) centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{
    NSLog(@"didRetrievePeripherals:%@",[peripherals debugDescription]);
}
//
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    // Core Bluetooth creates an array of CBService objects —-
    // one for each Service that is discovered on the peripheral.
    NSLog(@"didDiscoverServices:%@",[peripheral.services debugDescription]);
    for (CBService *service in peripheral.services) {
//         1.Discovering Characteristics only BT05
        if ([service.UUID isEqual:[CBUUID UUIDWithString:UUID_SERVICE_BT05]]) {
            // 2.discoverCharacteristics for a Service
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}
//
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"didDiscoverCharacteristicsForService:%@",[service debugDescription]);
    // 1
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"service.characteristics:%@",[characteristic debugDescription]);
        // 2
        uint8_t enableValue = 1;
        NSData *enableBytes = [NSData dataWithBytes:&enableValue length:sizeof(uint8_t)];
        
        // DATA_BT05
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_DATA_BT05]]) {
            // 3a
//             Enable notification
            [self.curPeripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
//
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_CONFIG_BT05]]) {
            // Write value
            [self.curPeripheral writeValue:enableBytes forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        }
        //     //这是MinibalanceV1.0的APP发送指令
        //      case 0x01: Flag_Qian = 1, Flag_Hou = 0, Flag_Left = 0, Flag_Right = 0;   break;              //前进
        //      case 0x02: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 0, Flag_Right = 1;   break;              //右转
        //      case 0x03: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 0, Flag_Right = 1;   break;              //右转
        //      case 0x04: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 0, Flag_Right = 1;   break;              //右转
        //      case 0x05:  Flag_Qian = 0, Flag_Hou = 1, Flag_Left = 0, Flag_Right = 0;   break;             //后退
        //      case 0x06: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 1, Flag_Right = 0;  break;               //左转
        //      case 0x07: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 1, Flag_Right = 0; break;                //左转
        //      case 0x08: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 1, Flag_Right = 0;   break;              //左转
        //      //这是MinibalanceV3.5的APP发送指令
        //      case 0x41: Flag_Qian = 1, Flag_Hou = 0, Flag_Left = 0, Flag_Right = 0;   break;              //前进
        //      case 0x42: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 0, Flag_Right = 1;   break;             //右转
        //      case 0x43: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 0, Flag_Right = 1;   break;             //右转
        //      case 0x44: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 0, Flag_Right = 1;   break;              //右转
        //      case 0x45:  Flag_Qian = 0, Flag_Hou = 1, Flag_Left = 0, Flag_Right = 0;   break;             //后退
        //      case 0x46: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 1, Flag_Right = 0;  break;               //左转
        //      case 0x47: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 1, Flag_Right = 0; break;               //左转
        //      case 0x48: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 1, Flag_Right = 0;   break;             //左转
        //      default: Flag_Qian = 0, Flag_Hou = 0, Flag_Left = 0, Flag_Right = 0; break;                //停止
        //
        uint16_t forwardValue = 0x01;
        NSData *forwardBytes = [NSData dataWithBytes:&forwardValue length:sizeof(uint16_t)];
        // Write value testing
        [self.curPeripheral writeValue:forwardBytes forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        //
        
    }
}
//
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@", [error localizedDescription]);
    } else {
        // 1
        // Extract the data from the Characteristic's value property
        // and display the value based on the Characteristic type
        NSData *dataBytes = characteristic.value;
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_DATA_BT05]]) {
            // 2
//            NSLog(@"dataBytes:%@",[dataBytes description]);
        }
    }
}
@end
