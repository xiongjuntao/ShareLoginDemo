//
//  ShareButton.m
//  iFuWoiPhone
//
//  Created by arvin on 16/7/18.
//  Copyright © 2016年 fuwo. All rights reserved.
//

#import "ShareButton.h"

@implementation ShareButton


-(CGRect)titleRectForContentRect:(CGRect)contentRect

{
    
    CGFloat titleY = contentRect.size.height * 0.7619 + 4;
    
    CGFloat titleW = contentRect.size.width;
    
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect

{
    
    CGFloat imageW = CGRectGetWidth(contentRect);
    
    CGFloat imageH = contentRect.size.height * 0.7619;
    
    return CGRectMake(0, 0, imageW, imageH);
    
}

@end
