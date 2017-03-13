//
//  Snap415Token.h
//  CrispyOctoMoo
//
//  Created by yangboz on 12/7/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//
//@see: https://github.com/yangboz/crispy-octo-moo/blob/master/Spring-boot/src/main/java/crispy_octo_moo/dto/Snap415Token.java
#import <Foundation/Foundation.h>

@interface Snap415Token : NSObject
@property (nonatomic, strong) NSString *id;//social user id;
@property (nonatomic, strong) NSString *token;//access token
@property (nonatomic, strong) NSString *provider;//social provider name
@end
