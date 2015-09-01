//
//  DHSlideMenuViewController.m
//  ByqIOSApps
//
//  Created by DumbbellYang on 14/11/28.
//  Copyright (c) 2014年 DumbbellYang. All rights reserved.
//

#import "DHSlideMenuViewController.h"
#import "DHSlideMenuController.h"

static NSString * const kSlideMenuViewControllerCellReuseId = @"kSlideMenuViewControllerCellReuseId";

@interface DHSlideMenuViewController ()

@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) NSArray *images;
@property(nonatomic, strong) NSArray *controllers;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) UIColor *selectedColor;
@property(nonatomic, assign) NSInteger previousRow;

@end

@implementation DHSlideMenuViewController

- (id)initWithMenus:(NSArray *)titles MenuImages:(NSArray *)images TabBarControllers:(NSArray*)controllers;{
    NSParameterAssert(titles);
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _titles = titles;
        _images = images;
        _controllers = controllers;
    }
    return self;
}

#pragma mark - Managing the view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.tableView.tableFooterView = nil;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSlideMenuViewControllerCellReuseId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

#pragma mark - Configuring the view’s layout behavior
- (UIStatusBarStyle)preferredStatusBarStyle{
    // Even if this view controller hides the status bar, implementing this method is still needed to match the center view controller's
    // status bar style to avoid a flicker when the drawer is dragged and then left to open.
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initHeadView:(UIImage *)headImg phone:(NSString *)phone
{
    UIView *view = [[UIView alloc] init];
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    headView.image = headImg;
    [view addSubview:headView];
    
    UILabel *phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 100, 20)];
    phoneLbl.backgroundColor = [UIColor clearColor];
    phoneLbl.textColor = [UIColor whiteColor];
    phoneLbl.font = [UIFont systemFontOfSize:14];
    phoneLbl.text = phone;
    [view addSubview:phoneLbl];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(170, 20, 20, 20)];
    arrowImg.image = [UIImage imageNamed:@"menu_right"];
    [view addSubview:arrowImg];
    
    self.tableView.sectionHeaderHeight = 80;
    self.tableView.tableHeaderView = view;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSParameterAssert(self.titles);
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSParameterAssert(self.titles);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSlideMenuViewControllerCellReuseId forIndexPath:indexPath];
    if ((self.images != nil) && (self.images.count > indexPath.row)){
        cell.imageView.image = [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
    }
    cell.backgroundColor = self.backgroundColor;
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(170, 20, 20, 20)];
    arrowImg.image = [UIImage imageNamed:@"menu_right"];
    [cell addSubview:arrowImg];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DHSlideMenuController *svc = [DHSlideMenuController sharedInstance];
    if (indexPath.row != self.previousRow) {
        NSLog(@"select row:%ld",(long)indexPath.row);
        if (indexPath.row < [self.controllers count]){
            [svc setMainViewController:[self.controllers objectAtIndex:indexPath.row]];
            [svc resetCurrentViewToMainViewController];
        }
        
        self.previousRow = indexPath.row;
    }
    
    [svc hideSlideMenuViewController:YES];
}

#if 0
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
#endif

@end
