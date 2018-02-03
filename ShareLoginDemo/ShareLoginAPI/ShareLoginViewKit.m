//
//  ShareLoginViewKit.m
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/7.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import "ShareLoginViewKit.h"

@interface ShareLoginViewKit ()
{
    NSMutableArray *shareButtons;
    NSDictionary *loginViews;
    NSArray *loginComs;
}

@end

@implementation ShareLoginViewKit

- (instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-44)/2+100, [UIScreen mainScreen].bounds.size.width, 44);
    if (self = [super initWithFrame:frame]) {
        //
        loginViews = LOGIN_VIEW;
        loginComs = [[ShareComClient instance] getLoginComs];
        [self setupButtons];
    }
    return self;
}

- (void)setupButtons
{
    for (UIButton *btn in shareButtons) {
        [btn removeFromSuperview];
    }
    [shareButtons removeAllObjects];
    
    for (id<ShareComProto>com in loginComs) {
        //
        NSInteger index = [loginComs indexOfObject:com];
        NSArray *comView = [loginViews objectForKey:[com getLoginType]];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:comView[1]] forState:UIControlStateNormal];
        btn.tag = index;
        btn.frame = CGRectMake((CGRectGetWidth(self.frame)-(CGRectGetHeight(self.frame)+10)*loginComs.count-10)/2+(CGRectGetHeight(self.frame)+10)*index, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
        [btn addTarget:self action:@selector(shareLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [shareButtons addObject:btn];
    }
}

- (void)shareLogin:(UIButton *)btn
{
    NSInteger index = btn.tag;
    
    id<ShareComProto>com = loginComs[index];
    if (com && _loginCallBack) {
        [[ShareComClient instance] loginOrBind:com andBlock:_loginCallBack];
    }
}

@end
