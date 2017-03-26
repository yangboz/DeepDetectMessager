//
//  COVIASv1Model.m
//  DeepDetectChatBots
//
//  Created by yangboz on 24/03/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

#import "COVIASv1Model.h"

@implementation COVIASv1Model
@synthesize imageHitsVo;
- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

#pragma interface of Snap415API

+(COVIASv1Model *)sharedInstance
{
    // 1
    static COVIASv1Model *_sharedInstance = nil;
    // 2
    static dispatch_once_t oncePredicate;
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[COVIASv1Model alloc] init];
    });
    return _sharedInstance;
}

@end
