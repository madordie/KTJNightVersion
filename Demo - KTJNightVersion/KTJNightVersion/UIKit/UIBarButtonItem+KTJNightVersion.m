//
//  UIBarButtonItem+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UIBarButtonItem+KTJNightVersion.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (KTJNightVersion)

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
        
    }
}
@end
