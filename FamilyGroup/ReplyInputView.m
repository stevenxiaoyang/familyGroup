//
//  ReplyInputView.m
//  MyFamily
//
//  Created by 陆洋 on 15/7/7.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import "ReplyInputView.h"
#import "HeaderContent.h"
@interface ReplyInputView()<UITextViewDelegate>
@property (nonatomic,weak)UITextView *sendTextView;
@property (nonatomic,weak)UILabel *lblPlaceholder;
@property (nonatomic,weak)UIButton *sendButton;
@property (nonatomic,weak)UIView *tapView;

//block
@property (strong, nonatomic) ContentSizeBlock sizeBlock;
@property (strong,nonatomic) replyAddBlock replyBlock;

@end
@implementation ReplyInputView

-(id)initWithFrame:(CGRect)frame andAboveView:(UIView *)bgView
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, MAXFLOAT)];
        //NSLog(@"%f,%f,%f,%f",self.tableView.frame.size.width,self.tableView.frame.size.height,screenWidth,screenHeight);
        tapView.backgroundColor = [UIColor clearColor];
        tapView.userInteractionEnabled = YES;
        [bgView addSubview:tapView];
        self.tapView = tapView;
        
        //tapView.hidden = YES;
        
        UITapGestureRecognizer *tapGer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappear)];
        [self.tapView addGestureRecognizer:tapGer];
        
        [self addReplyView];
        [self addConstraint];
    }
    return self;
}
#define replyTextHeight 54
#define textViewWidth screenWidth - 80

-(void)addReplyView
{
    self.backgroundColor = [UIColor colorWithRed:246.0/255 green:247.0/255 blue:247.0/255 alpha:1];
    
    //UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, padding, textViewWidth, textViewHeight)];   //框框不由textview显示，只是由来能够实现协议的方法
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];   //框框不由textview显示，只是由来能够实现协议的方法
    textView.backgroundColor = [UIColor whiteColor];
    textView.delegate = self;
    textView.layer.borderColor = UIColor.grayColor.CGColor;
    textView.layer.borderWidth = 0.1;
    textView.layer.cornerRadius = 6;
    textView.layer.masksToBounds = NO;
    textView.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:textView];
    self.sendTextView = textView;
    [self.sendTextView becomeFirstResponder];
    
    UILabel *lblPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, padding+2, 50, (replyTextHeight-2*padding-4))];
    lblPlaceholder.font = [UIFont systemFontOfSize:15.0f];
    lblPlaceholder.text = @"评论...";
    lblPlaceholder.textColor = [UIColor lightGrayColor];
    lblPlaceholder.backgroundColor = [UIColor clearColor];
    [self addSubview:lblPlaceholder];
    self.lblPlaceholder = lblPlaceholder;
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectZero;
    [sendButton setTitle:@"发表" forState:0];
    [sendButton setBackgroundImage:[[UIImage imageNamed:@"buttonSend.png"] stretchableImageWithLeftCapWidth:3 topCapHeight:(replyTextHeight-2*padding-4)] forState:UIControlStateNormal];
    sendButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [sendButton addTarget:self action:@selector(sendButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:sendButton];
    self.sendButton = sendButton;
}

-(void)addConstraint
{
    //给文本框添加约束
    self.sendTextView.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *sendStringH = [NSString stringWithFormat:@"H:|-(%d)-[_sendTextView(%f)]",padding,textViewWidth];
    NSString *sendStringV = [NSString stringWithFormat:@"V:|-(%d)-[_sendTextView]-(%d)-|",padding,padding];
    NSArray *sendTextViewConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:sendStringH options:0 metrics:0 views:NSDictionaryOfVariableBindings(_sendTextView)];
    [self addConstraints:sendTextViewConstraintH];
    
    NSArray *sendTextViewConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:sendStringV options:0 metrics:0 views:NSDictionaryOfVariableBindings(_sendTextView)];
    [self addConstraints:sendTextViewConstraintV];
    
    
    //给发送按钮添加约束
    self.sendButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *buttonStringH = [NSString stringWithFormat:@"H:[_sendButton(%d)]-(%d)-|",42,padding + 5];
    NSString *buttonStringV = [NSString stringWithFormat:@"V:|-(%d)-[_sendButton(%d)]",padding + 5,24];
    NSArray *sendButtonConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:buttonStringH options:0 metrics:0 views:NSDictionaryOfVariableBindings(_sendButton)];
    [self addConstraints:sendButtonConstraintH];
    
    NSArray *sendButtonConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:buttonStringV options:0 metrics:0 views:NSDictionaryOfVariableBindings(_sendButton)];
    [self addConstraints:sendButtonConstraintV];

}

-(void)sendButtonPressed
{
    if ([self.sendTextView.text isEqualToString:@""]) {  //用户没有输入评价内容
        return;
    }
    self.replyBlock(self.sendTextView.text,self.replyTag);
    [self disappear];
}

-(void)disappear
{
    [self.sendTextView resignFirstResponder];
    [self.tapView removeFromSuperview];
    self.tapView = nil;
    [self removeFromSuperview];
}

-(void)setContentSizeBlock:(ContentSizeBlock)block
{
    self.sizeBlock = block;
}

-(void)setReplyAddBlock:(replyAddBlock)block
{
    self.replyBlock = block;
}

#pragma mark - textview delegate

-(void)textViewDidChange:(UITextView *)textView
{
    self.lblPlaceholder.hidden = (textView.text.length > 0);
    CGSize contentSize = self.sendTextView.contentSize;
    self.sizeBlock(contentSize);
}
@end
