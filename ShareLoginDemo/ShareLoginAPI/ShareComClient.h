//
//  ShareComClient.h
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/7.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareComProto.h"

@interface ShareComClient : NSObject

+ (instancetype)instance;
- (BOOL)shareOpenURL:(NSURL *)url;
- (NSArray *)getLoginComs;
- (NSArray *)getShareComs;
- (void)loginOrBind:(id<ShareComProto>)shareCom andBlock:(void (^)(NSString *tokenKey, NSString *acessToken, NSString *uid, id<ShareComProto>shareCom, NSError *err))block;
- (void)share:(id<ShareComProto>)shareCom andTitle:(NSString *)title andDesc:(NSString *)desc andImg:(NSData *)img andUrl:(NSString *)url andShareType:(NSString *)snsName;

@end
