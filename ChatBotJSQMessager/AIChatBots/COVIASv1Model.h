//
//  COVIASv1Model.h
//  DeepDetectChatBots
//
//  Created by yangboz on 24/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResponseImageHitsVO.h"

@interface COVIASv1Model : NSObject
+(COVIASv1Model *)sharedInstance;

@property (strong, nonatomic) SearchResponseImageHitsVO *imageHitsVo;
@end
