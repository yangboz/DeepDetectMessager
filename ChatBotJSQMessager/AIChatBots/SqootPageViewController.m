//
//  SqootPageViewController.m
//  DeepDetectChatBots
//
//  Created by yangboz on 18/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "SqootPageViewController.h"
#import "MZTimerLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DataModel.h"
#import "ChatBotVoModel.h"

@interface SqootPageViewController ()

@end

@implementation SqootPageViewController
@synthesize shortTitle,expireLabel,priceLabel,valueLabel,imageUrl,descriptionTextView,discountLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //
    shortTitle.text = _sqootDeal.short_title;
    discountLabel.text = [@"$"  stringByAppendingString:[_sqootDeal.discount_amount stringValue]];
    expireLabel.text = _sqootDeal.expires_at;
    MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:expireLabel andTimerType:MZTimerLabelTypeTimer];
    [timer setCountDownTime:[_sqootDeal.expires_at doubleValue]];
    [timer start];
    priceLabel.text = [@"$" stringByAppendingString: [_sqootDeal.price stringValue]];
    valueLabel.text = [@"$" stringByAppendingString: [_sqootDeal.value stringValue]];
    ChatBotVoModel *selectedChatBotVo = [[DataModel sharedInstance] getSelectedChatBot];
    [imageUrl sd_setImageWithURL:[NSURL URLWithString:_sqootDeal.image_url]
                placeholderImage:[UIImage imageNamed:selectedChatBotVo.Image]
                          options:SDWebImageRefreshCached];
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [_sqootDeal.description dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    descriptionTextView.attributedText = attributedString;
    descriptionTextView.layer.borderWidth = 1.0f;
    descriptionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    descriptionTextView.layer.cornerRadius = 4.0f;
    //Merchant
//    merchantLabel.text = _sqootDeal.merchant.name;
    
    
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

@end
