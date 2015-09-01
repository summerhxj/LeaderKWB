//
//  AppDelegate.m
//  LeaderDiandu
//
//  Created by xijun on 15/8/22.
//  Copyright (c) 2015年 hxj. All rights reserved.
//

#import "AppDelegate.h"
#import "Navigator.h"
#import "HBLoginViewController.h"
#import "HBGradeViewController.h"
#import "DHSlideMenuController.h"
#import "DHSlideMenuViewController.h"
#import "HBServiceManager.h"
#import "HBDataSaveManager.h"

@interface AppDelegate ()
{
    HBLoginViewController *loginVC;
}

@end

@implementation AppDelegate

+ (AppDelegate *)delegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    BOOL islogined = NO;
    NSDictionary *dict = [[HBDataSaveManager defaultManager] loadUser];
    if (dict) {
        islogined = YES;
        [HBServiceManager defaultManager].userEntity = [[HBUserEntity alloc] initWithDictionary:dict];
    }
    
    // 启动后的界面
    
//    UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UITabBarController *tabVC = [mainBoard instantiateInitialViewController];
//    self.globalNavi = [[UINavigationController alloc] initWithRootViewController:tabVC];
//    self.globalNavi.navigationBarHidden = YES;
    
    [self initDHSlideMenu];

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    loginVC = [sb instantiateViewControllerWithIdentifier:@"HBLoginViewController"];
    if (!islogined) {
        [self.globalNavi pushViewController:loginVC animated:NO];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.window setRootViewController:self.globalNavi];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)initDHSlideMenu
{
    HBBaseViewController *ctl1 = [[HBBaseViewController alloc] init];
    HBBaseViewController *ctl2 = [[HBBaseViewController alloc] init];
    HBBaseViewController *ctl3 = [[HBBaseViewController alloc] init];
    HBBaseViewController *ctl4 = [[HBBaseViewController alloc] init];
    NSArray *imgArray = @[@"menu_teacher", @"menu_star", @"menu_test", @"menu_pay", @"menu_setting", @"menu_service", @"menu_setting"];
    NSArray *titleArr = @[@"我的老师", @"订阅等级", @"测试作业", @"支付中心", @"消息中心", @"联系客服", @"设置"];
    DHSlideMenuViewController *leftViewController = [[DHSlideMenuViewController alloc] initWithMenus:titleArr MenuImages:imgArray  TabBarControllers:@[ctl1,ctl2,ctl3,ctl4]];
    [leftViewController initHeadView:[UIImage imageNamed:@"menu_head"] phone:@"15810738821"];
    
    HBGradeViewController *rootVC = [[HBGradeViewController alloc] init];
    DHSlideMenuController *menuVC = [DHSlideMenuController sharedInstance];
    menuVC.mainViewController = rootVC;
    menuVC.leftViewController = leftViewController;
    menuVC.rightViewController = nil;
    menuVC.animationType = SlideAnimationTypeMove;
    menuVC.needPanFromViewBounds = YES;
    
    self.globalNavi = [[UINavigationController alloc] initWithRootViewController:menuVC];
    self.globalNavi.navigationBarHidden = YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
