//
//  UIButton+KTJNightVersion.h
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTJNightVersion.h"

@interface UIButton (KTJNightVersion) <KTJNightVersionChangeColorProtocol>

/**
 *  night title color and forState:UIControlStateNormal
 */
@property (nonatomic, strong) UIColor *ktj_nightTitleColor;
/**
 *  normal title color and forState:UIControlStateNormal
 */
@property (nonatomic, strong) UIColor *ktj_normalTitleColor;

@property (nonatomic, strong) UIImage *ktj_normalImage;
@property (nonatomic, strong) UIImage *ktj_NightImage;

@property (nonatomic, strong) UIImage *ktj_normalBackgroudImage;
@property (nonatomic, strong) UIImage *ktj_nightBackgroudImage;

@end
