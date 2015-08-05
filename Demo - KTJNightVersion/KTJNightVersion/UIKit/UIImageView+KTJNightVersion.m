//
//  UIImageView+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UIImageView+KTJNightVersion.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UIImageView (KTJNightVersion)


- (void)setKtj_nightImage:(UIImage *)ktj_nightImage {
    if (ktj_nightImage == self.ktj_nightImage) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        self.image = ktj_nightImage;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_nightImage), ktj_nightImage, OBJC_ASSOCIATION_RETAIN);
}
- (UIImage *)ktj_nightImage {
    return objc_getAssociatedObject(self, @selector(ktj_nightImage));
}

- (void)setKtj_normalImage:(UIImage *)ktj_normalImage {
    if (ktj_normalImage == self.ktj_normalImage) {
        return;
    }
    
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNormal) {
        self.image = ktj_normalImage;
    }
    
    objc_setAssociatedObject(self, @selector(ktj_normalImage), ktj_normalImage, OBJC_ASSOCIATION_RETAIN);
}
- (UIImage *)ktj_normalImage {
    return objc_getAssociatedObject(self, @selector(ktj_normalImage));
}


- (void)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration {
    if ([KTJNightVersion shouldChangeColor:self]) {
        KTJNightVersionStyle style = [KTJNightVersion currentStyle];
        UIImage *image;
        UIColor *backgroundColor;
        UIColor *tintColor;
        switch (style) {
            case KTJNightVersionStyleNormal:
                image = self.ktj_normalImage;
                backgroundColor = self.ktj_normalBackgroudColor;
                tintColor = self.ktj_normalTintColor;
                break;
                
            case KTJNightVersionStyleNight:
                image = self.ktj_nightImage;
                backgroundColor = self.ktj_nightBackgroudColor;
                tintColor = self.ktj_nightTintColor;
                break;
                
            default:
                image = self.image;
                backgroundColor = self.backgroundColor;
                tintColor = self.tintColor;
                break;
        }
        JGWeak(self);
        void (^changeColor)(void) = ^(void) {
            weakself.image = image;
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
