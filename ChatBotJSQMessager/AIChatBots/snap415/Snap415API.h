//
//  Snap415API.h
//  CrispyOctoMoo
//
//  Created by yangboz on 12/7/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//

#import <Foundation/Foundation.h>
//@see Facade design pattern at http://www.raywenderlich.com/46988/ios-design-patterns
//@see Snap415API: https://github.com/yangboz/crispy-octo-moo/wiki/API-Services
//To be implemented of services
//TODO:EITCCreditService
//TODO:IncomeCategoryService
//TODO:FilingCategoryService
//TODO:ChildrenCategoryService
//TODO:EVCreditService
//TODO:MortgageInterestService
//TODO:ChildrenKeywordsService
//TODO:UserProfileService
//TODO:UserMeService
//TODO:FbUserProfileService
//TODO:LiUserProfileService
//TODO:OverviewService
//TODO:DealService
//TODO:CategoryDealService
//TODO:TaxEventService
//TODO:UserTaxEventService

#import "Snap415Token.h"
#import "Snap415UserProfile.h"
#import "Snap415Model.h"
#import "Snap415UserTaxEvents.h"
#import "SqootDealsObject.h"
#import "SqootDealObject.h"
#import "LabelObject.h"
#import "LabelGroupObject.h"
#import "LabelValueObject.h"
#import "EITCCreditObject.h"
#import "Snap415RwUserProfile.h"
//Notification Center post names;
#define kNCpN_load_overviews @"loadOverviewsSucc"
#define kNCpN_load_me @"loadMeSucc"
#define kNCpN_update_profile @"updateProfileSucc"
#define kNCpN_load_tax_events @"loadTaxEventsSucc"
#define kNCpN_load_deals @"loadDealsSucc"
#define kNCpN_get_EITCCredit @"getEITCCreditSucc"
//
#define kNCpN_load_income_categories @"loadIncomeCategories"
#define kNCpN_load_filing_categories @"loadFilingCategories"
#define kNCpN_load_children_categories @"loadChildrenCategories"
#define kNCpN_load_children_keywords @"loadChildrenKeywords"
#define kNCpN_load_mortgage_interests @"loadMortgageInterests"
#define kNCpN_load_EVCredits @"loadEVCredits"

@interface Snap415API : NSObject
+(Snap415API *)sharedInstance;

-(void)postUserMe;
-(void)updateUserProfile;
-(void)getTaxEvents;
-(void)getDeals;
-(void)getOverviews;
//Account settings
-(void)getIncomeCategories;
-(void)getFilingCategories;
-(void)getChildrenCategories;
-(void)getChildrenKeywords;
-(void)getMortgageInterests;
-(void)getEVCredits;
-(void)postEITCCredit;

@end
