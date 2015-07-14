//
//  FamilyGroup.h
//  MyFamily
//
//  Created by 陆洋 on 15/7/2.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamilyGroup : NSObject
@property (strong,nonatomic)NSString *icon;  //头像
@property (strong,nonatomic)NSString *name;  //昵称
@property (strong,nonatomic)NSString *shuoshuoText; //说说
@property (strong,nonatomic)NSString *time;    //发表的时间,存的是nadate，应该要有时间操作
@property (strong,nonatomic)NSArray *pictures;   //发表的图片
@property (strong,nonatomic)NSMutableArray *replys;   //评论
#pragma mark - 最后要考虑是暂存coredata里还是plist文件里
+(id)familyGroupWithDict:(NSDictionary *)dict;
@end
