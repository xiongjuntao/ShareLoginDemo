//
//  ShareUtil.h
//  iFuWoFamilyiPhone
//
//  Created by arvin on 2017/3/10.
//  Copyright © 2017年 com.ifuwo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShareAPI.h"

@interface ShareUtil : NSObject

+ (void)share:(NSString *)url andTitle:(NSString *)title  andDesc:(NSString *)desc andIcon:(UIImage *)image andView:(UIViewController *)controller;

@end
