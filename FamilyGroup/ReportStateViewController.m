//
//  ReportStateViewController.m
//  MyFamily
//
//  Created by 陆洋 on 15/7/3.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import "ReportStateViewController.h"
#import "UITableView+Improve.h"
#import "UIImage+ReSize.h"
#import "HeaderContent.h"
@interface ReportStateViewController ()<UITextViewDelegate>
@property (nonatomic,weak)UITextView *reportStateTextView;
@property (nonatomic,weak)UILabel *pLabel;
@end

@implementation ReportStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView improveTableView];
    [self addHeaderView];
}

#define textViewHeight 60
#define headViewHeight 170
-(void)addHeaderView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, headViewHeight)];
    
    UITextView *reportStateTextView = [[UITextView alloc]initWithFrame:CGRectMake(padding, padding, screenWidth - 2*padding, textViewHeight)];
    self.reportStateTextView = reportStateTextView;
    self.reportStateTextView.delegate = self;
    [headView addSubview:reportStateTextView];
    
    UILabel *pLabel = [[UILabel alloc]initWithFrame:CGRectMake(padding, 2 * padding, screenWidth, 10)];
    pLabel.text = @"这一刻的想法...";
    pLabel.font = [UIFont systemFontOfSize:12];
    pLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
    self.pLabel = pLabel;
    [headView addSubview:pLabel];
    
    UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding, textViewHeight + 2*padding, 80, 80)];
    addImageView.image = [UIImage imageNamed:@"addPictures"];
    [headView addSubview:addImageView];
    
    
    self.tableView.tableHeaderView = headView;
}

#pragma mark - Text View Delegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.pLabel.hidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ReportStateCell";
    
    //缓存中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //创建
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // Configure the cell...
    if (indexPath.section == 0) {
        UIImage *headIcon = [UIImage imageNamed:@"location"];
        cell.imageView.image = [headIcon reSizeImagetoSize:CGSizeMake(20, 20)];
        cell.textLabel.text = @"所在位置";
        cell.textLabel.textColor = [UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    else
    {
        //不用自定义cell，但是可以设置cell的imageview中image的大小
        UIImage *headIcon = [UIImage imageNamed:@"seen"];
        cell.imageView.image = [headIcon reSizeImagetoSize:CGSizeMake(20, 20)];
        cell.textLabel.text = @"对谁可见";
        cell.textLabel.textColor = [UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
         return 5;
    }
    else
    {
        return 1;
    }
}
@end
