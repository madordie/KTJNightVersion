//
//  UIView+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UIView+KTJNightVersion.h"
#import "KTJNightVersion.h"
#import <objc/runtime.h>

@implementation UIView (KTJNightVersion)

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
    return objc_getAssociatedObject(self, @selector(ktj_nightBackgroudColor));
}

- (void)setKtj_normalBackgroudColor:(UIColor *)ktj_normalBackgroudColor {
    if (ktj_normalBackgroudColor == [self ktj_normalBackgroudColor]) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        self.backgroundColor = ktj_normalBackgroudColor;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_normalBackgroudColor), ktj_normalBackgroudColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_normalBackgroudColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalBackgroudColor));
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
    return objc_getAssociatedObject(self, @selector(ktj_nightTintColor));
}

- (void)setKtj_normalTintColor:(UIColor *)ktj_normalTintColor {
    if (ktj_normalTintColor == [self ktj_normalTintColor]) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        self.tintColor = ktj_normalTintColor;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_normalTintColor), ktj_normalTintColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_normalTintColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalTintColor));
}

- (void)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
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
        
    }
}

@end
