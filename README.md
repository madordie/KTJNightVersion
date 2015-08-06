# KTJNightVersion

#  使用例子

    //  1、添加需要随着模式转变的类（只对本类有效）
    [KTJNightVersion addClassToSet:self.view.class];
    [KTJNightVersion addClassToSet:[UILabel class]];
    [KTJNightVersion addClassToSet:[UIButton class]];
    [KTJNightVersion addClassToSet:[UIImageView class]];
    [KTJNightVersion addClassToSet:[UINavigationBar class]];
    
    //  2、设置夜间模式（其中normal模式可以两种设置，分别做展示）
    self.view.backgroundColor = [UIColor colorWithRed: 0.8686 green: 0.8686 blue: 0.8686 alpha: 1.0];
    self.view.ktj_nightBackgroudColor = [UIColor grayColor];
    
    self.label.textColor = [UIColor colorWithRed: 0.769 green: 0.1828 blue: 0.7604 alpha: 1.0];
    self.label.ktj_nightTextColor = [UIColor colorWithRed: 1.0 green: 0.2528 blue: 1.0 alpha: 1.0];
    
    self.button.ktj_normalTitleColor = [UIColor blueColor];
    self.button.ktj_nightTitleColor = [UIColor colorWithRed: 0.0077 green: 0.128 blue: 0.7078 alpha: 1.0];
    
    self.imageView.ktj_normalImage = [UIImage imageNamed:@"01"];
    self.imageView.ktj_nightImage = [UIImage imageNamed:@"02"];
    
    
    self.navigationController.navigationBar.ktj_normalBarTintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.ktj_nightBarTintColor = [UIColor greenColor];
    
    //  3、请根据需要自由玩耍。
    //     正常
    [KTJNightVersion changeToNormal];
    //      夜间
    [KTJNightVersion changeToNight];
    
    
    如果你想使用
      [UINavigationBar appearance].ktj_normalBarTintColor = [UIColor orangeColor];
      [UINavigationBar appearance].ktj_nightBarTintColor = [UIColor greenColor];
    来设置导航栏,请放置在 UINavigationController 创建之前。
    比如：
    
      [UINavigationBar appearance].ktj_normalBarTintColor = [UIColor orangeColor];
      [UINavigationBar appearance].ktj_nightBarTintColor = [UIColor greenColor];
      self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[RootViewController new]];
    即可。

#备注
  根据 https://github.com/Draveness/DKNightVersion.git 进行优化。
  深深感谢DK的思路。
  
  目前至进行小范围测试，并未暴力测试，如果发现问题请留言，谢谢。
  
  括弧：其实逻辑挺简单的。。

