//
//  UINavigationBar+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UINavigationBar+KTJNightVersion.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UINavigationBar (KTJNightVersion)

- (void)setKtj_nightBarTintColor:(UIColor *)ktj_nightBarTintColor {
    if (ktj_nightBarTintColor == self.ktj_nightBarTintColor) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        self.barTintColor = ktj_nightBarTintColor;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightBarTintColor), ktj_nightBarTintColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_nightBarTintColor {
    return objc_getAssociatedObject(self, @selector(ktj_nightBarTintColor));
}
- (void)setKtj_normalBarTintColor:(UIColor *)ktj_normalBarTintColor {
    if (ktj_normalBarTintColor == self.ktj_normalBarTintColor) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        self.barTintColor = ktj_normalBarTintColor;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_normalBarTintColor), ktj_normalBarTintColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_normalBarTintColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalBarTintColor));
}

- (void)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    if ([KTJNightVersion shouldChangeColor:self]) {
        KTJNightVersionStyle style = [KTJNightVersion currentStyle];
        UIColor *tintColor;
        UIColor *barTintColor;
        UIColor *backgroundColor;
        switch (style) {
            case KTJNightVersionStyleNormal:
                tintColor = self.ktj_normalTintColor;
                barTintColor = self.ktj_normalBarTintColor;
                backgroundColor = self.ktj_normalBackgroudColor;
                break;
                
            case KTJNightVersionStyleNight:
                tintColor = self.ktj_nightTintColor;
                barTintColor = self.ktj_nightBarTintColor;
                backgroundColor = self.ktj_nightBackgroudColor;
                break;
                
            default:
                tintColor = self.tintColor;
                barTintColor = self.barTintColor;
                backgroundColor = self.backgroundColor;
                break;
        }
        JGWeak(self);
        void (^changeColor)(void) = ^(void) {
            weakself.tintColor = tintColor;
            weakself.barTintColor = barTintColor;
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
