//
//  SinaCom.m
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/6.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import "SinaCom.h"

@interface SinaCom () <WeiboSDKDelegate>
{
    void (^loginBlock)(NSString *tokenKey, NSString *accessToken, NSString *uid, id<ShareComProto>shareCom, NSError *err);
}

@end

@implementation SinaCom

//组件初始化
- (BOOL)isShareComShow
{
    return [WeiboSDK isWeiboAppInstalled] || YES;
}
- (BOOL)shareSetup
{
    [WeiboSDK enableDebugMode:YES];
    return [WeiboSDK registerApp:SINA_APPID];
}
- (BOOL)shareOpenURL:(NSURL *)url
{
    NSString *absoluteUrlStr = [url absoluteString];
    if ([absoluteUrlStr rangeOfString:SINA_APPID].location != NSNotFound)
    {
        return [WeiboSDK handleOpenURL:url delegate:self];
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
    return LOGIN_SINA;
}
- (void)shareLogin:(void (^)(NSString *, NSString *, NSString *, id<ShareComProto>, NSError *))block
{
    loginBlock = block;
    // 新浪微博登录
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = SINA_REDIRECTURI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

//分享
- (NSArray *)getShareType
{
    return @[SHARE_SINA];
}
- (void)share:(NSString *)title andDesc:(NSString *)desc andImg:(NSData *)img andUrl:(NSString *)url andShareType:(NSString *)snsName
{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.scope = @"all";
    unsigned long sumLen = title.length+desc.length+url.length;
    if (sumLen > 120) {
        unsigned long sep = sumLen - 120;
        desc = [desc substringToIndex:(desc.length-sep)];
    }
    WBMessageObject *message = [WBMessageObject message];
    message.text = [NSString stringWithFormat:@"爱家家分享：%@ %@ ☞%@",title,desc,url];
    WBImageObject *imageObj = [WBImageObject object];
    imageObj.imageData = img;
    message.imageObject = imageObj;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    [WeiboSDK sendRequest:request];
}


#pragma mark 回调

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        WBAuthorizeResponse *authResponse = (WBAuthorizeResponse *)response;
        if (authResponse.userID && loginBlock) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                loginBlock(authResponse.accessToken, authResponse.accessToken, authResponse.userID, self, nil);
            });
        }
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    NSLog(@"%@", @"开始请求");
}

@end
