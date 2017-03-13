//
//  Snap415UserProfileBase.h
//  CrispyOctoMoo
//
//  Created by yangboz on 12/12/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Snap415UserProfileBase : NSObject
//Simplify basic information as required.
@property(nonatomic,strong) NSString *simplyRelationshipStatus;
@property(nonatomic,strong) NSObject *simplyEducation;
@property(nonatomic,strong) NSString *simplyBirthday;
@property(nonatomic,strong) NSObject *simplyWork;
//Also allow user input,read and write
@property(nonatomic,strong) NSNumber *rwIncome;
@property(nonatomic,strong) NSString *rwTaxFilingStatus;
@property(nonatomic,strong) NSNumber *rwNumberOfChildren;

@end
