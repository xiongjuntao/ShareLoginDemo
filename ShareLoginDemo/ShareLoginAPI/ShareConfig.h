//
//  ShareConfig.h
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/6.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#ifndef ShareConfig_h
#define ShareConfig_h

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import "WeiboSDK.h"
#import "WXApi.h"

#define WX_APPID            @"wx969ddc42642e4847"
#define WX_APPSECRET        @"ff9ffe0f34d6f3d08e2e1abec7f61ded"
#define QQ_APPID            @"1105731428"
#define SINA_APPID          @"1611786616"
#define SINA_REDIRECTURI    @"http://www.weibo.com"

#define LOGIN_SINA          @"1"
#define LOGIN_WECHAT        @"10"
#define LOGIN_QQ            @"5"//7


#define SHARE_SINA          @"sina"
#define SHARE_WECHAT_S      @"wechat_session"
#define SHARE_WECHAT_T      @"wechat_timeline"
#define SHARE_QQ            @"qq"


#define SHARECOMS           @[@"WechatCom", @"QQCom", @"SinaCom"]

#define LOGIN_VIEW          @{LOGIN_SINA:@[@"微博", @"icon_weibo.png"], LOGIN_WECHAT:@[@"微信", @"icon_weixinghaoyou.png"], LOGIN_QQ:@[@"QQ", @"icon_QQ.png"]}
#define SHARE_VIEW          @{SHARE_SINA:@[@"微博", @"icon_weibo.png"], SHARE_WECHAT_S:@[@"微信好友", @"icon_weixinghaoyou.png"], SHARE_WECHAT_T:@[@"朋友圈", @"icon_pengyouquan.png"], SHARE_QQ:@[@"QQ", @"icon_QQ.png"]}
#define SHARE_LINE          @"icon_m"

#define LOGINVIEWKIT        @"ShareLoginViewKit"
#define SHAREVIEWKIT        @"ShareViewKit"

#endif /* ShareConfig_h */
