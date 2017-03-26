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
//Search similiary image by image base64 string
-(void)searchWithImage:(UIImage*)image byIndex:(NSString *)index byItem:(NSString *)item
{
    //
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[NSObject class]];
    [responseMapping addAttributeMappingsFromArray:@[@"results"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [requestMapping addAttributeMappingsFromArray:@[@"index", @"item"]];
    
    RKResponseDescriptor *respDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping method:RKRequestMethodAny pathPattern:kAPI_esearch_img keyPath:nil statusCodes:statusCodes];
    
    // For any object of class Article, serialize into an NSMutableDictionary using the given mapping and nest
    // under the 'user/me' key path
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[NSObject class] rootKeyPath:nil method:RKRequestMethodAny];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:[kAPIEndpointHost stringByAppendingString:kAPI_esearch_img]]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:respDescriptor];
    // Set MIME Type to JSON
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    //
    NSLog(@"RKObjectManager:%@",manager.baseURL);
    // POST to create
    [manager postObject: nil path:
     kAPI_esearch_id parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         //        NSLog(@"SUCCESS: %@", mappingResult.array);
         RKLogInfo(@"searchById: %@", mappingResult.array);
         //
         //        NSLog(@"RKMappingResult: %@", mappingResult.description);
         NSDictionary *dictObj = [NSDictionary dictionaryWithObject:mappingResult.array[0] forKey:@"results"];
         [[NSNotificationCenter defaultCenter] postNotificationName:kNCpN_search_by_img object:dictObj];
         //Save to model
         [COVIASv1Model sharedInstance].imageHitsVo = (NSObject*)[dictObj objectForKey:kNCpN_search_by_img];
        
     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Operation failed with error: %@", error);
     }];

}
//Search similiary image by existed id;
-(void)searchWithId:(NSString*)esId byIndex:(NSString *)index byItem:(NSString *)item
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
    vo.index = index;
    vo.item = item;
    vo.esId = esId;
    NSString *aPath = [NSString stringWithFormat:@"%@/%@/%@/%@",kAPI_esearch_id,index,item,esId];
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
