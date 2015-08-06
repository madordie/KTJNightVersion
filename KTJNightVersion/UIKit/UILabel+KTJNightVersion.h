//
//  UILabel+KTJNightVersion.h
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTJNightVersion.h"

@interface UILabel (KTJNightVersion) <KTJNightVersionChangeColorProtocol>

@property (nonatomic, strong) UIColor *ktj_nightTextColor;
@property (nonatomic, strong) UIColor *ktj_normalTextColor;

@end
