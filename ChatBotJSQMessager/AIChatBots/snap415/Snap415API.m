//
//  Snap415API.m
//  CrispyOctoMoo
//
//  Created by yangboz on 12/7/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//

#import "Snap415API.h"

#import <RestKit/RestKit.h>

//@see: http://stackoverflow.com/questions/5643514/how-to-define-an-nsstring-for-global-use
#define DEV @"dev_aliyun"
#ifdef DEV
#define kAPIEndpointHost @"http://118.190.96.120:8083/api/v1/"
#else//LOCAL
#define kAPIEndpointHost @"http://localhost:8083/api/v1/"
#endif
//@see: https://github.com/yangboz/crispy-octo-moo/wiki/API-Services
#define kAPI_user_me (@"user/me")
#define kAPI_user_profile (@"user/profile/")
#define kAPI_tax_events (@"user/events")
#define kAPI_deals (@"deals/by/")//{keywords},default @"car"
#define kAPI_deals_catetory (@"car")
//#define kAPI_overviews (@"user/overviews")
#define kAPI_overviews (@"overviews")
//AccountSettings
#define kAPI_incomeCategories (@"incomeCategory")
#define kAPI_filingCategories (@"fillingCategory")//:Key
#define kAPI_childrenCategories (@"childrenCategory")//:Key
#define kAPI_childrenKeywords (@"cKeywords")//:Index
#define kAPI_mortgageInterests (@"mInterests")//:Index
#define kAPI_EVCredits (@"evCredit")//:Key
#define kAPI_EITCCredit (@"eitcCredit")

#import "WebSiteObject.h"

@implementation Snap415API

- (id)init
{
    self = [super init];
    if (self) {
        //
        
    }
    return self;
}

#pragma interface of Snap415API

+(Snap415API *)sharedInstance
{
    // 1
    static Snap415API *_sharedInstance = nil;
    // 2
    static dispatch_once_t oncePredicate;
    // 3
    dispatch_once(&oncePredicate, ^{
            _sharedInstance = [[Snap415API alloc] init];
        });
    return _sharedInstance;
}
//Sync the user profile
-(void)postUserMe
{
    //
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[Snap415UserProfile class]];
    [responseMapping addAttributeMappingsFromArray:@[@"snap415ID", @"fbUserProfile", @"liUserProfile",@"profileBase"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [requestMapping addAttributeMappingsFromArray:@[@"id", @"token", @"provider"]];

    RKResponseDescriptor *respDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping method:RKRequestMethodAny pathPattern:kAPI_user_me keyPath:nil statusCodes:statusCodes];
    
    // For any object of class Article, serialize into an NSMutableDictionary using the given mapping and nest
    // under the 'user/me' key path
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Snap415Token class] rootKeyPath:nil method:RKRequestMethodAny];

    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kAPIEndpointHost]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:respDescriptor];
    // Set MIME Type to JSON
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    //
    NSLog(@"RKObjectManager:%@",manager.baseURL);
    // POST to create
    [manager postObject: [Snap415Model sharedInstance].snap415Token path:
kAPI_user_me parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        NSLog(@"SUCCESS: %@", mappingResult.array);
        RKLogInfo(@"Load item of Snap415UserMe: %@", mappingResult.array);
        //
        //        NSLog(@"RKMappingResult: %@", mappingResult.description);
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array[0] forKey:kNCpN_load_me];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_load_me object:dictObj];
        //Save to model
        [Snap415Model sharedInstance].me = (Snap415UserProfile*)[dictObj objectForKey:kNCpN_load_me];
        NSLog(@"[Snap415Model sharedInstance].me:%@",[Snap415Model sharedInstance].me.description);
    NSLog(@"[Snap415Model sharedInstance].me.profileBase:%@",[Snap415Model sharedInstance].me.profileBase.description);
    NSLog(@"[Snap415Model sharedInstance].me.profileBase.simplyRelationshipStatus:%@",[[Snap415Model sharedInstance].me.profileBase  objectForKey:@"simplyRelationshipStatus"] );
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    //
    // PATCH to update
//    article.body = @"New Body";
//    [manager patchObject:article path:@"/articles/1234" parameters:nil success:nil failure:nil];
//    
//    // DELETE to destroy
//    [manager deleteObject:article path:@"/articles/1234" parameters:nil success:nil failure:nil];
}
-(void)updateUserProfile
{
    //
    NSString *pathStr = [[NSString alloc] initWithFormat:@"%@%@_%@",kAPI_user_profile,[Snap415Model sharedInstance].snap415Token.provider,
                         [Snap415Model sharedInstance].snap415Token.id];
    NSString *paramStr = [[NSString alloc] initWithFormat:@"%@_%@",[Snap415Model sharedInstance].snap415Token.provider,
                          [Snap415Model sharedInstance].snap415Token.id];
    //
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[Snap415UserProfile class]];
    [responseMapping addAttributeMappingsFromArray:@[@"snap415ID", @"fbUserProfile", @"liUserProfile",@"profileBase"]];
    //
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [requestMapping addAttributeMappingsFromArray:@[@"rwIncome", @"rwTaxFilingStatus", @"rwNumberOfChildren"]];
    
    RKResponseDescriptor *respDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping method:RKRequestMethodAny pathPattern:pathStr keyPath:nil statusCodes:statusCodes];
    
    // For any object of class Article, serialize into an NSMutableDictionary using the given mapping and nest
    // under the 'user/profile' key path
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Snap415Token class] rootKeyPath:nil method:RKRequestMethodAny];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kAPIEndpointHost]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:respDescriptor];
    // Set MIME Type to JSON
    manager.requestSerializationMIMEType = RKMIMETypeJSON;

    // PUT to update
    [manager putObject: [Snap415Model sharedInstance].profile path:pathStr parameters:@{@"id":paramStr} success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //        NSLog(@"SUCCESS: %@", mappingResult.array);
        RKLogInfo(@"Update item of Snap415UserProfile: %@", mappingResult.array);
        //
        //        NSLog(@"RKMappingResult: %@", mappingResult.description);
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array forKey:kNCpN_update_profile];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_update_profile object:dictObj];
//Save to model
//        [Snap415Model sharedInstance].me = [dictObj objectForKey:kNCpN_update_profile];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
//                                                        message:@"Update User Profile Successful!"
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"Update User Profile Error!"
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [alertError show];
    }];
    //
    // PATCH to update
    //    article.body = @"New Body";
    //    [manager patchObject:article path:@"/articles/1234" parameters:nil success:nil failure:nil];
    //
    //    // DELETE to destroy
    //    [manager deleteObject:article path:@"/articles/1234" parameters:nil success:nil failure:nil];
}
-(void)getTaxEvents
{
    //
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[Snap415UserTaxEvents class]];
    [responseMapping addAttributeMappingsFromArray:@[@"snap415ID", @"id", @"taxEvents"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [requestMapping addAttributeMappingsFromArray:@[@"id", @"token", @"provider"]];
    
    RKResponseDescriptor *respDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping method:RKRequestMethodAny pathPattern:kAPI_tax_events keyPath:nil statusCodes:statusCodes];
    
    // For any object of class Snap415UserTaxEvents, serialize into an NSMutableDictionary using the given mapping and nest
    // under the 'user/me' key path
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Snap415Token class] rootKeyPath:nil method:RKRequestMethodAny];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kAPIEndpointHost]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:respDescriptor];
    // Set MIME Type to JSON
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    // POST to create
    [manager postObject: [Snap415Model sharedInstance].snap415Token path:kAPI_tax_events parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //        NSLog(@"SUCCESS: %@", mappingResult.array);
        RKLogInfo(@"Load item of Snap415UserTaxEvents: %@", mappingResult.array);
        //
        //        NSLog(@"RKMappingResult: %@", mappingResult.description);
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array[0] forKey:kAPI_tax_events];
        //Save to model
        [Snap415Model sharedInstance].snap415UserTaxEvents = (Snap415UserTaxEvents *)[dictObj objectForKey:kAPI_tax_events];
        //Post to NotificationCenter is neccessary.
        //        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_load_me object:dictObj];
        //
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
}
//GET only.
-(void)getDealsBy:(NSString *)keywords;
{
    RKObjectMapping* articleMapping = [RKObjectMapping mappingForClass:[SqootDealsObject class]];
    [articleMapping addAttributeMappingsFromDictionary:@{
//                                                         @"query": @"query",
                                                         @"deals": @"deals"
                                                         }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    //NSURL with escape string.
    NSString *UrlStr = [NSString stringWithFormat:@"%@%@%@",kAPIEndpointHost,kAPI_deals,keywords];
    NSString *encodedUrlStr = [UrlStr stringByAddingPercentEscapesUsingEncoding:
                               NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:encodedUrlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load collection of SqootDealsObject: %@", mappingResult.array);
        [Snap415Model sharedInstance].sqootDealsObject = (SqootDealsObject *)mappingResult.array[0];
        //Post to Notification Center is neccessary.
        //        NSLog(@"RKMappingResult: %@", mappingResult.description);
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array forKey:kNCpN_load_deals];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_load_deals object:dictObj];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    //load begin
    [objectRequestOperation start];
//     [[RKObjectManager sharedManager] enqueueObjectRequestOperation:objectRequestOperation];
}
//GET only.
-(void)getOverviews
{
    RKObjectMapping* articleMapping = [RKObjectMapping mappingForClass:[WebSiteObject class]];
    [articleMapping addAttributeMappingsFromDictionary:@{
                                                         @"footer": @"footer",
                                                         @"body": @"body",
                                                         @"header": @"header"
                                                         }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping method:RKRequestMethodAny pathPattern:@"/:index/:item/:id" keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kAPIEndpointHost,kAPI_overviews]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load collection of WebSiteObjects: %@", mappingResult.array);
        //
//        NSLog(@"RKMappingResult: %@", mappingResult.description);
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array forKey:kNCpN_load_overviews];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_load_overviews object:dictObj];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    //load begin
    [objectRequestOperation start];
}
//Account settings
-(void)getIncomeCategories{
    RKObjectMapping* labelObjMapping = [RKObjectMapping mappingForClass:[LabelObject class]];
    [labelObjMapping addAttributeMappingsFromDictionary:@{
                                                         @"label": @"label"
                                                         }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:labelObjMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kAPIEndpointHost,kAPI_incomeCategories]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [Snap415Model sharedInstance].incomeCategories = mappingResult.array;
        RKLogInfo(@"Load collection of IncomeCategories: %@", mappingResult.array);
        //Post to NotificationCenter if neccessary.
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array forKey:kNCpN_load_income_categories];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_load_income_categories object:dictObj];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    //load begin
    [objectRequestOperation start];
}
-(void)getFilingCategories{
    RKObjectMapping* labelGroupObjMapping = [RKObjectMapping mappingForClass:[LabelGroupObject class]];
    [labelGroupObjMapping addAttributeMappingsFromDictionary:@{
                                                          @"label": @"label",
                                                          @"group": @"group"
                                                          }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:labelGroupObjMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kAPIEndpointHost,kAPI_filingCategories]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load collection of FillingCategories: %@", mappingResult.array);
        [Snap415Model sharedInstance].filingCategories = mappingResult.array;
        //Post to NotificationCenter if neccessary.
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array forKey:kNCpN_load_filing_categories];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_load_filing_categories object:dictObj];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    //load begin
    [objectRequestOperation start];
}
-(void)getChildrenCategories{
    RKObjectMapping* labelObjMapping = [RKObjectMapping mappingForClass:[LabelObject class]];
    [labelObjMapping addAttributeMappingsFromDictionary:@{
                                                               @"label": @"label"
                                                               }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:labelObjMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kAPIEndpointHost,kAPI_childrenCategories]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load collection of ChildrenCategories: %@", mappingResult.array);
        [Snap415Model sharedInstance].childrenCategories = mappingResult.array;
        //Post to NotificationCenter if neccessary.
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array forKey:kNCpN_load_children_categories];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_load_children_categories object:dictObj];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    //load begin
    [objectRequestOperation start];
}
-(void)getChildrenKeywords{
    RKObjectMapping* labelObjMapping = [RKObjectMapping mappingForClass:[LabelObject class]];
    [labelObjMapping addAttributeMappingsFromDictionary:@{
                                                          @"label": @"label"
                                                          }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:labelObjMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kAPIEndpointHost,kAPI_childrenKeywords]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [Snap415Model sharedInstance].childrenKeywords = mappingResult.array;
        RKLogInfo(@"Load collection of ChildrenKeywords: %@", mappingResult.array);
        //Post to NotificationCenter if neccessary.
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array forKey:kNCpN_load_children_keywords];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_load_children_keywords object:dictObj];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    //load begin
    [objectRequestOperation start];
}
-(void)getMortgageInterests{
    RKObjectMapping* labelObjMapping = [RKObjectMapping mappingForClass:[LabelObject class]];
    [labelObjMapping addAttributeMappingsFromDictionary:@{
                                                          @"label": @"label"
                                                          }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:labelObjMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kAPIEndpointHost,kAPI_mortgageInterests]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [Snap415Model sharedInstance].mortgageInterests = mappingResult.array;
        RKLogInfo(@"Load collection of MortgageInterests: %@", mappingResult.array);
        //Post to NotificationCenter if neccessary.
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array forKey:kNCpN_load_mortgage_interests];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_load_mortgage_interests object:dictObj];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    //load begin
    [objectRequestOperation start];
}
-(void)getEVCredits{
    RKObjectMapping* labelValueObjMapping = [RKObjectMapping mappingForClass:[LabelValueObject class]];
    [labelValueObjMapping addAttributeMappingsFromDictionary:@{
                                                          @"label": @"label",
                                                          @"value": @"value"
                                                          }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:labelValueObjMapping method:RKRequestMethodAny pathPattern:nil keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kAPIEndpointHost,kAPI_EVCredits]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [Snap415Model sharedInstance].EVCredits = mappingResult.array;
        RKLogInfo(@"Load collection of EVCredits: %@", mappingResult.array);
        //Post to NotificationCenter if neccessary.
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array forKey:kNCpN_load_EVCredits];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_load_EVCredits object:dictObj];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    //load begin
    [objectRequestOperation start];
}
-(void)postEITCCredit{
    //
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[Snap415UserProfile class]];
    [responseMapping addAttributeMappingsFromArray:@[]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [requestMapping addAttributeMappingsFromArray:@[@"relationshipStatus", @"numberOfChildren", @"income"]];
    
    RKResponseDescriptor *respDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping method:RKRequestMethodAny pathPattern:kAPI_EITCCredit keyPath:@"data" statusCodes:statusCodes];
    
    // For any object of class Article, serialize into an NSMutableDictionary using the given mapping and nest
    // under the 'user/me' key path
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[EITCCreditObject class] rootKeyPath:nil method:RKRequestMethodAny];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kAPIEndpointHost]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:respDescriptor];
    // Set MIME Type to JSONx
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    // POST to get EITCCredit result
    [manager postObject: [Snap415Model sharedInstance].eitcCreditObject path:kAPI_EITCCredit parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //        NSLog(@"SUCCESS: %@", mappingResult.array);
        RKLogInfo(@"Post item of EITCCredit result: %@", mappingResult.array);
        //
        //        NSLog(@"RKMappingResult: %@", mappingResult.description);
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array forKey:kNCpN_get_EITCCredit];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_get_EITCCredit object:dictObj];
        //Display calculated result;
        NSString *resultStr = [[NSString alloc] initWithFormat: @"EITCCreditService calculated result:%@",@"0" ];
        UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
            message:resultStr
            delegate:self
            cancelButtonTitle:@"OK"
            otherButtonTitles:nil];
        [alertError show];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
}
@end
