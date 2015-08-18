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
        KTJChangeIMP(@selector(setAttributedText:), @selector(ktjhook_setAttributedText:));
    });
}
- (void)ktjhook_setTextColor:(UIColor *)textColor {
    self.ktj_normalTextColor = textColor;
    [self ktjhook_setTextColor:textColor];
}
- (void)ktjhook_setAttributedText:(NSAttributedString *)attributedText {
    self.ktj_normalAttributedText = attributedText;
    [self ktjhook_setAttributedText:attributedText];
}

- (void)setKtj_normalAttributedText:(NSAttributedString *)ktj_normalAttributedText {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        [self ktjhook_setAttributedText:ktj_normalAttributedText];
    }
    objc_setAssociatedObject(self, @selector(ktj_normalAttributedText), ktj_normalAttributedText, OBJC_ASSOCIATION_RETAIN);
}
- (NSAttributedString *)ktj_normalAttributedText {
    return objc_getAssociatedObject(self, @selector(ktj_normalAttributedText))?:self.attributedText;
}
- (void)setKtj_nightAttributedSText:(NSAttributedString *)ktj_nightAttributedSText {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [self ktjhook_setAttributedText:ktj_nightAttributedSText];
    }
    objc_setAssociatedObject(self, @selector(ktj_nightAttributedSText), ktj_nightAttributedSText, OBJC_ASSOCIATION_RETAIN);
}
- (NSAttributedString *)ktj_nightAttributedSText {
    return objc_getAssociatedObject(self, @selector(ktj_nightAttributedSText))?:self.attributedText;
}

- (void)setKtj_nightTextColor:(UIColor *)ktj_nightTextColor {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [self ktjhook_setTextColor:ktj_nightTextColor];
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightTextColor), ktj_nightTextColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)ktj_nightTextColor {
    return objc_getAssociatedObject(self, @selector(ktj_nightTextColor))?:self.textColor;
}

- (void)setKtj_normalTextColor:(UIColor *)ktj_normalTextColor {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        [self ktjhook_setTextColor:ktj_normalTextColor];
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
            NSAttributedString *attributedString;
            switch (style) {
                case KTJNightVersionStyleNormal:
                    textColor = self.ktj_normalTextColor;
                    attributedString = self.ktj_normalAttributedText;
                    break;
                    
                case KTJNightVersionStyleNight:
                    textColor = self.ktj_nightTextColor;
                    attributedString = self.ktj_nightAttributedSText;
                    break;
                    
                default:
                    textColor = self.textColor;
                    attributedString = self.attributedText;
                    break;
            }
            JGWeak(self);
            void (^changeColor)(void) = ^(void) {
                [weakself ktjhook_setTextColor:textColor];
                [weakself ktjhook_setAttributedText:attributedString];
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
