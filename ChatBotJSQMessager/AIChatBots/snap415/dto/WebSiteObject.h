//
//  WebSiteObject.h
//  CrispyOctoMoo
//
//  Created by yangboz on 12/8/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebSiteObject : NSObject
@property (nonatomic, strong) NSString *header;//header html string;
@property (nonatomic, strong) NSString *body;//body html string;
@property (nonatomic, strong) NSString *footer;//footer html string;
@end
