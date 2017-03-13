//
//  SqootQueryLocation.h
//  CrispyOctoMoo
//
//  Created by yangboz on 12/12/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqootQueryLocation : NSObject
//private String address;//":     "444 Castro St.",
//private String locality;//":    "Mountain View",
//private String region;//":      "CA",
//private String postal_code;//": "94041",
//private String country;//":     "United States",
//private long latitude;//":    37.390751,
//private long longitude;//":   -122.080953
@property (nonatomic, strong) NSString *address;//
@property (nonatomic, strong) NSString *locality;//
@property (nonatomic, strong) NSString *region;//
@property (nonatomic, strong) NSString *postal_code;//
@property (nonatomic, strong) NSString *country;//
@property (nonatomic, strong) NSNumber *latitude;//
@property (nonatomic, strong) NSNumber *longitude;//
@end
