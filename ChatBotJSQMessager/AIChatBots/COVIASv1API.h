//
//  COVIASv1API.h
//  DeepDetectChatBots
//
//  Created by yangboz on 24/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SearchExistedVO.h"
#import "SearchResponseVO.h"    
#import "COVIASv1Model.h"
//@see: http://stackoverflow.com/questions/5643514/how-to-define-an-nsstring-for-global-use
//#define DEV @"dev_aliyun"
#ifdef DEV
#define kAPIEndpointHost @"http://118.190.3.169:8084"
#else//LOCAL
#define kAPIEndpointHost @"http://localhost:8084/api/image/es/"
#endif
#define kAPI_esearch_img (@"search")
#define kAPI_esearch_id (@"searchExisted")

//Notification Center post names;
#define kNCpN_search_by_img @"esearchByImage"
#define kNCpN_search_by_id @"esearchById"

@interface COVIASv1API : NSObject
+(COVIASv1API *)sharedInstance;
-(void)searchWithImage:(UIImage*)image byIndex:(NSString *)index byItem:(NSString *)item;
-(void)searchWithId:(NSString*)esId byIndex:(NSString *)index byItem:(NSString *)item;
@end
