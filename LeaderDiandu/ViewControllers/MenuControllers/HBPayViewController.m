//
//  HBPayViewController.m
//  LeaderDiandu
//
//  Created by xijun on 15/9/1.
//  Copyright (c) 2015年 hxj. All rights reserved.
//

#import "HBPayViewController.h"
#import "UIViewController+AddBackBtn.h"
#import "HBTitleView.h"

@interface HBPayViewController ()

@end

@implementation HBPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    HBTitleView *labTitle = [HBTitleView titleViewWithTitle:@"支付中心" onView:self.view];
    [self.view addSubview:labTitle];
    
    [self addBackButton];
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
