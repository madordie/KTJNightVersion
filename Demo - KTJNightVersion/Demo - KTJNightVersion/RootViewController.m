//
//  RootViewController.m
//  Demo - KTJNightVersion
//
//  Created by 孙继刚 on 15/8/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import "RootViewController.h"
#import "KTJNightVersionHelper.h"
#import "DetailViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_dataSource;
}
@end

@implementation RootViewController

#pragma mark - < *** ViewController    生命周期   👇 ***>

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureNavigation];
    [self configureDataSource];
    [self configureVersion];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.ktj_normalBackgroudColor = [UIColor whiteColor];
    self.tableView.ktj_nightBackgroudColor = [UIColor grayColor];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.ktj_normalTextColor = [UIColor grayColor];
    cell.textLabel.ktj_nightTextColor = [UIColor whiteColor];
    cell.ktj_nightBackgroudColor = [UIColor grayColor];
    cell.ktj_normalBackgroudColor = [UIColor whiteColor];

    [KTJNightVersion addClassToSet:cell.textLabel.class];
    //  别问我为啥下面注册了UILabel 此处还要注册。。我会告诉你自己po一下看看这个类竟然是UITableViewLabel
    /*
     (lldb) po cell.textLabel.class
     UITableViewLabel
     
     (lldb)
     
     */

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.viewClassName = _dataSource[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - < *** ViewController    私有方法    👇 ***>
- (void)configureDataSource {
    _dataSource = @[@"UIView", @"UIButton", @"UILabel", @"UIImageView"];
}
- (void)configureNavigation {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Change" style:UIBarButtonItemStyleDone target:self action:@selector(navigationChangeStyle)];
    item.tintColor = [UIColor grayColor];
    item.ktj_nightTintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    self.navigationController.navigationBar.ktj_nightBarTintColor = [UIColor grayColor];
    self.navigationController.navigationBar.ktj_normalBarTintColor = [UIColor whiteColor];
}
- (void)configureVersion {
    [_dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [KTJNightVersion addClassToSet:NSClassFromString(obj)];
    }];
    [@[[UIBarButtonItem class], [UINavigationBar class], [UITableViewCell class], [UITableView class]] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [KTJNightVersion addClassToSet:obj];
    }];
}

#pragma mark - < *** ViewController getter/setter 👇 ***>


@end
