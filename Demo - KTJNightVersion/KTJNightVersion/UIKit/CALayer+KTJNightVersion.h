//
//  CALayer+KTJNightVersion.h
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/26.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KTJNightVersion.h"

@interface CALayer (KTJNightVersion) <KTJNightVersionChangeColorProtocol>

@property CGColorRef ktj_nightBorderColor;
@property CGColorRef ktj_normalBorderColor;

@end
