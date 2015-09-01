//
//  HBDataSaveManager.m
//  LeaderDiandu
//
//  Created by xijun on 15/9/1.
//  Copyright (c) 2015年 hxj. All rights reserved.
//

#import "HBDataSaveManager.h"

@implementation HBDataSaveManager

+ (id)defaultManager
{
    static HBDataSaveManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HBDataSaveManager alloc] init];
    });
    return manager;
}

- (void)saveUserByDict:(NSDictionary *)dict
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:dict forKey:KWBDefaultUser];
    [userDefault synchronize];
}

- (NSDictionary *)loadUser
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefault objectForKey:KWBDefaultUser];
    return dict;
}

@end
