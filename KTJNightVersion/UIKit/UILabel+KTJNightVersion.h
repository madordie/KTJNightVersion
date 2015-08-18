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

/**
 *  说明：如果使用NSAttributedString来更改字体颜色
 *      请明确赋值normal、night，并且如果两个模式一样
 *      如：        label.ktj_nightAttributedSText = label.ktj_normalAttributedText;
 */
@property (nonatomic, strong) NSAttributedString *ktj_normalAttributedText;
@property (nonatomic, strong) NSAttributedString *ktj_nightAttributedSText;


@end
