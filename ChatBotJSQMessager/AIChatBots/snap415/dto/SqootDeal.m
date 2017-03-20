//
//  SqootDeal.m
//  CrispyOctoMoo
//
//  Created by yangboz on 12/10/15.
//  Copyright © 2015 SMARTKIT.INFO. All rights reserved.
//

#import "SqootDeal.h"

@implementation SqootDeal
@synthesize title,short_title,id,url,untracked_url,price,value,discount_amount,discount_percentage,provider_name,provider_slug,category_name,category_slug,description,fine_print,image_url,online,number_sold,expires_at,created_at,updated_at;

-(NSDictionary *)keyMapping {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"title", @"title",
            @"short_title", @"short_title",
            @"url", @"url",
            @"untracked_url", @"untracked_url",
            @"price", @"price",
            @"value", @"value",
            @"discount_amount", @"discount_amount",
            @"discount_percentage", @"discount_percentage",
            @"provider_name", @"provider_name",
            @"provider_slug", @"provider_slug",
            @"category_name", @"category_name",
            @"category_slug", @"category_slug",
            @"description", @"description",
            @"fine_print", @"fine_print",
            @"image_url", @"image_url",
            @"online", @"online",
            @"number_sold", @"number_sold",
            @"expires_at", @"expires_at",
            @"created_at", @"created_at",
            @"updated_at", @"updated_at",
            nil];
}

+(SqootDeal *)getSqootDealFromDictionary:(NSDictionary *)dictionary {
    
    SqootDeal *obj = [[SqootDeal alloc] init];
    NSDictionary *mapping = [obj keyMapping];
    
    for (NSString *attribute in [mapping allKeys]){
        
        NSString *classProperty = [mapping objectForKey:attribute];
        NSString *attributeValue = [dictionary objectForKey:attribute];
        
        if (attributeValue!=nil&&!([attributeValue isKindOfClass:[NSNull class]])) {
            
            [obj setValue:attributeValue forKeyPath:classProperty];
        }
    }
    
    return obj;
    
}
@end
