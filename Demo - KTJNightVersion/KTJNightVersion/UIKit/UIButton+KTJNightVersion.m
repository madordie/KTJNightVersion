//
//  UIButton+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UIButton+KTJNightVersion.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UIButton (KTJNightVersion)

- (void)setKtj_nightTitleColor:(UIColor *)ktj_nightTitleColor {
    if (ktj_nightTitleColor == self.ktj_nightTitleColor) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [self setTitleColor:ktj_nightTitleColor forState:UIControlStateNormal];
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightTitleColor), ktj_nightTitleColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_nightTitleColor {
    return objc_getAssociatedObject(self, @selector(ktj_nightTitleColor));
}

- (void)setKtj_normalTitleColor:(UIColor *)ktj_normalTitleColor {
    if (ktj_normalTitleColor == self.ktj_normalTitleColor) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        [self setTitleColor:ktj_normalTitleColor forState:UIControlStateNormal];
    }
    
    objc_setAssociatedObject(self, @selector(ktj_normalTitleColor), ktj_normalTitleColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_normalTitleColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalTitleColor));
}


- (void)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    if ([KTJNightVersion shouldChangeColor:self]) {
        KTJNightVersionStyle style = [KTJNightVersion currentStyle];
        UIColor *titleColor;
        UIColor *backgroundColor;
        UIColor *tintColor;
        switch (style) {
            case KTJNightVersionStyleNormal:
                titleColor = self.ktj_normalTitleColor;
                backgroundColor = self.ktj_normalBackgroudColor;
                tintColor = self.ktj_normalTintColor;
                break;
                
            case KTJNightVersionStyleNight:
                titleColor = self.ktj_nightTitleColor;
                backgroundColor = self.ktj_nightBackgroudColor;
                tintColor = self.ktj_nightTintColor;
                break;
                
            default:
                titleColor = [self titleColorForState:UIControlStateNormal];
                backgroundColor = self.backgroundColor;
                tintColor = self.tintColor;
                break;
        }
        JGWeak(self);
        void (^changeColor)(void) = ^(void) {
            [weakself setTitleColor:titleColor forState:UIControlStateNormal];
            weakself.backgroundColor = backgroundColor;
        };
        if (animation) {
            [UIView animateWithDuration:duration animations:changeColor];
        } else {
            changeColor();
        }
        
    }
}

@end
