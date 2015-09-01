//
//  HBDataSaveManager.h
//  LeaderDiandu
//
//  Created by xijun on 15/9/1.
//  Copyright (c) 2015年 hxj. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KWBDefaultUser      @"KWBDefaultUser"

@interface HBDataSaveManager : NSObject

+ (id)defaultManager;

- (void)saveUserByDict:(NSDictionary *)dict;
- (NSDictionary *)loadUser;

@end
