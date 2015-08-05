//
//  UILabel+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UILabel+KTJNightVersion.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UILabel (KTJNightVersion)

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
    return objc_getAssociatedObject(self, @selector(ktj_nightTextColor));
}

- (void)setKtj_normalTextColor:(UIColor *)ktj_normalTextColor {
    if (ktj_normalTextColor == self.ktj_normalTextColor) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        self.textColor = ktj_normalTextColor;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_normalTextColor), ktj_normalTextColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_normalTextColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalTextColor));
}


- (void)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    if ([KTJNightVersion shouldChangeColor:self]) {
        KTJNightVersionStyle style = [KTJNightVersion currentStyle];
        UIColor *textColor;
        UIColor *backgroundColor;
        UIColor *tintColor;
        switch (style) {
            case KTJNightVersionStyleNormal:
                textColor = self.ktj_normalTextColor;
                backgroundColor = self.ktj_normalBackgroudColor;
                tintColor = self.ktj_normalTintColor;
                break;
                
            case KTJNightVersionStyleNight:
                textColor = self.ktj_nightTextColor;
                backgroundColor = self.ktj_nightBackgroudColor;
                tintColor = self.ktj_nightTintColor;
                break;
                
            default:
                textColor = self.textColor;
                backgroundColor = self.backgroundColor;
                tintColor = self.tintColor;
                break;
        }
        JGWeak(self);
        void (^changeColor)(void) = ^(void) {
            weakself.textColor = textColor;
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
