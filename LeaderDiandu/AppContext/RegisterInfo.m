//
//  RegisterInfo.m
//  magicEnglish
//
//  Created by dajie on 2/7/14.
//  Copyright (c) 2014 wangliang. All rights reserved.
//

#import "RegisterInfo.h"

@implementation RegisterInfo

+ (id)infoWithEmail:(NSString*)email
           password:(NSString*)password
{
    RegisterInfo* info = [[RegisterInfo alloc] init];
    info.emailStr = email;
    info.password = password;
    
    return info;
}

+ (id)infoWithPhoneNumber:(NSString*)phoneNumber
                checkCode:(NSString*)checkCode
                 password:(NSString*)password
{
    RegisterInfo* info = [[RegisterInfo alloc] init];
    info.phoneNumber = phoneNumber;
    info.phoneCheckCode = checkCode;
    info.password = password;
    
    return info;
}


@end
