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
#define kAPI_esearch_img_url (@"searchUrl")
#define kAPI_esearch_id (@"searchExisted")

//Notification Center post names;
#define kNCpN_search_by_img_file @"esearchByImageFile"
#define kNCpN_search_by_img_url @"esearchByImageUrl"
#define kNCpN_search_by_id @"esearchById"

//Default value.
#define kAPI_default_index @"my_index"
#define kAPI_default_item @"my_image_item"

@interface COVIASv1API : NSObject
+(COVIASv1API *)sharedInstance;
//Default index:my_index,item:my_image_item
-(void)searchWithImage:(UIImage*)image;
@property (strong, nonatomic) NSString *refreshUrl;
-(void)searchWithUrl:(NSString*)url;
-(void)searchWithId:(NSString*)esId;
@end
