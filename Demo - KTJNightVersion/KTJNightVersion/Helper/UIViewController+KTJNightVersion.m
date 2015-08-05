//
//  UIViewController+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UIViewController+KTJNightVersion.h"
#import "KTJNightVersionHelper.h"
#import <objc/runtime.h>

@implementation UIViewController (KTJNightVersion)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewDidDisappear:);
        SEL swizzledSelector = @selector(hook_viewDidDisapper:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod =
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        originalSelector = @selector(viewWillAppear:);
        swizzledSelector = @selector(hook_viewWillAppear:);
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        didAddMethod =
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)hook_viewDidDisapper:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KTJNofitionStyleChangeToNightName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KTJNofitionStyleChangeToNormalName object:nil];
    
    [self hook_viewDidDisapper:animated];
}

- (void)hook_viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ktj_changeColor) name:KTJNofitionStyleChangeToNightName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ktj_changeColor) name:KTJNofitionStyleChangeToNormalName object:nil];

    [self hook_viewWillAppear:animated];
    [self ktj_changeColor];
}

- (void)ktj_changeColor {
    [KTJNightVersion changeColor:self.view];
    [self.navigationItem.leftBarButtonItem ktj_changeColorWithAnimation:NO duration:0];
    [self.navigationItem.rightBarButtonItem ktj_changeColorWithAnimation:NO duration:0];
    [self.navigationItem.backBarButtonItem ktj_changeColorWithAnimation:NO duration:0];
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem *obj, NSUInteger idx, BOOL *stop) {
        if ([obj respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
            [obj ktj_changeColorWithAnimation:NO duration:0];
        }
    }];
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem *obj, NSUInteger idx, BOOL *stop) {
        if ([obj respondsToSelector:@selector(ktj_changeColorWithAnimation:duration:)]) {
            [obj ktj_changeColorWithAnimation:NO duration:0];
        }
    }];
    
}

@end
