//
//  UIImageView+KTJNightVersion.h
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTJNightVersion.h"

@interface UIImageView (KTJNightVersion) <KTJNightVersionChangeColorProtocol>

@property (nonatomic, strong) UIImage *ktj_nightImage;
@property (nonatomic, strong) UIImage *ktj_normalImage;

@end
