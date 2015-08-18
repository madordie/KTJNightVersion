//
//  UIViewController+KTJNightVersion.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "UIViewController+KTJNightVersion.h"
#import "KTJNightVersionHelper.h"
#import "KTJNightVersionMacro.h"
#import <objc/runtime.h>

@implementation UIViewController (KTJNightVersion)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KTJChangeIMP(@selector(viewDidDisappear:), @selector(ktjhook_viewDidDisapper:));
        KTJChangeIMP(@selector(viewWillAppear:), @selector(ktjhook_viewWillAppear:));
    });
}

- (void)ktjhook_viewDidDisapper:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KTJNofitionStyleChangeToNightName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KTJNofitionStyleChangeToNormalName object:nil];
    
    [self ktjhook_viewDidDisapper:animated];
}

- (void)ktjhook_viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ktj_changeColor) name:KTJNofitionStyleChangeToNightName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ktj_changeColor) name:KTJNofitionStyleChangeToNormalName object:nil];

    [self ktjhook_viewWillAppear:animated];
    [self ktj_changeColor];
}

- (void)ktj_changeColor {
    [KTJNightVersion changeColor:self.view];
//    [self.navigationItem.leftBarButtonItem ktj_changeColorWithAnimation:NO duration:0];
//    [self.navigationItem.rightBarButtonItem ktj_changeColorWithAnimation:NO duration:0];
    [self.navigationController.navigationBar ktj_changeColorWithAnimation:NO duration:0];
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
