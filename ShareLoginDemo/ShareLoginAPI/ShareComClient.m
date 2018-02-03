//
//  ShareComClient.m
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/7.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import "ShareComClient.h"

@interface ShareComClient ()
{
    NSArray *comArr;
}

@end

@implementation ShareComClient

- (NSArray *)createShareComs
{
    NSArray *comNameArr = SHARECOMS;
    if (comNameArr.count) {
        NSMutableArray *shareComs = [[NSMutableArray alloc] initWithCapacity:comNameArr.count];
        for (NSString *name in comNameArr) {
            id<ShareComProto> com = [[NSClassFromString(name) alloc] init];
            [com shareSetup];
            if ([com isShareComShow]) {
                [shareComs addObject:com];
            }
        }
        return shareComs;
    }
    return nil;
}

- (instancetype)init
{
    if (self = [super init]) {
        //
        comArr = [self createShareComs];
    }
    return self;
}

+ (instancetype)instance
{
    static ShareComClient *shareComClientInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareComClientInstance = [[ShareComClient alloc] init];
    });
    return shareComClientInstance;
}

- (BOOL)shareOpenURL:(NSURL *)url
{
    for (id<ShareComProto>com in comArr) {
        if ([com shareOpenURL:url]) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)getLoginComs
{
    NSMutableArray *loginComs = [[NSMutableArray alloc] init];
    for (id<ShareComProto>com in comArr) {
        //添加过滤条件
        if ([com isComCanLogin]) {
            [loginComs addObject:com];
        }
    }
    if (loginComs.count) {
        return loginComs;
    }
    return nil;
}

- (NSArray *)getShareComs
{
    NSMutableArray *shareComs = [[NSMutableArray alloc] init];
    for (id<ShareComProto>com in comArr) {
        //添加过滤条件
        [shareComs addObject:com];
    }
    if (shareComs.count) {
        return shareComs;
    }
    return nil;
}

- (void)loginOrBind:(id<ShareComProto>)shareCom andBlock:(void (^)(NSString *tokenKey, NSString *accessToken, NSString *uid, id<ShareComProto>shareCom, NSError *err))block
{
    if (shareCom && block) {
        [shareCom shareLogin:block];
    }
}

- (void)share:(id<ShareComProto>)shareCom andTitle:(NSString *)title andDesc:(NSString *)desc andImg:(NSData *)img andUrl:(NSString *)url andShareType:(NSString *)snsName
{
    if (shareCom) {
        [shareCom share:title andDesc:desc andImg:img andUrl:url andShareType:snsName];
    }
}

@end
