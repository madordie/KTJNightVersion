//
//  KTJNightVersionHelper.h
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//  https://github.com/madordie/KTJNightVersion.git

#ifndef Demo___KTJNightVersion_KTJNightVersionHelper_h
#define Demo___KTJNightVersion_KTJNightVersionHelper_h

#import "KTJNightVersion.h"
#import "UIView+KTJNightVersion.h"
#import "UILabel+KTJNightVersion.h"
#import "UIImageView+KTJNightVersion.h"
#import "UIButton+KTJNightVersion.h"
#import "UITableView+KTJNightVersion.h"
#import "UIBarButtonItem+KTJNightVersion.h"
#import "UINavigationBar+KTJNightVersion.h"

#import "CALayer+KTJNightVersion.h"

#endif


#if 0  
    如果发现任何异常问题，请联系：
    //  https://github.com/madordie/KTJNightVersion.git
    //  http://www.cnblogs.com/madordie/p/4716396.html
    //  http://www.cnblogs.com/madordie/

    //  使用说明

    辅助快速部署第二种皮肤管理。

    两步部署：
    //  1、注册该类可切换夜间模式（只对本类有效，父类、子类无效。
    [KTJNightVersion addClassToSet:cell.textLabel.class];
    //  2、配置两种颜色  其中 'setKtj_normalTextColor' ==> 'setTextColor'。
    cell.textLabel.ktj_normalTextColor = [UIColor grayColor];
    cell.textLabel.ktj_nightTextColor = [UIColor whiteColor];

    切换模式，全局任意地方调用
    //  切换至正常模式
    [KTJNightVersion changeToNormal];
    //  切换至夜间模式
    [KTJNightVersion changeToNight];

#endif