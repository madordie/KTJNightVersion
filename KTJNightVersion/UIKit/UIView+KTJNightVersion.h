//
//  UIView+KTJNightVersion.h
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTJNightVersion.h"

@interface UIView (KTJNightVersion) <KTJNightVersionChangeColorProtocol>

@property (nonatomic, strong) UIColor *ktj_nightBackgroudColor;
@property (nonatomic, strong) UIColor *ktj_normalBackgroudColor;

@property (nonatomic, strong) UIColor *ktj_nightTintColor;
@property (nonatomic, strong) UIColor *ktj_normalTintColor;

@end

#warning BUG LIST.

#if 0

1.  如果不设置 ktj_normal*
    夜间模式 -> 白天模式：默认读取self.*，污读。其实该数值为夜间模式的样式。

    解决办法：
        监听self.*
            如果ktj_normal*有值 -> 设置到self.*
            如果ktj_normal*空  -> 设置到ktj_normal*
        删除  ?:self.*

2.  无继承设置 - (void)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration;

    解决办法:
        顶级继承样式参考 UIView

#endif