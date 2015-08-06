//
//  UINavigationBar+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UINavigationBar+KTJNightVersion.h"
#import "KTJNightVersionMacro.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UINavigationBar (KTJNightVersion)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KTJChangeIMP(@selector(setBarTintColor:), @selector(ktjhook_setBarTintColor:));
    });
}

- (void)ktjhook_setBarTintColor:(UIColor *)barTintColor {
    if (!self.ktj_normalBarTintColor) {
        [self ktj_saveNormalBarTintColor:barTintColor];
    }
    [self ktjhook_setBarTintColor:barTintColor];
}

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
    return objc_getAssociatedObject(self, @selector(ktj_nightBarTintColor))?:self.barTintColor;
}
- (void)setKtj_normalBarTintColor:(UIColor *)ktj_normalBarTintColor {
    if (ktj_normalBarTintColor == self.ktj_normalBarTintColor) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        self.barTintColor = ktj_normalBarTintColor;
    }
    
    [self ktj_saveNormalBarTintColor:ktj_normalBarTintColor];
}
- (UIColor *)ktj_normalBarTintColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalBarTintColor))?:self.barTintColor;
}
- (void)ktj_saveNormalBarTintColor:(UIColor *)barTintColor {
    objc_setAssociatedObject(self, @selector(ktj_normalBarTintColor), barTintColor, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    if ([super respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
        if ([super ktj_changeColorWithAnimation:animation duration:duration]) {
            KTJNightVersionStyle style = [KTJNightVersion currentStyle];
            UIColor *barTintColor;
            switch (style) {
                case KTJNightVersionStyleNormal:
                    barTintColor = self.ktj_normalBarTintColor;
                    break;
                    
                case KTJNightVersionStyleNight:
                    barTintColor = self.ktj_nightBarTintColor;
                    break;
                    
                default:
                    barTintColor = self.barTintColor;
                    break;
            }
            JGWeak(self);
            void (^changeColor)(void) = ^(void) {
                weakself.barTintColor = barTintColor;
            };
            if (animation) {
                [UIView animateWithDuration:duration animations:changeColor];
            } else {
                changeColor();
            }
            
            return YES;
        }
    }
    return NO;
}
@end
