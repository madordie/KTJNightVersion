//
//  UITableView+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UITableView+KTJNightVersion.h"
#import "KTJNightVersionMacro.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UITableView (KTJNightVersion)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KTJChangeIMP(@selector(setSeparatorColor:), @selector(ktjhook_setSeparatorColor:));
    });
}

- (void)ktjhook_setSeparatorColor:(UIColor *)separatorColor {
    self.ktj_normalSeparatorColor = separatorColor;
    [self ktjhook_setSeparatorColor:separatorColor];
}

- (void)setKtj_nightSeparatorColor:(UIColor *)ktj_nightSeparatorColor {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [self ktjhook_setSeparatorColor:ktj_nightSeparatorColor];
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightSeparatorColor), ktj_nightSeparatorColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_nightSeparatorColor {
    return objc_getAssociatedObject(self, @selector(ktj_nightSeparatorColor))?:self.separatorColor;
}

- (void)setKtj_normalSeparatorColor:(UIColor *)ktj_normalSeparatorColor {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        [self ktjhook_setSeparatorColor:ktj_normalSeparatorColor];
    }
    
    [self ktj_saveNormalSeparatorColor:ktj_normalSeparatorColor];
}
- (UIColor *)ktj_normalSeparatorColor {
    return objc_getAssociatedObject(self, @selector(ktj_normalSeparatorColor))?:self.separatorColor;
}
- (void)ktj_saveNormalSeparatorColor:(UIColor *)separatorColor {
    objc_setAssociatedObject(self, @selector(ktj_normalSeparatorColor), separatorColor, OBJC_ASSOCIATION_RETAIN);
}


- (BOOL)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    
    if ([super respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
        if ([super ktj_changeColorWithAnimation:animation duration:duration]) {
            KTJNightVersionStyle style = [KTJNightVersion currentStyle];
            UIColor *separatorColor;
            switch (style) {
                case KTJNightVersionStyleNormal:
                    separatorColor = self.ktj_normalSeparatorColor;
                    break;
                    
                case KTJNightVersionStyleNight:
                    separatorColor = self.ktj_nightSeparatorColor;
                    break;
                    
                default:
                    separatorColor = self.separatorColor;
                    break;
            }
            JGWeak(self);
            void (^changeColor)(void) = ^(void) {
                [weakself ktjhook_setSeparatorColor:separatorColor];
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
