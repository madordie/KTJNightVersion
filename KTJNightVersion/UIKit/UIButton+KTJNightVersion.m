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
        KTJChangeIMP(@selector(setImage:forState:), @selector(ktjhook_setImage:forState:));
        KTJChangeIMP(@selector(setBackgroundImage:forState:), @selector(ktjhook_setBackgroudImage:forState:));
    });
}
- (void)ktjhook_setTitleColor:(UIColor *)titleColor forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        self.ktj_normalTitleColor = titleColor;
    }
    [self ktjhook_setTitleColor:titleColor forState:state];
}
- (void)ktjhook_setImage:(UIImage *)image forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        self.ktj_normalImage = image;
    }
    [self ktjhook_setImage:image forState:state];
}
- (void)ktjhook_setBackgroudImage:(UIImage *)image forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        self.ktj_normalBackgroudImage = image;
    }
    [self ktjhook_setBackgroudImage:image forState:state];
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

- (void)setKtj_normalImage:(UIImage *)ktj_normalImage {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        [self ktjhook_setImage:ktj_normalImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(ktj_normalImage), ktj_normalImage, OBJC_ASSOCIATION_RETAIN);
}
- (UIImage *)ktj_normalImage {
    return objc_getAssociatedObject(self, @selector(ktj_normalImage))?:[self imageForState:UIControlStateNormal];
}
- (void)setKtj_NightImage:(UIImage *)ktj_NightImage {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [self ktjhook_setImage:ktj_NightImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(ktj_NightImage), ktj_NightImage, OBJC_ASSOCIATION_RETAIN);
}
- (UIImage *)ktj_NightImage {
    return objc_getAssociatedObject(self, @selector(ktj_NightImage))?:self.ktj_normalImage;
}
- (void)setKtj_normalBackgroudImage:(UIImage *)ktj_normalBackgroudImage {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        [self ktjhook_setBackgroudImage:ktj_normalBackgroudImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(ktj_normalBackgroudImage), ktj_normalBackgroudImage, OBJC_ASSOCIATION_RETAIN);
}
- (UIImage *)ktj_normalBackgroudImage {
    return objc_getAssociatedObject(self, @selector(ktj_normalBackgroudImage))?:[self backgroundImageForState:UIControlStateNormal];
}
- (void)setKtj_nightBackgroudImage:(UIImage *)ktj_nightBackgroudImage {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [self ktjhook_setBackgroudImage:ktj_nightBackgroudImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(ktj_nightBackgroudImage), ktj_nightBackgroudImage, OBJC_ASSOCIATION_RETAIN);
}
- (UIImage *)ktj_nightBackgroudImage {
    return objc_getAssociatedObject(self, @selector(ktj_nightBackgroudImage))?:self.ktj_normalBackgroudImage;
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
