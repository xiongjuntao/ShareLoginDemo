//
//  ShareViewKit.h
//  iFuWoiPhone
//
//  Created by arvin on 2017/2/6.
//  Copyright © 2017年 fuwo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareComClient.h"

@interface ShareViewKit : UIView

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSData *image;
@property (nonatomic, retain) NSString *url;

- (void)appear;
- (void)hidden;

@end
