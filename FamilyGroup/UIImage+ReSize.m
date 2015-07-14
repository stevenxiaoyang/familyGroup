//
//  UIImage+ReSize.m
//  MyFamily
//
//  Created by 陆洋 on 15/6/11.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import "UIImage+ReSize.h"

@implementation UIImage (ReSize)
-(UIImage *)reSizeImagetoSize:(CGSize)reSize   
{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(reSize.width, reSize.height),NO,0.0);
    
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return reSizeImage;
    

}
@end
