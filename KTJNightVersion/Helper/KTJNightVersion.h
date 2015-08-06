//
//  KTJNightVersion.h
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KTJNightVersionStyle) {
    KTJNightVersionStyleNormal,
    KTJNightVersionStyleNight,
};

extern NSString *KTJNofitionStyleChangeToNightName;
extern NSString *KTJNofitionStyleChangeToNormalName;

@interface KTJNightVersion : NSObject

/**
 *  Current style.
 *
 *  @return KTJNightVersionStyle.
 */
+ (KTJNightVersionStyle)currentStyle;

/**
 *  change to normal.
 */
+ (void)changeToNormal;

/**
 *  change to night.
 */
+ (void)changeToNight;

+ (void)changeColor:(id)object;

/**
 *  Test a object have addClassToSet. if Y changecolor.
 */
+ (BOOL)shouldChangeColor:(id)object;
/**
 *  Add Class to respond classes set to make class can change
 *  color when switch theme
 *
 *  @param klass Klass which are supposed to change color
 */
+ (void)addClassToSet:(Class)klass;

/**
 *  Remove Class from respond classes set to make class cannot change
 *  color when switch theme
 *
 *  @param klass Klass which are not supposed to change color
 */
+ (void)removeClassFromSet:(Class)klass;

/**
 *  All klasses will change color when switch themes
 *
 *  @return A bunch of string for class which will change color when switch theme
 */
+ (NSSet *)respondClasseses;




@end

/**
 *  if you want
 */
@protocol KTJNightVersionChangeColorProtocol <NSObject>

/**
 *  颜色改变
 *
 *  @param animation 是否动画
 *  @param duration  动画时长
 */
- (BOOL)ktj_changeColorWithAnimation:(BOOL)animation duration:(CGFloat)duration;

@optional
- (NSArray *)subviews;

@end


