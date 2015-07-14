//
//  FamilyGroup.m
//  MyFamily
//
//  Created by 陆洋 on 15/7/2.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import "FamilyGroup.h"

@implementation FamilyGroup
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(id)familyGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
