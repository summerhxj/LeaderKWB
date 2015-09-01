//
//  AppUser.m
//  magicEnglish
//
//  Created by libin.tian on 11/27/13.
//  Copyright (c) 2013 ilovedev.com. All rights reserved.
//

#import "AppUser.h"

#import "LocalSettings.h"


@implementation AppUser


+ (NSString*)pathForUser:(NSString*)userId
{
    // 这里暂时不用userid
    NSString* docPath = [LocalSettings documentPath];
    NSString* path = [NSString stringWithFormat:@"%@/app_user_0", docPath];
    
    return path;
}


+ (AppUser*)loadOrCreateUser
{
    NSString* userFile = [AppUser pathForUser:nil];
    AppUser* user = [NSKeyedUnarchiver unarchiveObjectWithFile:userFile];
    
    if (user == nil) {
        user = [[AppUser alloc] init];
    }
    
    return user;
}

+ (AppUser*)clearUser
{
    // 删除文件
    NSString* filePath = [AppUser pathForUser:nil];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError* error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error != nil) {
            NSLog(@"REMOVE FILE ERROR:%@", error);
        }
    }
    
    AppUser* user = [[AppUser alloc] init];
    return user;
}


- (void)persistent
{
    NSString* userFile = [AppUser pathForUser:nil];
    [NSKeyedArchiver archiveRootObject:self toFile:userFile];
}


- (id)init
{
    self = [super init];
    
    if (self != nil) {
        _userTicket = @"";
        _userID = @(0);
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
	if (self != nil) {
		self.userID = [aDecoder decodeObjectForKey:@"userID"];
		self.authType = [aDecoder decodeObjectForKey:@"authType"];
        
		self.userTicket = [aDecoder decodeObjectForKey:@"userTicket"];
		self.userName = [aDecoder decodeObjectForKey:@"userName"];
		self.userNickName = [aDecoder decodeObjectForKey:@"userNickName"];
		self.authFrom = [aDecoder decodeObjectForKey:@"authFrom"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        
        self.userCurrentLevel = [aDecoder decodeObjectForKey:@"userCurrentLevel"];
        self.userLevelPercent = [aDecoder decodeObjectForKey:@"userLevelPercent"];
        self.userExp = [aDecoder decodeObjectForKey:@"userExp"];
        
        self.goldenCount = [aDecoder decodeObjectForKey:@"goldenCount"];
        self.userGrade = [aDecoder decodeObjectForKey:@"userGrade"];
        self.useAppDay = [aDecoder decodeObjectForKey:@"useAppDay"];
        self.userGender = [aDecoder decodeObjectForKey:@"userGender"];
        
        self.userImageUrl = [aDecoder decodeObjectForKey:@"userImageUrl"];
        self.userImageL = [aDecoder decodeObjectForKey:@"userImageL"];
        self.userImageM = [aDecoder decodeObjectForKey:@"userImageM"];
        self.userImageS = [aDecoder decodeObjectForKey:@"userImageS"];
        self.userImageT = [aDecoder decodeObjectForKey:@"userImageT"];
        
        self.hasExam = [aDecoder decodeObjectForKey:@"hasExam"];
        
        if (self.userTicket == nil) {
            self.userTicket = @"";
        }
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.userID forKey:@"userID"];
	[aCoder encodeObject:self.authType forKey:@"authType"];

	[aCoder encodeObject:self.userTicket forKey:@"userTicket"];
	[aCoder encodeObject:self.userName forKey:@"userName"];
	[aCoder encodeObject:self.userNickName forKey:@"userNickName"];
	[aCoder encodeObject:self.authFrom forKey:@"authFrom"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    
    [aCoder encodeObject:self.userCurrentLevel forKey:@"userCurrentLevel"];
    [aCoder encodeObject:self.userLevelPercent forKey:@"userLevelPercent"];
    [aCoder encodeObject:self.userExp forKey:@"userExp"];
    
    [aCoder encodeObject:self.goldenCount forKey:@"goldenCount"];
    [aCoder encodeObject:self.userGrade forKey:@"userGrade"];
    [aCoder encodeObject:self.useAppDay forKey:@"useAppDay"];
    [aCoder encodeObject:self.userGender forKey:@"userGender"];
    
    [aCoder encodeObject:self.userImageUrl forKey:@"userImageUrl"];
    [aCoder encodeObject:self.userImageL forKey:@"userImageL"];
    [aCoder encodeObject:self.userImageS forKey:@"userImageS"];
    [aCoder encodeObject:self.userImageM forKey:@"userImageM"];
    [aCoder encodeObject:self.userImageT forKey:@"userImageT"];
    
    [aCoder encodeObject:self.hasExam forKey:@"hasExam"];
}

- (void)resetInfoByDic:(NSDictionary*)dic
{
    NSString* ticket = [dic objectForKey:@"TICKET"];
    if ([ticket isKindOfClass:[NSString class]]) {
        self.userTicket = ticket;
    }
    
    NSString* userName = [dic objectForKey:@"USER_NAME"];
    if ([userName isKindOfClass:[NSString class]]) {
        self.userName = userName;
    }
    
    NSString* nickName = [dic objectForKey:@"DISPLAY_NAME"];
    if ([nickName isKindOfClass:[NSString class]]) {
        self.userNickName = nickName;
    }
    
    NSString* authFrom = [dic objectForKey:@"AUTH_FROM"];
    if ([authFrom isKindOfClass:[NSString class]]) {
        self.authFrom = authFrom;
    }
    
    NSNumber* userId = [dic objectForKey:@"USER_ID"];
    if ([userId isKindOfClass:[NSNumber class]]) {
        self.userID = userId;
    }
    
    NSNumber* authType = [dic objectForKey:@"AUTH_TYPE"];
    if ([authType isKindOfClass:[NSNumber class]]) {
        self.authType = authType;
    }

    self.userImageL = [dic stringForKey:@"IMG_L"];
    self.userImageM = [dic stringForKey:@"IMG_M"];
    self.userImageS = [dic stringForKey:@"IMG_S"];
    self.userImageT = [dic stringForKey:@"IMG_T"];
    self.userImageUrl = self.userImageL;

    [self persistent];
}

- (void)resetLevelByDic:(NSDictionary*)dic
{
    self.userCurrentLevel = [dic numberForKey:@"NOW_USER_LEVEL"];
    self.userLevelPercent = [dic numberForKey:@"NEXT_LEVEL_FINISHED_PERCENT"];
    self.userExp = [dic numberForKey:@"NOW_USER_EXP"];
    
    [self persistent];
}

- (void)resetInfoByUpdateImg:(NSDictionary*)dic
{
    self.userID = [dic numberForKey:@"USER_ID"];
    self.userExp = [dic numberForKey:@"EXPERIENCE_COUNT"];
    self.goldenCount = [dic numberForKey:@"GOLDEN_COUNT"];
    
    self.birthday = [dic stringForKey:@"USER_BORN"];
    self.userCurrentLevel = [dic numberForKey:@"USER_LEVEL"];
    
    self.userName = [dic stringForKey:@"USER_NAME"];
    self.userNickName = [dic stringForKey:@"DISPLAY_NAME"];
    self.userGrade = [dic numberForKey:@"USER_GRADE"];
    self.authType = [dic numberForKey:@"CREATE_TYPE"];
    self.useAppDay = [dic numberForKey:@"USE_APP_DAY"];
    
    NSString* gender = [dic stringForKey:@"USER_SEX"];
    if ([gender isEqualToString:@"m"] || [gender isEqualToString:@"M"]) {
        self.userGender = [NSNumber numberWithInteger:userGenderMale];
    }
    else {
        self.userGender = [NSNumber numberWithInteger:userGenderFemale];
    }
    
    self.userImageL = [dic stringForKey:@"IMG_L"];
    self.userImageM = [dic stringForKey:@"IMG_M"];
    self.userImageS = [dic stringForKey:@"IMG_S"];
    self.userImageT = [dic stringForKey:@"IMG_T"];
    self.userImageUrl = self.userImageL;
}

- (void)setGoldenCount:(NSNumber *)goldenCount
{
    if (goldenCount.integerValue != _goldenCount.integerValue) {
        _goldenCount = goldenCount;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_userGoldenCountChanged
                                                            object:nil];
    }
}

/*
 {"EXPERIENCE_COUNT":1340,"USER_ID":454,"GOLDEN_COUNT":0,"USER_BORN":"","ID":454,"USER_LEVEL":2,"IMG_L":"http://boss.61dear.com/imgStorage/2932470266471778436_L.jpg","USER_NAME":"tlb203@163.com","USER_GRADE":1,"CREATE_TYPE":1,"USE_APP_DAY":6,"IMG_S":"http://boss.61dear.com/imgStorage/2932470266471778436_S.jpg","USER_SEX":"m","IMG_M":"http://boss.61dear.com/imgStorage/2932470266471778436_M.jpg","IMG_T":"http://boss.61dear.com/imgStorage/2932470266471778436_T.jpg","DISPLAY_NAME":"彬"}
 */

@end
