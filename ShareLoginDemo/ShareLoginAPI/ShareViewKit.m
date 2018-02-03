//
//  ShareViewKit.m
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/6.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import "ShareViewKit.h"
#import "ShareButton.h"

//屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//颜色RGB
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ShareViewKit ()
{
    UILabel *titleLabel;
    UIScrollView *shareScrollView;
    UIButton *cancleBtn;
    
    NSDictionary *shareViews;
    NSMutableArray *sumShareComsTag;
    NSMutableArray *sumShareComs;
}

@end

@implementation ShareViewKit

- (instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, kScreenHeight-150, kScreenWidth, 150);
    self = [super initWithFrame:frame];
    if (self) {
        
        shareViews = SHARE_VIEW;
        NSArray *shareComs = [[ShareComClient instance] getShareComs];
        sumShareComsTag = [[NSMutableArray alloc] init];
        sumShareComs = [[NSMutableArray alloc] init];
        for (id<ShareComProto>com in shareComs) {
            for (NSString *shareTag in [com getShareType]) {
                [sumShareComsTag addObject:shareTag];
                [sumShareComs addObject:com];
            }
        }
        
        self.backgroundColor =[[UIColor whiteColor] colorWithAlphaComponent:1.0];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 49)];
        imageView.image = [UIImage imageNamed:SHARE_LINE];
        [self addSubview:imageView];
        titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        shareScrollView = [[UIScrollView alloc]init];
        [self addSubview:shareScrollView];
        cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return self;
}

/**
 *  子控件frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    titleLabel.frame = CGRectMake(25, 17, kScreenWidth-50, 17);
    titleLabel.text = @"分享到";
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    titleLabel.textColor = UIColorFromRGB(0x666666);
    
    shareScrollView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+10, self.frame.size.width, self.frame.size.height-44);
    shareScrollView.showsHorizontalScrollIndicator = NO;
    
    cancleBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [cancleBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self configShare];
    
}

/**
 *  添加分享面板
 */
- (void)configShare
{
    CGFloat sepWidth = 10;
    for (int i = 0; i < sumShareComs.count; i++) {
        NSString *imageStr = shareViews[sumShareComsTag[i]][1];
        NSString *titleStr = shareViews[sumShareComsTag[i]][0];
        CGFloat w = 60;
        CGFloat h = w+20;
        ShareButton *btn = [[ShareButton alloc]initWithFrame:CGRectMake(17.5+(w+sepWidth)*i, 0, w, h)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        [btn setTitle:titleStr forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [shareScrollView addSubview:btn];
        
        if (i==sumShareComs.count-1) {
            shareScrollView.contentSize = CGSizeMake(btn.frame.origin.x + btn.frame.size.width + 20, 0);
        }
    }
    [self bringSubviewToFront:shareScrollView];
}


- (void)share:(ShareButton *)btn
{
    //第三方分享
    NSInteger index = btn.tag;
    
    id<ShareComProto>com = sumShareComs[index];
    NSString *snsName = sumShareComsTag[index];
    
    if (com && snsName) {
        [[ShareComClient instance] share:com andTitle:_title andDesc:_desc andImg:_image andUrl:_url andShareType:snsName];
    }
    
    [self hidden];
}

- (void)cancel:(ShareButton *)btn
{
    [self hidden];
}

- (void)appear
{
    CGRect rect = self.frame;
    rect.origin.y = kScreenHeight;
    self.frame = rect;
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:cancleBtn];
    [window addSubview:self];
    [UIView animateWithDuration:.2f animations:^{
        CGRect rect = self.frame;
        rect.origin.y = kScreenHeight - self.frame.size.height;
        self.frame = rect;
        cancleBtn.alpha = 0.5;
    }];
}

- (void)hidden
{
    [UIView animateWithDuration:.2f animations:^{
        CGRect rect = self.frame;
        rect.origin.y = kScreenHeight;
        self.frame = rect;
        cancleBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [cancleBtn removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
