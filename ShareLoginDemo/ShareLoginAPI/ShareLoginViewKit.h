//
//  ShareLoginViewKit.h
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/7.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareComClient.h"

@interface ShareLoginViewKit : UIView

@property(assign, nonatomic) void (^loginCallBack)(NSString *tokenKey, NSString *accessToken, NSString *uid, id<ShareComProto>shareCom, NSError *err);

@end
