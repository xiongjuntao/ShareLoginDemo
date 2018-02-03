//
//  ShareComProto.h
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/6.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShareConfig.h"

@protocol ShareComProto <NSObject>

//组件初始化
- (BOOL)isShareComShow;
- (BOOL)shareSetup;
- (BOOL)shareOpenURL:(NSURL *)url;

//登录和绑定
- (BOOL)isComCanLogin;
- (NSString *)getLoginType;
- (void)shareLogin:(void (^)(NSString *tokenKey, NSString *accessToken, NSString *uid, id<ShareComProto>shareCom, NSError *err))block;

//分享
- (NSArray *)getShareType;
- (void)share:(NSString *)title andDesc:(NSString *)desc andImg:(NSData *)img andUrl:(NSString *)url andShareType:(NSString *)snsName;

@end
