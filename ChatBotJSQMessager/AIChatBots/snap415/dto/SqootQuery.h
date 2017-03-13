//
//  SqootQuery.h
//  CrispyOctoMoo
//
//  Created by yangboz on 12/12/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqootQueryLocation.h"

@interface SqootQuery : NSObject
//private int total;//":    1000,
//private int page;//":     1,
//private int per_page;//": 10,
//@JsonIgnore
//private String query;//
//@JsonIgnore
//private SqootQueryLocation location = new SqootQueryLocation();//":
//private long radius;//":         10,
//@JsonIgnore
//private Boolean online;//":         false,
//
//private List<String> category_slugs;//": ["awesome-bagels"],
//
//private List<String> provider_slugs;//": [],
//private String updated_after;//":  null
@property (nonatomic, strong) NSNumber *total;//
@property (nonatomic, strong) NSNumber *page;//
@property (nonatomic, strong) NSNumber *per_page;//
@property (nonatomic, strong) NSString *query;//
@property (nonatomic, strong) SqootQueryLocation *location;//
@property (nonatomic, strong) NSNumber *radius;//
@property (nonatomic, assign) BOOL *online;//
@property (nonatomic, strong) NSArray *category_slugs;//
@property (nonatomic, strong) NSArray *provider_slugs;//
@property (nonatomic, strong) NSString *updated_after;//
@end
