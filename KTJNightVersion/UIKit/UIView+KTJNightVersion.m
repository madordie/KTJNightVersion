//
//  UIView+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UIView+KTJNightVersion.h"
#import "KTJNightVersionMacro.h"
#import "KTJNightVersion.h"
#import <objc/runtime.h>

@implementation UIView (KTJNightVersion)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KTJChangeIMP(@selector(setBackgroundColor:), @selector(ktjhook_setBackgroundColor:));
        KTJChangeIMP(@selector(setTintColor:), @selector(ktjhook_setTintColor:));
    });
}

- (void)ktjhook_setBackgroundColor:(UIColor*)backgroundColor {
    if (!self.ktj_normalBackgroudColor) {
        [self ktj_saveNormalBackgroudColor:backgroundColor];
    }
    [self ktjhook_setBackgroundColor:backgroundColor];
}
- (void)ktjhook_setTintColor:(UIColor *)tintColor {
    if (!self.ktj_normalTintColor) {
        [self ktj_saveNormalTintColor:tintColor];
    }
    [self ktjhook_setTintColor:tintColor];
}

- (void)setKtj_nightBackgroudColor:(UIColor *)ktj_nightBackgroudColor {
    if (ktj_nightBackgroudColor == [self ktj_nightBackgroudColor]) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        self.backgroundColor = ktj_nightBackgroudColor;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightBackgroudColor), ktj_nightBackgroudColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_nightBackgroudColor {
    return objc_getAssociatedObject(self, @selector(ktj_nightBackgroudColor))?:self.backgroundColor;
}

- (void)setKtj_normalBackgroudColor:(UIColor *)ktj_normalBackgroudColor {
    if (ktj_normalBackgroudColor == [self ktj_normalBackgroudColor]) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        self.backgroundColor = ktj_normalBackgroudColor;
    }
    [self ktj_saveNormalBackgroudColor:ktj_normalBackgroudColor];
}
- (UIColor *)ktj_normalBackgroudColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalBackgroudColor))?:self.backgroundColor;
}
- (void)ktj_saveNormalBackgroudColor:(UIColor *)backgroudColor {
    objc_setAssociatedObject(self, @selector(ktj_normalBackgroudColor), backgroudColor, OBJC_ASSOCIATION_RETAIN);
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
        UIColor *backgroundColor;
        UIColor *tintColor;
        switch (style) {
            case KTJNightVersionStyleNormal:
                backgroundColor = self.ktj_normalBackgroudColor;
                tintColor = self.ktj_normalTintColor;
                break;
                
            case KTJNightVersionStyleNight:
                backgroundColor = self.ktj_nightBackgroudColor;
                tintColor = self.ktj_nightTintColor;
                break;
                
            default:
                backgroundColor = self.backgroundColor;
                tintColor = self.tintColor;
                break;
        }
        JGWeak(self);
        void (^changeColor)(void) = ^(void) {
            weakself.backgroundColor = backgroundColor;
            weakself.tintColor = tintColor;
        };
        if (animation) {
            [UIView animateWithDuration:duration animations:changeColor];
        } else {
            changeColor();
        }
        
        return YES;
    } else {
        return NO;
    }
}

@end
