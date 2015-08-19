//
//  UIImageView+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UIImageView+KTJNightVersion.h"
#import "KTJNightVersionMacro.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UIImageView (KTJNightVersion)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KTJChangeIMP(@selector(setImage:), @selector(ktjhook_setImage:));
    });
}
- (void)ktjhook_setImage:(UIImage *)image {
    self.ktj_normalImage = image;
    [self ktjhook_setImage:image];
}

- (void)setKtj_nightImage:(UIImage *)ktj_nightImage {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [self ktjhook_setImage:ktj_nightImage];
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightImage), ktj_nightImage, OBJC_ASSOCIATION_RETAIN);
}
- (UIImage *)ktj_nightImage {
    return objc_getAssociatedObject(self, @selector(ktj_nightImage))?:self.ktj_normalImage;
}

- (void)setKtj_normalImage:(UIImage *)ktj_normalImage {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        [self ktjhook_setImage:ktj_normalImage];
    }
    
    [self ktj_saveNormalImage:ktj_normalImage];
}
- (UIImage *)ktj_normalImage {
    return objc_getAssociatedObject(self, @selector(ktj_normalImage))?:self.image;
}
- (void)ktj_saveNormalImage:(UIImage *)normalImage {
    objc_setAssociatedObject(self, @selector(ktj_normalImage), normalImage, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    if ([super respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
        if ([super ktj_changeColorWithAnimation:animation duration:duration]) {
            KTJNightVersionStyle style = [KTJNightVersion currentStyle];
            UIImage *image;
            switch (style) {
                case KTJNightVersionStyleNormal:
                    image = self.ktj_normalImage;
                    break;
                    
                case KTJNightVersionStyleNight:
                    image = self.ktj_nightImage;
                    break;
                    
                default:
                    image = self.image;
                    break;
            }
            JGWeak(self);
            void (^changeColor)(void) = ^(void) {
                [weakself ktjhook_setImage:image];
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
