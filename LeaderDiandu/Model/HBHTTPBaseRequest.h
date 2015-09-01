//
//  HBHTTPBaseRequest.h
//  LeaderDiandu
//
//  Created by hxj on 15/8/21.
//
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, HBHTTPRequestType){
    
    HBHTTPRequestMethodGET = 0,
    HBHTTPRequestMethodPOST,
    HBHTTPRequestMethodUPLOAD,
    HBHTTPRequestMethodDOWNLOAD
};

typedef void(^HBFailureBlock)(NSError *error);

typedef void(^HBHTTPReqCompletionBlock)(id responseObject, NSError *error);


@interface HBHTTPBaseRequest : NSObject

+ (instancetype)requestWithSubUrl:(NSString *)url;

- (void)startWithMethod:(HBHTTPRequestType)methodType parameters:(id)param completion:(HBHTTPReqCompletionBlock)completionBlock;

@end
