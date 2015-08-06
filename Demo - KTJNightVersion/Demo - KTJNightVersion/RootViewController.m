//
//  RootViewController.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "RootViewController.h"
#import "KTJNightVersionHelper.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Change" style:UIBarButtonItemStyleDone target:self action:@selector(changeStyle)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    [self configureNightStyle];
    
    /*  使用说明  */
    
    //  1、注册改变类
    [KTJNightVersion addClassToSet:[UIBarButtonItem class]];
    
    //  2、设置夜间模式    'self.ktj_normal*' 等价于 'self.*'
#if 0   //  设置模式一
    rightButtonItem.ktj_normalTintColor = [UIColor greenColor];
    rightButtonItem.ktj_nightTintColor = [UIColor redColor];
#else   //  设置模式二
    rightButtonItem.tintColor = [UIColor greenColor];
    rightButtonItem.ktj_nightTintColor = [UIColor redColor];
#endif
    
    //  3、在你需要时候 切换模式
#if 0   //  正常
    [KTJNightVersion changeToNormal];
#else   //  夜间
    [KTJNightVersion changeToNight];
#endif
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)changeStyle{
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [KTJNightVersion changeToNormal];
    } else {
        [KTJNightVersion changeToNight];
    }
}
- (void)configureNightStyle {
    [KTJNightVersion addClassToSet:self.view.class];
    [KTJNightVersion addClassToSet:[UILabel class]];
    [KTJNightVersion addClassToSet:[UIButton class]];
    [KTJNightVersion addClassToSet:[UIImageView class]];
    [KTJNightVersion addClassToSet:[UINavigationBar class]];
    
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

#if 注意
    
    如果你想使用
        [UINavigationBar appearance].ktj_normalBarTintColor = [UIColor orangeColor];
        [UINavigationBar appearance].ktj_nightBarTintColor = [UIColor greenColor];
    
    请放置在 UINavigationController 创建之前。比如：
    
        [UINavigationBar appearance].ktj_normalBarTintColor = [UIColor orangeColor];
        [UINavigationBar appearance].ktj_nightBarTintColor = [UIColor greenColor];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[RootViewController new]];
    即可
    
#endif
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
