//
//  Snap415Model.h
//  CrispyOctoMoo
//
//  Created by yangboz on 12/12/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WebSiteObject.h"
#import "Snap415UserProfile.h"
#import "Snap415Token.h"
#import "Snap415UserTaxEvents.h"
#import "SqootDealsObject.h"
#import "EITCCreditObject.h"
#import "Snap415RwUserProfile.h"

@interface Snap415Model : NSObject
+(Snap415Model *)sharedInstance;

@property (strong, nonatomic) Snap415Token *snap415Token;
@property (strong, nonatomic) NSArray *overviews;
@property (strong, nonatomic) Snap415UserProfile * me;
@property (strong, nonatomic) Snap415UserTaxEvents *snap415UserTaxEvents;
@property (strong, nonatomic) SqootDealsObject *sqootDealsObject;
@property (strong, nonatomic) Snap415RwUserProfile *profile;//{income:0,children:0,filingCategory:'',iconUrl:''};
//Account settings
@property (strong, nonatomic) NSArray *incomeCategories;
@property (strong, nonatomic) NSArray *filingCategories;
@property (strong, nonatomic) NSArray *childrenCategories;
@property (strong, nonatomic) NSArray *childrenKeywords;
@property (strong, nonatomic) NSArray *mortgageInterests;
@property (strong, nonatomic) NSArray *EVCredits;
@property (strong, nonatomic) EITCCreditObject *eitcCreditObject;
@end
