//
//  MasterViewController.m
//  AIChatBots
//
//  Created by yangboz on 2016/12/26.
//  Copyright © 2016年 ___SMARTKIT.INFO___. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"


#define RATINGS @"Ratings"

@interface MasterViewController ()

@end

@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    //Test code
    _groupedChatbots = [self getGroupedChatBots];
    NSLog(@"_groupedChatbots:%@",_groupedChatbots);

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
        NSDate *object = self.chatbots[indexPath.row];
        
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
    NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    int rowIndex = indexPath.row;
    //FIXME:    if(indexPath.row<0 || indexPath.row>3) rowIndex = 0;
    ChatBotVoModel *object = [array objectAtIndex:rowIndex];
    
    cell.textLabel.text = [object Name];
    cell.imageView.image = [UIImage imageNamed:[object Image]];
    cell.detailTextLabel.text = [object Bio];
    
    return cell;

}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (NSString *) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0)
    {
        return @"Human";
    }
    if (section == 1)
    {
        return @"Nature";
    }
    if (section == 2)
    {
        return @"Artifacts";
    }
    if (section == 3)
    {
        return @"Others";
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
        if ([object.Rating isEqualToString:@"O"]) {
            [othersRating addObject:object];
        }
    }
    //
    NSDictionary *humanRatingDict = [NSDictionary dictionaryWithObject:humanRating forKey:RATINGS];
    NSDictionary *natureRatingDict = [NSDictionary dictionaryWithObject:natureRating forKey:RATINGS];
    NSDictionary *artifactsRatingDict = [NSDictionary dictionaryWithObject:artifactsRating forKey:RATINGS];
     NSDictionary *othersRatingDict = [NSDictionary dictionaryWithObject:othersRating forKey:RATINGS];
    //
    [_listOfRatings addObject:humanRatingDict];
    [_listOfRatings addObject:natureRatingDict];
    [_listOfRatings addObject:artifactsRatingDict];
    [_listOfRatings addObject:othersRatingDict];
    
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
@end
