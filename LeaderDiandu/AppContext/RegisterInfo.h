//
//  RegisterInfo.h
//  magicEnglish
//
//  Created by dajie on 2/7/14.
//  Copyright (c) 2014 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterInfo : NSObject

@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* emailStr;
@property (nonatomic, copy) NSString* phoneNumber;
@property (nonatomic, copy) NSString* phoneCheckCode;


@property (nonatomic, assign) BOOL registerWithBindInfo;
@property (strong, nonatomic) NSDictionary *bindInfo;

+ (id)infoWithEmail:(NSString*)email
           password:(NSString*)password;

+ (id)infoWithPhoneNumber:(NSString*)phoneNumber
                checkCode:(NSString*)checkCode
                 password:(NSString*)password;

@end
