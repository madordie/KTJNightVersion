//
//  DetailViewController.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/9.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "DetailViewController.h"
#import "KTJNightVersionHelper.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIView *showView;

@end

@implementation DetailViewController

#pragma mark - < *** ViewController    生命周期   👇 ***>

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureNavigation];
    
    self.showView.frame = CGRectMake(0, 0, 200, 200);
    self.showView.center = self.view.center;
    [self.view addSubview:self.showView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.ktj_nightBackgroudColor = [UIColor grayColor];
    
    [self tryConfigureView];
    [self tryConfigButton];
    [self tryConfigureLabel];
    [self tryConfigureImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - < *** ViewController    响应事件   👇 ***>
- (void)navigationChangeStyle {
    if ([KTJNightVersion currentStyle] == KTJNightVersionStyleNight) {
        [KTJNightVersion changeToNormal];
    } else {
        [KTJNightVersion changeToNight];
    }
}
#pragma mark - < *** ViewController      代理     👇 ***>

#pragma mark - < *** ViewController    私有方法    👇 ***>
- (void)configureNavigation {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Change" style:UIBarButtonItemStyleDone target:self action:@selector(navigationChangeStyle)];
    item.ktj_normalTintColor = [UIColor grayColor];
    item.ktj_nightTintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    self.navigationController.navigationBar.ktj_nightBarTintColor = [UIColor grayColor];
    self.navigationController.navigationBar.ktj_normalBarTintColor = [UIColor whiteColor];
}
- (void)tryConfigureView {
    if ([self.showView isKindOfClass:[UIView class]]) {
        UIView *view = self.showView;
        view.backgroundColor = [UIColor grayColor];
        view.ktj_nightBackgroudColor = [UIColor whiteColor];
        
        CALayer *layer = view.layer.superlayer;
    }
}
- (void)tryConfigButton {
    if ([self.showView isKindOfClass:[UIButton class]]) {
        UIButton *button = (id)self.showView;
        button.ktj_nightTitleColor = [UIColor grayColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"Button" forState:UIControlStateNormal];
    }
}
- (void)tryConfigureLabel {
    if ([self.showView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self.showView;
        label.ktj_nightTextColor = [UIColor grayColor];
        label.textColor = [UIColor whiteColor];
        label.text = @"Label";
        label.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:@"wahaha"];
        [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50] range:NSMakeRange(0, 2)];
        [aString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, 2)];
        label.attributedText = aString;
    }
}
- (void)tryConfigureImageView {
    if ([self.showView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)self.showView;
        imageView.image = [UIImage imageNamed:@"01"];
        imageView.ktj_nightImage = [UIImage imageNamed:@"02"];
    }
}
#pragma mark - < *** ViewController getter/setter 👇 ***>
- (void)setViewClassName:(NSString *)viewClassName {
    if (viewClassName == _viewClassName) {
        return;
    }
    _viewClassName = viewClassName;
    self.showView = [NSClassFromString(viewClassName) new];
    return;
}
@end
