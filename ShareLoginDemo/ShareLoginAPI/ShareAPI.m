//
//  ShareAPI.m
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/6.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import "ShareAPI.h"

static id shareViewKit = nil;

@implementation ShareAPI

+ (UIView *)loginOrBind:(void (^)(NSString *tokenKey, NSString *accessToken, NSString *uid, id<ShareComProto>shareCom, NSError *err))block
{
    id viewKit = [[NSClassFromString(LOGINVIEWKIT) alloc] initWithFrame:CGRectZero];
    [viewKit setValue:block forKey:@"loginCallBack"];
    return viewKit;
}

+ (void)share:(NSString *)title andDesc:(NSString *)desc andImg:(NSData *)img andUrl:(NSString *)url
{
    if (!shareViewKit) {
        shareViewKit = [[NSClassFromString(SHAREVIEWKIT) alloc] initWithFrame:CGRectZero];
    }
    [shareViewKit setValue:title forKey:@"title"];
    [shareViewKit setValue:desc forKey:@"desc"];
    [shareViewKit setValue:img forKey:@"image"];
    [shareViewKit setValue:url forKey:@"url"];
    [shareViewKit appear];
}

@end
