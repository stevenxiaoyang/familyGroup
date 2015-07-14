//
//  FamilyGroupFrame.h
//  MyFamily
//
//  Created by 陆洋 on 15/7/2.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FamilyGroup.h"
@interface FamilyGroupFrame : NSObject
@property (nonatomic,assign)CGRect iconF;
@property (nonatomic,assign)CGRect nameF;
@property (nonatomic,assign)CGRect shuoshuotextF;
@property (nonatomic,strong)NSMutableArray *picturesF;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,assign)CGRect timeF;

@property (nonatomic,assign)CGRect replyF;
@property (nonatomic,strong)NSMutableArray *replysF;
@property (nonatomic,assign)CGRect replyBackgroundF;
@property(nonatomic,strong)FamilyGroup *familyGroup;
@end
