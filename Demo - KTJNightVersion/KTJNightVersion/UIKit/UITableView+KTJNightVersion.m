//
//  UITableView+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UITableView+KTJNightVersion.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UITableView (KTJNightVersion)

- (void)setKtj_nightSeparatorColor:(UIColor *)ktj_nightSeparatorColor {
    if (ktj_nightSeparatorColor == self.ktj_nightSeparatorColor) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        self.separatorColor = ktj_nightSeparatorColor;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightSeparatorColor), ktj_nightSeparatorColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_nightSeparatorColor {
    return objc_getAssociatedObject(self, @selector(ktj_nightSeparatorColor));
}

- (void)setKtj_normalSeparatorColor:(UIColor *)ktj_normalSeparatorColor {
    if (ktj_normalSeparatorColor == self.ktj_normalSeparatorColor) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        self.separatorColor = ktj_normalSeparatorColor;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_normalSeparatorColor), ktj_normalSeparatorColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_normalSeparatorColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalSeparatorColor));
}



- (void)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    if ([KTJNightVersion shouldChangeColor:self]) {
        KTJNightVersionStyle style = [KTJNightVersion currentStyle];
        UIColor *separatorColor;
        UIColor *backgroundColor;
        UIColor *tintColor;
        switch (style) {
            case KTJNightVersionStyleNormal:
                separatorColor = self.ktj_normalSeparatorColor;
                backgroundColor = self.ktj_normalBackgroudColor;
                tintColor = self.ktj_normalTintColor;
                break;
                
            case KTJNightVersionStyleNight:
                separatorColor = self.ktj_nightSeparatorColor;
                backgroundColor = self.ktj_nightBackgroudColor;
                tintColor = self.ktj_nightTintColor;
                break;
                
            default:
                separatorColor = self.separatorColor;
                backgroundColor = self.backgroundColor;
                tintColor = self.tintColor;
                break;
        }
        JGWeak(self);
        void (^changeColor)(void) = ^(void) {
            weakself.separatorColor = separatorColor;
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
