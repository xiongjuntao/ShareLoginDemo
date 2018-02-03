//
//  ShareAPI.h
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/6.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareViewKit.h"
#import "ShareLoginViewKit.h"

@interface ShareAPI : NSObject

+ (UIView *)loginOrBind:(void (^)(NSString *tokenKey, NSString *acessToken, NSString *uid, id<ShareComProto>shareCom, NSError *err))block;
+ (void)share:(NSString *)title andDesc:(NSString *)desc andImg:(NSData *)img andUrl:(NSString *)url;

@end
