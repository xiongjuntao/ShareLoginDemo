//
//  WechatCom.m
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/6.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import "WechatCom.h"

@interface WechatCom () <WXApiDelegate>
{
    void (^loginBlock)(NSString *tokenKey, NSString *accessToken, NSString *uid, id<ShareComProto>shareCom, NSError *err);
}

@end

@implementation WechatCom

//组件初始化
- (BOOL)isShareComShow
{
    return [WXApi isWXAppInstalled];
}
- (BOOL)shareSetup
{
    return [WXApi registerApp:WX_APPID];
}
- (BOOL)shareOpenURL:(NSURL *)url
{
    NSString *absoluteUrlStr = [url absoluteString];
    if ([absoluteUrlStr rangeOfString:WX_APPID].location != NSNotFound)
    {
        return [WXApi handleOpenURL:url delegate:self];
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
    return LOGIN_WECHAT;
}
- (void)shareLogin:(void (^)(NSString *, NSString *, NSString *, id<ShareComProto>, NSError *))block
{
    loginBlock = block;
    // 微信登录
    SendAuthReq *req = [SendAuthReq new];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"ifw_wechat_login" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

//分享
- (NSArray *)getShareType
{
    return @[SHARE_WECHAT_T, SHARE_WECHAT_S];
}
- (void)share:(NSString *)title andDesc:(NSString *)desc andImg:(NSData *)img andUrl:(NSString *)url andShareType:(NSString *)snsName
{
    unsigned long sumLen = desc.length;
    if (sumLen > 300) {
        desc = [desc substringToIndex:(300)];
    }
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:[self thumbImage:[UIImage imageWithData:img]]];
    
    WXWebpageObject *webpageObjectr = [WXWebpageObject object];
    webpageObjectr.webpageUrl = url;
    message.mediaObject = webpageObjectr;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    if ([snsName isEqualToString:SHARE_WECHAT_T]) {
        req.scene = WXSceneTimeline;
    }else if([snsName isEqualToString:SHARE_WECHAT_S]){
        req.scene = WXSceneSession;
    }
    req.message = message;
    [WXApi sendReq:req];
}
- (UIImage *)thumbImage:(UIImage *)image
{
    UIGraphicsBeginImageContext(CGSizeMake(50, 50));
    [image drawInRect:CGRectMake(0, 0, 50, 50)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma mark 回调

/*
 access_token	接口调用凭证
 expires_in	access_token接口调用凭证超时时间，单位（秒）
 refresh_token	用户刷新access_token
 openid	授权用户唯一标识
 scope	用户授权的作用域，使用逗号（,）分隔
 unionid	 当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段
 */

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (resp.errCode != 0) {return;}
        
        SendAuthResp *temp = (SendAuthResp *)resp;
        
        NSString *urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WX_APPID,WX_APPSECRET,temp.code];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
        //[request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"GET"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error&&data) {
                NSError *err = nil;
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                if (!err&&result) {
                    if (loginBlock) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            loginBlock(result[@"access_token"], result[@"access_token"], result[@"openid"], self, nil);
                        });
                    }
                }
            }else{
                NSLog(@"error: %@", error);
            }
        }];
        [task resume];
    }
}

@end
