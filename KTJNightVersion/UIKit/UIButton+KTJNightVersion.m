//
//  UIButton+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UIButton+KTJNightVersion.h"
#import "KTJNightVersionMacro.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UIButton (KTJNightVersion)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KTJChangeIMP(@selector(setTitleColor:forState:), @selector(ktjhook_setTitleColor:forState:));
    });
}
- (void)ktjhook_setTitleColor:(UIColor *)titleColor forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        self.ktj_normalTitleColor = titleColor;
    }
    [self ktjhook_setTitleColor:titleColor forState:state];
}

- (void)setKtj_nightTitleColor:(UIColor *)ktj_nightTitleColor {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [self ktjhook_setTitleColor:ktj_nightTitleColor forState:UIControlStateNormal];
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightTitleColor), ktj_nightTitleColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_nightTitleColor {
    return objc_getAssociatedObject(self, @selector(ktj_nightTitleColor))?:self.ktj_normalTitleColor;
}

- (void)setKtj_normalTitleColor:(UIColor *)ktj_normalTitleColor {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        [self ktjhook_setTitleColor:ktj_normalTitleColor forState:UIControlStateNormal];
    }
    
    [self ktj_saveNormalTitleColor:ktj_normalTitleColor];
}
- (UIColor *)ktj_normalTitleColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalTitleColor))?:[self titleColorForState:UIControlStateNormal];
}
- (void)ktj_saveNormalTitleColor:(UIColor *)titleColor {
    objc_setAssociatedObject(self, @selector(ktj_normalTitleColor), titleColor, OBJC_ASSOCIATION_RETAIN);
}


- (BOOL)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    if ([super respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
        if ([super ktj_changeColorWithAnimation:animation duration:duration]) {
            KTJNightVersionStyle style = [KTJNightVersion currentStyle];
            UIColor *titleColor;
            switch (style) {
                case KTJNightVersionStyleNormal:
                    titleColor = self.ktj_normalTitleColor;
                    break;
                    
                case KTJNightVersionStyleNight:
                    titleColor = self.ktj_nightTitleColor;
                    break;
                    
                default:
                    titleColor = [self titleColorForState:UIControlStateNormal];
                    break;
            }
            JGWeak(self);
            void (^changeColor)(void) = ^(void) {
                [weakself ktjhook_setTitleColor:titleColor forState:UIControlStateNormal];
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
