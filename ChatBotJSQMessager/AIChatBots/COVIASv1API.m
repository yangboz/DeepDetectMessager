//
//  COVIASv1API.m
//  DeepDetectChatBots
//
//  Created by yangboz on 24/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "COVIASv1API.h"
#import <RestKit/RestKit.h>

@implementation COVIASv1API

- (id)init
{
    self = [super init];
    if (self) {
        //
        
    }
    return self;
}

#pragma interface of Snap415API

+(COVIASv1API *)sharedInstance
{
    // 1
    static COVIASv1API *_sharedInstance = nil;
    // 2
    static dispatch_once_t oncePredicate;
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[COVIASv1API alloc] init];
    });
    return _sharedInstance;
}
//TODO:Search similiary image by image base64 string
-(void)searchWithImage:(UIImage*)image
{
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[SearchResponseVO class]];
    [responseMapping addAttributeMappingsFromArray:@[@"took",@"timeout",@"_shards",@"hits"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *articleDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:statusCodes];
    
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [requestMapping addAttributeMappingsFromArray:@[@"index", @"item",@"file"]];
    
    // For any object of class Article, serialize into an NSMutableDictionary using the given mapping and nest
    // under the 'article' key path
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[SearchExistedVO class] rootKeyPath:nil method:RKRequestMethodAny];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kAPIEndpointHost]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:articleDescriptor];
    
    SearchExistedVO *vo = [SearchExistedVO new];
    vo.index = kAPI_default_index;
    vo.item = kAPI_default_item;
    NSString *aPath = [NSString stringWithFormat:@"%@/%@/%@/",kAPI_esearch_img,vo.index,vo.item];
    [manager setRequestSerializationMIMEType:RKMIMETypeJSON];
    //
    //get product name.
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
    NSDate *todaysDate = [NSDate new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM-dd-yyyy_HH_mm_ss"];
    NSString *strDateTime = [formatter stringFromDate:todaysDate];
    NSString *uniqueName = [NSString stringWithFormat:@"%@_%@",prodName,strDateTime];
    //
    NSMutableURLRequest *request = [[RKObjectManager sharedManager] multipartFormRequestWithObject:vo method:RKRequestMethodPOST path:aPath parameters:nil constructingBodyWithBlock:^(id<AFRKMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                    name:uniqueName
                                fileName:uniqueName
                                mimeType:@"image/png"];
    }];
    
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] objectRequestOperationWithRequest:request success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //        NSLog(@"SUCCESS: %@", mappingResult.array);
        SearchResponseVO *searchRespVo = (SearchResponseVO *)[mappingResult.array objectAtIndex:0];
        //         SearchResponseVO *searchRespVo = [SearchResponseVO getModelFromDictionary:respDict];
        RKLogInfo(@"searchById searchRespVo: %@", searchRespVo.description);
        SearchResponseImageHitsVO *imageHitsVo =[SearchResponseImageHitsVO getModelFromDictionary: searchRespVo.hits];
        NSLog(@"SearchResponseImageHitsVO: %@", imageHitsVo.description);
        //Notification center
        NSDictionary *dictObj = [NSDictionary dictionaryWithObject:imageHitsVo forKey:kNCpN_search_by_id];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_search_by_id object:dictObj];
        //Save to model
        [COVIASv1Model sharedInstance].imageHitsVo = imageHitsVo;
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation]; // NOTE: Must be enqueued rather than started
}
//Search similiary image by existed id;
-(void)searchWithId:(NSString*)esId
{
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[SearchResponseVO class]];
    [responseMapping addAttributeMappingsFromArray:@[@"took",@"timeout",@"_shards",@"hits"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *articleDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:statusCodes];
    
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [requestMapping addAttributeMappingsFromArray:@[@"index", @"item", @"id"]];
    
    // For any object of class Article, serialize into an NSMutableDictionary using the given mapping and nest
    // under the 'article' key path
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[SearchExistedVO class] rootKeyPath:nil method:RKRequestMethodAny];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kAPIEndpointHost]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:articleDescriptor];
    
    SearchExistedVO *vo = [SearchExistedVO new];
    vo.index = kAPI_default_index;
    vo.item = kAPI_default_item;
    vo.esId = esId;
    NSString *aPath = [NSString stringWithFormat:@"%@/%@/%@/%@",kAPI_esearch_id,vo.index,vo.item,esId];
    [manager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [manager postObject: vo path:
     aPath parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         //        NSLog(@"SUCCESS: %@", mappingResult.array);
         SearchResponseVO *searchRespVo = (SearchResponseVO *)[mappingResult.array objectAtIndex:0];
         //         SearchResponseVO *searchRespVo = [SearchResponseVO getModelFromDictionary:respDict];
         RKLogInfo(@"searchById searchRespVo: %@", searchRespVo.description);
         SearchResponseImageHitsVO *imageHitsVo =[SearchResponseImageHitsVO getModelFromDictionary: searchRespVo.hits];
         NSLog(@"SearchResponseImageHitsVO: %@", imageHitsVo.description);
         //Notification center
         NSDictionary *dictObj = [NSDictionary dictionaryWithObject:imageHitsVo forKey:kNCpN_search_by_id];
         [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_search_by_id object:dictObj];
         //Save to model
         [COVIASv1Model sharedInstance].imageHitsVo = imageHitsVo;
     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Operation failed with error: %@", error);
     }];
    
}

//Search similiary image by image url;
-(void)searchWithUrl:(NSString*)url
{
    //only for refresh
    [COVIASv1API sharedInstance].refreshUrl = url;
    //
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[SearchResponseVO class]];
    [responseMapping addAttributeMappingsFromArray:@[@"took",@"timeout",@"_shards",@"hits"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *articleDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:statusCodes];
    
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [requestMapping addAttributeMappingsFromArray:@[@"index", @"item", @"url"]];
    
    // For any object of class Article, serialize into an NSMutableDictionary using the given mapping and nest
    // under the 'article' key path
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[SearchExistedVO class] rootKeyPath:nil method:RKRequestMethodAny];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kAPIEndpointHost]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:articleDescriptor];
    
    SearchExistedVO *vo = [SearchExistedVO new];
    vo.index = kAPI_default_index;
    vo.item = kAPI_default_item;
    vo.url = url;
    NSString *aPath = [NSString stringWithFormat:@"%@/",kAPI_esearch_img_url];
    [manager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [manager postObject: vo path:
     aPath parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         //        NSLog(@"SUCCESS: %@", mappingResult.array);
         SearchResponseVO *searchRespVo = (SearchResponseVO *)[mappingResult.array objectAtIndex:0];
//         SearchResponseVO *searchRespVo = [SearchResponseVO getModelFromDictionary:respDict];
         RKLogInfo(@"searchById searchRespVo: %@", searchRespVo.description);
         SearchResponseImageHitsVO *imageHitsVo =[SearchResponseImageHitsVO getModelFromDictionary: searchRespVo.hits];
         NSLog(@"SearchResponseImageHitsVO: %@", imageHitsVo.description);
         //Notification center
         NSDictionary *dictObj = [NSDictionary dictionaryWithObject:imageHitsVo forKey:kNCpN_search_by_id];
         [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_search_by_id object:dictObj];
         //Save to model
         [COVIASv1Model sharedInstance].imageHitsVo = imageHitsVo;
             } failure:^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Operation failed with error: %@", error);
     }];

}
@end
