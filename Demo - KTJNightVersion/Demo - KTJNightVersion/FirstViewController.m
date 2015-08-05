//
//  FirstViewController.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/5.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "FirstViewController.h"
#import "KTJNightVersionHelper.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [KTJNightVersion addClassToSet:self.view.class];
    [KTJNightVersion addClassToSet:[UIBarButtonItem class]];
    [KTJNightVersion addClassToSet:[UINavigationBar class]];
    
    self.navigationController.navigationBar.ktj_normalBarTintColor = [UIColor greenColor];
    self.navigationController.navigationBar.ktj_nightBarTintColor = [UIColor whiteColor];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"change" style:UIBarButtonItemStyleDone target:self action:@selector(change)];
    self.navigationItem.leftBarButtonItem = left;
    
    left.ktj_nightTintColor = [UIColor orangeColor];
    left.ktj_normalTintColor = [UIColor grayColor];
    
    self.view.ktj_nightBackgroudColor = [UIColor orangeColor];
    self.view.ktj_normalBackgroudColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)change {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [KTJNightVersion changeToNormal];
    } else {
        [KTJNightVersion changeToNight];
    }
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
