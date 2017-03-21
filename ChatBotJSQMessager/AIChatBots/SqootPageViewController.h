//
//  SqootPageViewController.h
//  DeepDetectChatBots
//
//  Created by yangboz on 18/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqootDeal.h"

@interface SqootPageViewController : UIViewController

@property  NSUInteger pageIndex;
@property SqootDeal *sqootDeal;

@property (weak, nonatomic) IBOutlet UILabel *shortTitle;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;

@property (weak, nonatomic) IBOutlet UILabel *expireLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageUrl;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;


@end
