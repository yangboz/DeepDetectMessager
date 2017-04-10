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


#define RATINGS @"Ratings"

@interface MasterViewController ()<btSimplePopUpDelegate>
@property(nonatomic, retain) btSimplePopUP *popUp, *popUpWithDelegate;
@end

@implementation MasterViewController


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
    //popup menu
    //@see: https://github.com/balram3429/btSimplePopUp
    _popUpWithDelegate = [[btSimplePopUP alloc]initWithItemImage:@[
                                                                   [UIImage imageNamed:@"Facebook.png"],
                                                                   [UIImage imageNamed:@"Linkedin.png"],
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
                                                                   [UIImage imageNamed:@"Yelp.png"],
//                                                                   [UIImage imageNamed:@"Youtube.png"]
                                                                   ]
                                                       andTitles:    @[
                                                                       @"Facebook", @"LinkedIn",@"Twitter", @"Instagram", @"Tumblr", @"Dribbble",
                                                                       @"Google+",@"Snapchat", @"Stumbleupon", @"Tumblr",
                                                                       @"Reddit",@"Vine", @"Yelp", @"Youtube"
                                                                       ]
                          
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
    
    if (section == 1)
    {
        return @"Human";
    }
    if (section == 2)
    {
        return @"Nature";
    }
    if (section == 3)
    {
        return @"Artifacts";
    }
    if (section == 0)
    {
        return @"Everyone";
    }
    return @"###";
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
}
@end
