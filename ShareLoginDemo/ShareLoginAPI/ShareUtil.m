//
//  ShareUtil.m
//  iFuWoFamilyiPhone
//
//  Created by arvin on 2017/3/10.
//  Copyright © 2017年 com.ifuwo. All rights reserved.
//

#import "ShareUtil.h"

@implementation ShareUtil

+ (void)share:(NSString *)url andTitle:(NSString *)title  andDesc:(NSString *)desc andIcon:(UIImage *)image andView:(UIViewController *)controller
{
    NSData *imageData = UIImagePNGRepresentation(image);
    [ShareAPI share:title andDesc:desc andImg:imageData andUrl:url];
}

@end
