//
//  Snap415UserProfile.h
//  CrispyOctoMoo
//
//  Created by yangboz on 12/7/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Snap415UserProfileBase.h"

@interface Snap415UserProfile : NSObject
@property (nonatomic, strong) NSString *snap415ID;//social user id;
@property(nonatomic,strong) NSDictionary *fbUserProfile;
@property(nonatomic,strong) NSObject *liUserProfile;
//@property(nonatomic,strong) Snap415UserProfileBase *profileBase;
@property(nonatomic,strong) NSDictionary *profileBase;
@end
