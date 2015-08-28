//
//  CALayer+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/26.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "CALayer+KTJNightVersion.h"
#import "KTJNightVersionMacro.h"
#import <objc/runtime.h>

@implementation CALayer (KTJNightVersion)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KTJChangeIMP(@selector(setBorderColor:), @selector(ktjhook_setBorderColor:));
    });
}

- (void)ktjhook_setBorderColor:(CGColorRef)borderColor {
    self.ktj_normalBorderColor = borderColor;
    [self ktjhook_setBorderColor:borderColor];
}

- (void)setKtj_normalBorderColor:(CGColorRef)ktj_normalBorderColor {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        [self ktjhook_setBorderColor:ktj_normalBorderColor];
    }
    objc_setAssociatedObject(self, @selector(ktj_normalBorderColor), [UIColor colorWithCGColor:ktj_normalBorderColor], OBJC_ASSOCIATION_RETAIN);
}
- (CGColorRef)ktj_normalBorderColor {
    return [objc_getAssociatedObject(self, @selector(ktj_normalBorderColor)) CGColor]?:self.borderColor;
}

- (void)setKtj_nightBorderColor:(CGColorRef)ktj_nightBorderColor {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [self ktjhook_setBorderColor:ktj_nightBorderColor];
    }
    objc_setAssociatedObject(self, @selector(ktj_nightBorderColor), [UIColor colorWithCGColor:ktj_nightBorderColor], OBJC_ASSOCIATION_RETAIN);
}
- (CGColorRef)ktj_nightBorderColor {
    return [objc_getAssociatedObject(self, @selector(ktj_nightBorderColor)) CGColor]?:self.ktj_normalBorderColor;
}

- (BOOL)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    
    if ([KTJNightVersion shouldChangeColor:self]) {
        KTJNightVersionStyle style = [KTJNightVersion currentStyle];
        CGColorRef broderColor;
        switch (style) {
            case KTJNightVersionStyleNormal:
                broderColor = self.ktj_normalBorderColor;
                break;
                
            case KTJNightVersionStyleNight:
                broderColor = self.ktj_nightBorderColor;
                break;
                
            default:
                broderColor = self.borderColor;
                break;
        }
        JGWeak(self);
        void (^changeColor)(void) = ^(void) {
            [weakself ktjhook_setBorderColor:broderColor];
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
