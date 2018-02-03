//
//  QQCom.m
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/6.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import "QQCom.h"

@interface QQCom () <TencentLoginDelegate>
{
    TencentOAuth *tencentOAuth;
    void (^loginBlock)(NSString *tokenKey, NSString *accessToken, NSString *uid, id<ShareComProto>shareCom, NSError *err);
}

@end

@implementation QQCom

//组件初始化
- (BOOL)isShareComShow
{
    return [TencentOAuth iphoneQQInstalled];
}
- (BOOL)shareSetup
{
    //没有设置
    return YES;
}
- (BOOL)shareOpenURL:(NSURL *)url
{
    NSString *absoluteUrlStr = [url absoluteString];
    if([absoluteUrlStr rangeOfString:QQ_APPID].location != NSNotFound)
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    return NO;
}

//登录和绑定
- (BOOL)isComCanLogin
{
    return YES;
}
- (NSString *)getLoginType
{
    return LOGIN_QQ;
}
- (void)shareLogin:(void (^)(NSString *, NSString *, NSString *, id<ShareComProto>, NSError *))block
{
    loginBlock = block;
    // QQ登录
    tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQ_APPID andDelegate:(id<TencentSessionDelegate>)self];
    [tencentOAuth authorize:@[kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO]];
}

//分享
- (NSArray *)getShareType
{
    return @[SHARE_QQ];
}
- (void)share:(NSString *)title andDesc:(NSString *)desc andImg:(NSData *)img andUrl:(NSString *)url andShareType:(NSString *)snsName
{
    tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQ_APPID
                                                andDelegate:(id<TencentSessionDelegate>)self];
    QQApiNewsObject *message = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:desc previewImageData:img];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:message];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            
            NSLog(@"%@", @"App未注册");
            
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            
            NSLog(@"%@", @"发送参数错误");
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            
            NSLog(@"%@", @"未安装手Q");
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            
            NSLog(@"%@", @"API接口不支持");
            
            break;
        }
        case EQQAPISENDFAILD:
        {
            
            NSLog(@"%@", @"发送失败");
            
            break;
        }
        case EQQAPIVERSIONNEEDUPDATE:
        {
            
            NSLog(@"%@", @"当前QQ版本太低，需要更新");
            break;
        }
        default:
        {
            break;
        }
    }
}


#pragma mark 回调

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"%@", @"登录失败");
}

- (void)tencentDidLogin
{
    if (tencentOAuth.accessToken && [tencentOAuth.accessToken length] && loginBlock) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            loginBlock(tencentOAuth.accessToken, tencentOAuth.accessToken ,tencentOAuth.openId, self, nil);
        });
    }
}

- (void)tencentDidNotNetWork
{
    NSLog(@"%@", @"请检查网络");
}

@end
