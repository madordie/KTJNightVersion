//
//  KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "KTJNightVersion.h"
#import "KTJNightVersionHelper.h"
#import <UIKit/UIKit.h>

NSString *KTJNofitionStyleChangeToNightName  = @"KTJNofitionStyleChangeToNightName";
NSString *KTJNofitionStyleChangeToNormalName = @"KTJNofitionStyleChangeToNormalName";


static CGFloat const KTJNightVersionAnimationDuration = 0.3f;

@interface KTJNightVersion ()

@property (nonatomic, assign) KTJNightVersionStyle currentStyle;
@property (nonatomic, strong) NSMutableSet *respondClasseses;

@end

@implementation KTJNightVersion

+ (KTJNightVersion *)shared {
    static KTJNightVersion *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
        shared.currentStyle = KTJNightVersionStyleNormal;
        shared.respondClasseses = [[NSMutableSet alloc] init];
    });
    return shared;
}

+ (KTJNightVersionStyle)currentStyle {
    return [[self shared] currentStyle];
}

+ (void)changeToNight {
    [[self shared] setCurrentStyle:KTJNightVersionStyleNight];
}

+ (void)changeToNormal {
    [[self shared] setCurrentStyle:KTJNightVersionStyleNormal];
}

- (void)setCurrentStyle:(KTJNightVersionStyle)currentStyle {
    if (_currentStyle == currentStyle) {
        return;
    }
    _currentStyle = currentStyle;
    
    NSString *nofitaName;
    
    switch (_currentStyle) {
        case KTJNightVersionStyleNormal:
            nofitaName = KTJNofitionStyleChangeToNormalName;
            break;
            
        case KTJNightVersionStyleNight:
            nofitaName = KTJNofitionStyleChangeToNightName;
            break;
            
        default:
            break;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.class changeColor:window.subviews.lastObject withDuration:KTJNightVersionAnimationDuration];

    [[NSNotificationCenter defaultCenter] postNotificationName:nofitaName object:nil];
    
    return;
}


+ (BOOL)shouldChangeColor:(id)object {
    __block BOOL shouldChangeColor = NO;
    [[KTJNightVersion respondClasseses] enumerateObjectsUsingBlock:^(NSString *klassString, BOOL *stop) {
        Class klass = NSClassFromString(klassString);
        if ([object isMemberOfClass:klass]) {
            shouldChangeColor = YES;
            *stop = YES;
        }
    }];
    return shouldChangeColor;
}

+ (void)changeColor:(id <KTJNightVersionChangeColorProtocol>)object {
    if ([object respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
        [object ktj_changeColorWithAnimation:NO duration:0];
    }
    if ([object respondsToSelector:@selector(subviews)]) {
        if (![object subviews]) {
            // Basic case, do nothing.
            return;
        } else {
            for (id subview in [object subviews]) {
                // recursice darken all the subviews of current view.
                [self changeColor:subview];
                if ([subview respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
                    [subview ktj_changeColorWithAnimation:NO duration:0];
                }
            }
        }
    }
}

+ (void)changeColor:(id <KTJNightVersionChangeColorProtocol>)object withDuration:(CGFloat)duration {
    if ([object respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
        [object ktj_changeColorWithAnimation:YES duration:duration];
    }
    if ([object respondsToSelector:@selector(subviews)]) {
        if (![object subviews]) {
            // Basic case, do nothing.
            return;
        } else {
            for (id subview in [object subviews]) {
                // recursice darken all the subviews of current view.
                [self changeColor:subview withDuration:duration];
                if ([subview respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
                    [subview ktj_changeColorWithAnimation:YES duration:duration];
                }
            }
        }
    }
}



+ (void)addClassToSet:(Class)klass {
    [[self shared].respondClasseses addObject:NSStringFromClass(klass)];
}

+ (void)removeClassFromSet:(Class)klass {
    [[self shared].respondClasseses removeObject:NSStringFromClass(klass)];
}

+ (NSSet *)respondClasseses {
    return [[self shared].respondClasseses copy];
}


@end
