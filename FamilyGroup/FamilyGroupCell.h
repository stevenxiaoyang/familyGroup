//
//  FamilyGroupCell.h
//  MyFamily
//
//  Created by 陆洋 on 15/7/2.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FamilyGroupFrame.h"
typedef void (^ImageBlock)(NSArray *imageViews,NSInteger clickTag);
@interface FamilyGroupCell : UITableViewCell
@property (nonatomic,strong)FamilyGroupFrame *familyGroupFrame;
@property (weak,nonatomic)UIButton *replyButton;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (strong,nonatomic)ImageBlock imageBlock;
@end
