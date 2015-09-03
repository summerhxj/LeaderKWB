//
//  HBUserInfoViewController.m
//  LeaderDiandu
//
//  Created by xijun on 15/9/2.
//  Copyright (c) 2015年 hxj. All rights reserved.
//

#import "HBUserInfoViewController.h"
#import "UIViewController+AddBackBtn.h"
#import "HBTitleView.h"
#import "HBServiceManager.h"

static NSString * const KUserInfoViewControllerCellReuseId = @"KUserInfoViewControllerCellReuseId";

@interface HBUserInfoViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray     *_titleArr;
    UITableView *_tableView;
}

@end

@implementation HBUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleArr = @[@"账号", @"姓名", @"手机"];
    
    HBTitleView *labTitle = [HBTitleView titleViewWithTitle:@"个人中心" onView:self.view];
    [self.view addSubview:labTitle];
    
    [self addBackButton];
    
    CGRect rect = self.view.frame;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KHBNaviBarHeight, rect.size.width, rect.size.height-KHBNaviBarHeight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    [self getUserInfo];
}

- (void)getUserInfo
{
    HBUserEntity *userEntity = [HBServiceManager defaultManager].userEntity;
    [[HBServiceManager defaultManager] requestUserInfo:userEntity.userid token:userEntity.token completion:^(id responseObject, NSError *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSParameterAssert(_titleArr);
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSInteger imgWidth = 100;
    NSInteger screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIView *view = [[UIView alloc] init];
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth-imgWidth)/2, (200-imgWidth)/2, imgWidth, imgWidth)];
    headView.image = [UIImage imageNamed:@"menu_head"];
    [view addSubview:headView];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSParameterAssert(_titleArr);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KUserInfoViewControllerCellReuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KUserInfoViewControllerCellReuseId];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [_titleArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
