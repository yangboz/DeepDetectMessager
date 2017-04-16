//
//  Constants.m
//  ChatBotsMessager
//
//  Created by zhou Yangbo on 13-3-19.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "Constants.h"

@implementation Constants
NSString *const API_HOST_COVIS = @"118.190.3.169";
NSString *const API_DOMAIN_COVIS = @"http://118.190.3.169:8084/api/image/es/";
NSString *const API_HOST_ES = @"localhost:9200";
NSString *const API_DOMAIN_ES = @"localhost:9200/my_index/my_image_item/_search";
NSString *const API_HOST_DD = @"118.190.96.120";
NSString *const API_DOMAIN_DD = @"http://118.190.96.120:8090/predict";
NSString *const API_CLOUDINARY = @"cloudinary://445785421588325:EmFqoMzkE_99t-2caS4h-z0FEp4@dxlwdcgq0y";
NSString *const APP_SECRET_WX = @"wx581549aa4e7989bb";
NSString *const APP_ID_WX = @"8557d630ccc97c2fcfbe4ca97ea8b2cc";
float MAX_Similarity = 2.00;
float MIN_Similarity = 0.00;
@end
