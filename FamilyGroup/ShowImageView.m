//
//  ShowImageView.m
//  FriendGroup
//
//  Created by Steven on 15/5/6.
//  Copyright (c) 2015年 luyang. All rights reserved.
//

#import "ShowImageView.h"
#import "HeaderContent.h"
@interface ShowImageView()<UIScrollViewDelegate>
@property (nonatomic,assign)CGRect self_frame;
@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,assign)BOOL isChangedBig;
@end
@implementation ShowImageView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(id)initWithFrame:(CGRect)frame byClickTag:(NSInteger)clickTag appendArray:(NSArray *)appendArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.self_frame = frame;
        [self initScrollerView:appendArray];  //初始化scrollView
        [self initImageView:appendArray];
        [self.scrollView setContentOffset:CGPointMake(frame.size.width*(clickTag-imageTag), 0) animated:YES];
        self.page = clickTag - imageTag;
        self.isChangedBig = YES;
        //self.alpha = 0;
        //self.backgroundColor = [UIColor redColor];
        
        UITapGestureRecognizer *tapGser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappear)];
        tapGser.numberOfTouchesRequired = 1;
        tapGser.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGser];
        
        UITapGestureRecognizer *doubleTapGser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBig:)];
        doubleTapGser.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTapGser];
        [tapGser requireGestureRecognizerToFail:doubleTapGser];
    }
    return self;
}

-(void)initScrollerView:(NSArray *)appendArray
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.self_frame];
        scrollView.contentSize = CGSizeMake(self.self_frame.size.width*[appendArray count], 0);  //可滑动区域
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
}

-(void)initImageView:(NSArray *)appendArray
{
    for (int i = 0; i < [appendArray count]; i++) {
        UIScrollView *imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.self_frame.size.width*i, 0, self.self_frame.size.width, self.self_frame.size.height)];
        imageScrollView.backgroundColor = [UIColor blackColor];
        imageScrollView.contentSize = CGSizeMake(self.self_frame.size.width, self.self_frame.size.height); //可以为0吗，好了可以试一试
        imageScrollView.delegate = self;
        imageScrollView.maximumZoomScale = 4;
        imageScrollView.minimumZoomScale = 1;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        //NSLog(@"%f,%f,%f,%f",self.bounds.origin.x,self.bounds.origin.y,self.bounds.size.width,self.bounds.size.height);
        UIImage *img = [UIImage imageNamed:[appendArray objectAtIndex:i]];
        imageView.image = img;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageScrollView addSubview:imageView];
        [self.scrollView addSubview:imageScrollView];
        
        imageScrollView.tag = 100 + i ;  //保证唯一性
        imageView.tag = 1000 + i;
    }
}

-(void)disappear
{
    self.removeImg();
}

-(void)changeBig:(UITapGestureRecognizer *)tapGser
{
    CGFloat newScale;
    UIScrollView *currentScrollView = (UIScrollView *)[self viewWithTag:self.page + 100];
    if (self.isChangedBig) {
        newScale = 2.0;
    }
    else
    {
        newScale = 1;
    }
    CGRect zoomRect = [self getRectWithScale:newScale andCenter:[tapGser locationInView:tapGser.view]];
    [currentScrollView zoomToRect:zoomRect animated:YES];
    self.isChangedBig = !self.isChangedBig;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:scrollView.tag + 900];
    //NSLog(@"%ld",scrollView.tag + 900);  //因为是别的scrollview改scale，所以也应该返回它们的imageview,所以这里tag应该用scrollview的tag得到它对应的imageview
    //NSLog(@"%ld",self.page + 1000);
    return imageView;
}

- (CGRect) getRectWithScale:(float)scale andCenter:(CGPoint)center
{
    CGRect newRect = CGRectZero;
    newRect.size.width = self.self_frame.size.width/scale;
    newRect.size.height = self.self_frame.size.height/scale;
    newRect.origin.x=center.x-newRect.size.width/2;
    newRect.origin.y=center.y-newRect.size.height/2;
    return newRect;
}

#pragma mark - ScorllViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{    //图片滑动后原来的图片大小改变原样
    
    CGPoint offset = self.scrollView.contentOffset;
    self.page = offset.x / self.frame.size.width ;
    
    
    UIScrollView *scrollV_next = (UIScrollView *)[self viewWithTag:self.page+100+1]; //前一页
    
    if (scrollV_next.zoomScale != 1.0){       //只要zoomscale变化就会调用viewforzoominginscrollview
        scrollV_next.zoomScale = 1.0;
    }
    
    UIScrollView *scollV_pre = (UIScrollView *)[self viewWithTag:self.page+100-1]; //后一页
    if (scollV_pre.zoomScale != 1.0){
        scollV_pre.zoomScale = 1.0;
    }
}

@end
