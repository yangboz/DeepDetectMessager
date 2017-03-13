//
//  SqootDeal.h
//  CrispyOctoMoo
//
//  Created by yangboz on 12/10/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SqootMerchant.h"

@interface SqootDeal : NSObject
@property (nonatomic, strong) NSNumber *id;//
@property (nonatomic, strong) NSString *title;//
@property (nonatomic, strong) NSString *short_title;//
@property (nonatomic, strong) NSString *url;//
@property (nonatomic, strong) NSString *untracked_url;//
@property (nonatomic, strong) NSNumber *price;//
@property (nonatomic, strong) NSNumber *value;//
@property (nonatomic, strong) NSNumber *discount_amount;//
@property (nonatomic, strong) NSNumber *discount_percentage;//

@property (nonatomic, strong) NSString *provider_name;//
@property (nonatomic, strong) NSString *provider_slug;//
@property (nonatomic, strong) NSString *category_name;//
@property (nonatomic, strong) NSString *category_slug;//
@property (nonatomic, strong) NSString *description;//
@property (nonatomic, strong) NSString *fine_print;//
@property (nonatomic, strong) NSString *image_url;//
@property (nonatomic, strong) NSString *online;//bool?
@property (nonatomic, strong) NSString *number_sold;//
@property (nonatomic, strong) NSString *expires_at;//
@property (nonatomic, strong) NSString *created_at;//
@property (nonatomic, strong) NSString *updated_at;//

@property (nonatomic, strong) SqootMerchant *merchant;//

@end
