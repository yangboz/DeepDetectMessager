//
//  DetailViewController.m
//  AIChatBots
//
//  Created by yangboz on 2016/12/26.
//  Copyright © 2016年 ___SMARTKIT.INFO___. All rights reserved.
//

#import "DetailViewController.h"
#import "DataModel.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.title = self.detailItem.Name;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //UISwipeGestureRecognizer
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognizer:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
}

-(void)swipeRecognizer:(UISwipeGestureRecognizer *)sender {
    if ( sender.direction == UISwipeGestureRecognizerDirectionLeft )
    NSLog(@" *** SWIPE LEFT ***");
    if ( sender.direction == UISwipeGestureRecognizerDirectionRight )
    NSLog(@" *** SWIPE RIGHT ***");
    if ( sender.direction == UISwipeGestureRecognizerDirectionDown )
    NSLog(@" *** SWIPE DOWN ***");
    if ( sender.direction == UISwipeGestureRecognizerDirectionUp )
    NSLog(@" *** SWIPE UP ***");
}

@end
