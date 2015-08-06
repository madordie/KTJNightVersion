//
//  UIBarButtonItem+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UIBarButtonItem+KTJNightVersion.h"
#import "KTJNightVersionMacro.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (KTJNightVersion)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KTJChangeIMP(@selector(setTintColor:), @selector(ktjhook_setTintColor:));
    });
}
- (void)ktjhook_setTintColor:(UIColor *)tintColor {
    if (!self.ktj_normalTintColor) {
        [self ktj_saveNormalTintColor:tintColor];
    }
    [self ktjhook_setTintColor:tintColor];
}

- (void)setKtj_nightTintColor:(UIColor *)ktj_nightTintColor {
    if (ktj_nightTintColor == [self ktj_nightTintColor]) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        self.tintColor = ktj_nightTintColor;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightTintColor), ktj_nightTintColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_nightTintColor {
    return objc_getAssociatedObject(self, @selector(ktj_nightTintColor))?:self.tintColor;
}

- (void)setKtj_normalTintColor:(UIColor *)ktj_normalTintColor {
    if (ktj_normalTintColor == [self ktj_normalTintColor]) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        self.tintColor = ktj_normalTintColor;
    }
    
    [self ktj_saveNormalTintColor:ktj_normalTintColor];
}
- (UIColor *)ktj_normalTintColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalTintColor))?:self.tintColor;
}
- (void)ktj_saveNormalTintColor:(UIColor *)tintColor {
    objc_setAssociatedObject(self, @selector(ktj_normalTintColor), tintColor, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    if ([KTJNightVersion shouldChangeColor:self]) {
        KTJNightVersionStyle style = [KTJNightVersion currentStyle];
        UIColor *tintColor;
        switch (style) {
            case KTJNightVersionStyleNormal:
                tintColor = self.ktj_normalTintColor;
                break;
                
            case KTJNightVersionStyleNight:
                tintColor = self.ktj_nightTintColor;
                break;
                
            default:
                tintColor = self.tintColor;
                break;
        }
        JGWeak(self);
        void (^changeColor)(void) = ^(void) {
            weakself.tintColor = tintColor;
        };
        if (animation) {
            [UIView animateWithDuration:duration animations:changeColor];
        } else {
            changeColor();
        }
        return YES;
    }
    return NO;
}
@end
