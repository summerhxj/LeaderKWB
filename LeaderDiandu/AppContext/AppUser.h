//
//  AppUser.h
//  magicEnglish
//
//  Created by libin.tian on 11/27/13.
//  Copyright (c) 2013 ilovedev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUser : NSObject<NSCoding>

@property (nonatomic, copy) NSNumber * userID;
@property (nonatomic, copy) NSNumber * authType;

@property (nonatomic, copy) NSString* userTicket;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * userNickName;
@property (nonatomic, copy) NSString * authFrom;
@property (nonatomic, copy) NSString * birthday;


@property (nonatomic, copy) NSNumber* userCurrentLevel;
@property (nonatomic, copy) NSNumber* userLevelPercent;
@property (nonatomic, copy) NSNumber* userExp;

@property (nonatomic, copy) NSNumber* goldenCount;
@property (nonatomic, copy) NSNumber* userGrade;
@property (nonatomic, copy) NSNumber* useAppDay;
@property (nonatomic, copy) NSNumber* userGender;

@property (nonatomic, copy) NSString* userImageUrl;
@property (nonatomic, copy) NSString* userImageL;
@property (nonatomic, copy) NSString* userImageS;
@property (nonatomic, copy) NSString* userImageM;
@property (nonatomic, copy) NSString* userImageT;

@property (nonatomic, copy) NSNumber* hasExam;



+ (AppUser*)loadOrCreateUser;
+ (AppUser*)clearUser;

- (void)resetInfoByDic:(NSDictionary*)dic;
- (void)resetLevelByDic:(NSDictionary*)dic;
- (void)resetInfoByUpdateImg:(NSDictionary*)dic;

//- (void)resetInfoByLoginDic:(NSDictionary*)dic;
//- (void)resetInfoByInfoDic:(NSDictionary*)dic;
- (void)persistent;



@end
