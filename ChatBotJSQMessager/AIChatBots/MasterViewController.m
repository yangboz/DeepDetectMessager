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
    return YES;
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
    if(1==index)//LinkedIN
    {
        [self socialLinkedInAuthorize];
    }
    if(2==index)//WeChat
    {
        [self socialWeChatAuthorize];
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
//        [WXApi sendAuthReq:req viewController:<#(UIViewController *)#> delegate:<#(id<WXApiDelegate>)#>]
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
@end
