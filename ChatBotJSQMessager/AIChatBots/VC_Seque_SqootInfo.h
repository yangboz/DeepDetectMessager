//
//  VC_Seque_SqootInfo.h
//  DeepDetectChatBots
//
//  Created by yangboz on 20/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSStackedPageView.h"
#import "UIColor+CatColors.h"
#import "SqootPageViewController.h"
#import "DataModel.h"
#import "SqootPageViewController.h"

@interface VC_Seque_SqootInfo : UITableViewController<SSStackedViewDelegate>
@property (weak, nonatomic) IBOutlet SSStackedPageView *stackView;
@property (nonatomic) NSMutableArray *views;

- (IBAction)dissmiss:(id)sender;


@end
