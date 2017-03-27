//
//  CVC_Seque_Similarity.m
//  DeepDetectChatBots
//
//  Created by yangboz on 26/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "CVC_Seque_Similarity.h"

@interface CVC_Seque_Similarity ()

@end

@implementation CVC_Seque_Similarity

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    UINib *cellNib = [UINib nibWithNibName:@"CVCSequeSimilarityCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    
    // Do any additional setup after loading the view.
    SearchResponseImageHitsVO *imageHitsVo = [COVIASv1Model sharedInstance].imageHitsVo;
    self.dataArray = [[NSArray alloc] initWithObjects:imageHitsVo.hits, nil];
    //Layout example, @see: http://demo-itec.uni-klu.ac.at/liredemo/
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(200, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    //
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refershControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView setBounces:YES];
    [self.collectionView setAlwaysBounceVertical:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//warning Incomplete implementation, return the number of sections
    return [self.dataArray count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//warning Incomplete implementation, return the number of items
    NSMutableArray *sectionArray = [self.dataArray objectAtIndex:section];
    return [sectionArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    
    NSDictionary *cellDataDict = [data objectAtIndex:indexPath.row];
    SearchResponseImageHitVO *cellDataVo = [SearchResponseImageHitVO getModelFromDictionary:cellDataDict];
    
    static NSString *cellIdentifier = @"cvCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
    UITextView *descTextV = (UITextView *)[cell viewWithTag:102];
    UIWebView *aUIWebView = (UIWebView *)[cell viewWithTag:103];
    
    [titleLabel setText:cellDataVo.id];
    NSDictionary *sourceDict = (NSDictionary *)cellDataVo.source;
    NSString *my_img = [sourceDict objectForKey:@"my_img"];
    NSString *base64String = [@"data:image/gif;base64," stringByAppendingString:my_img];
        //FIXME:@see:http://stackoverflow.com/questions/1366837/how-to-display-a-base64-image-within-a-uiimageview
//    NSURL *url = [NSURL URLWithString:base64String];
//    NSData *imageData = [NSData dataWithContentsOfURL:url];
//    imageView.image = [UIImage imageWithData:imageData];
    
    aUIWebView.scalesPageToFit = YES;
    aUIWebView.opaque = NO;
    aUIWebView.backgroundColor = [UIColor clearColor];
    NSString *htmlString = [NSString stringWithFormat:@"%@%@%@",@"<html><body style=‘width:64px;height:64px' background-color: transparent""><img src='",base64String,@"' /></body></html>"""];
    [aUIWebView loadHTMLString:htmlString baseURL:nil];
    
    descTextV.layer.borderWidth = 1.0f;
    descTextV.layer.borderColor = [[UIColor grayColor] CGColor];
    descTextV.layer.cornerRadius = 4.0f;
    descTextV.text = [cellDataVo.score stringValue];
    
    return cell;
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
#pragma mark IBActions
- (IBAction)dissmiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSLog(@"slider value = %f", sender.value);
    //
    float realSvalue = sender.value * MAX_Similarity;
    NSPredicate *sPredicate =
    [NSPredicate predicateWithFormat:@"SELF.score >=%d",realSvalue];
    NSArray *filtered = [[self.dataArray objectAtIndex:0] filteredArrayUsingPredicate:sPredicate];
    NSLog(@"filtered:%@",filtered);
    self.dataArray = [[NSArray alloc] initWithObjects:filtered, nil];
    //
    [self.collectionView reloadData];
}
- (IBAction)refershControlAction:(id)sender {
//    NSLog(@"refershControlAction: = %@", sender);
    [[COVIASv1API sharedInstance] searchWithId:@"AVsA2ZiSmpceiMr56h1_"];
    //NotificationCenter handler
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSImagesHandler:) name:kNCpN_search_by_id object:nil];
}

#pragma mark Notification handlers
-(void)loadSImagesHandler:(NSNotification *) notification{
    SearchResponseImageHitsVO *imageHitsVo = [COVIASv1Model sharedInstance].imageHitsVo;
    self.dataArray = [[NSArray alloc] initWithObjects:imageHitsVo.hits, nil];
    [self.collectionView reloadData];
}

@end
