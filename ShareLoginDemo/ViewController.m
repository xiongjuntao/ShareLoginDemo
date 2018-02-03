//
//  ViewController.m
//  ShareLoginDemo
//
//  Created by WEICHANG CHEN on 2017/3/21.
//  Copyright © 2017年 WEICHANG CHEN. All rights reserved.
//

#import "ViewController.h"
#import "ShareAPI.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view =  [ShareAPI loginOrBind:^(NSString *tokenKey, NSString *acessToken, NSString *uid, id<ShareComProto> shareCom, NSError *err) {
        if ([[shareCom getLoginType] isEqualToString:LOGIN_QQ]) {
            
        }else if ([[shareCom getLoginType] isEqualToString:LOGIN_SINA]){
            
        }
    }];
    
    view.frame = CGRectMake(0, 100, 300, 44);
    [self.view addSubview:view];
}

- (IBAction)clickShareButton:(UIButton *)sender {
    
    UIImage *img = [UIImage imageNamed:@"logo"];
    NSData *data = UIImageJPEGRepresentation(img, 0.5);
    [ShareAPI share:@"123" andDesc:@"123" andImg:data andUrl:@"123"];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
