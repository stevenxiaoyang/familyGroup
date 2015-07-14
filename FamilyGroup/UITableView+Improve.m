//
//  UITableView+Improve.m
//  MyFamily
//
//  Created by 陆洋 on 15/6/11.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import "UITableView+Improve.h"

@implementation UITableView (Improve)
-(void)improveTableView
{
    self.tableFooterView = [[UIView alloc]init];  //删除多余的行
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {  //防止分割线显示不
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
