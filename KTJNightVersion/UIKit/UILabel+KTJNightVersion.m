//
//  UILabel+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UILabel+KTJNightVersion.h"
#import "KTJNightVersionMacro.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UILabel (KTJNightVersion)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KTJChangeIMP(@selector(setTextColor:), @selector(ktjhook_setTextColor:));
    });
}
- (void)ktjhook_setTextColor:(UIColor *)textColor {
    if (!self.ktj_normalTextColor) {
        [self ktj_saveNormalTextColor:textColor];
    }
    [self ktjhook_setTextColor:textColor];
}

- (void)setKtj_nightTextColor:(UIColor *)ktj_nightTextColor {
    if (ktj_nightTextColor == self.ktj_nightTextColor) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        self.textColor = ktj_nightTextColor;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightTextColor), ktj_nightTextColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_nightTextColor {
    return objc_getAssociatedObject(self, @selector(ktj_nightTextColor))?:self.textColor;
}

- (void)setKtj_normalTextColor:(UIColor *)ktj_normalTextColor {
    if (ktj_normalTextColor == self.ktj_normalTextColor) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        self.textColor = ktj_normalTextColor;
    }
    
    [self ktj_saveNormalTextColor:ktj_normalTextColor];
}
- (UIColor *)ktj_normalTextColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalTextColor))?:self.textColor;
}
- (void)ktj_saveNormalTextColor:(UIColor *)textColor {
    objc_setAssociatedObject(self, @selector(ktj_normalTextColor), textColor, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    if ([super respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
        if ([super ktj_changeColorWithAnimation:animation duration:duration]) {
            KTJNightVersionStyle style = [KTJNightVersion currentStyle];
            UIColor *textColor;
            switch (style) {
                case KTJNightVersionStyleNormal:
                    textColor = self.ktj_normalTextColor;
                    break;
                    
                case KTJNightVersionStyleNight:
                    textColor = self.ktj_nightTextColor;
                    break;
                    
                default:
                    textColor = self.textColor;
                    break;
            }
            JGWeak(self);
            void (^changeColor)(void) = ^(void) {
                weakself.textColor = textColor;
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
