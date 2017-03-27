//
//  CVC_Seque_Similarity.h
//  DeepDetectChatBots
//
//  Created by yangboz on 26/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COVIASv1Model.h"
#import "COVIASv1API.h"
#import "Constants.h"

@interface CVC_Seque_Similarity : UICollectionViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
- (IBAction)dissmiss:(id)sender;
- (IBAction)sliderValueChanged:(UISlider *)sender;
@end
