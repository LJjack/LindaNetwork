//
//  LDHttpClient.h
//  platform
//
//  Created by bujiong on 16/7/2.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDRequestBuilder.h"
#import "LDResponse.h"

typedef void (^LDCompletionBlock)(NSData *data, NSUInteger status, NSError *error);

@interface LDHttpClient : NSObject

+ (instancetype)sharedClient;


/**
 发送请求

 @param request 请求
 @param block   回调

 @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)sendRequest:(LDRequest *)request
              block:(LDResponseBlock)block;

@end
