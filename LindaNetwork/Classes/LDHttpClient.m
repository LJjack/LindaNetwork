//
//  LDHttpClient.m
//  platform
//
//  Created by bujiong on 16/7/2.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import "LDHttpClient.h"
#import "YYModel.h"
#import "YYCache.h"
#import "LDAPITool.h"

@implementation LDHttpClient

+ (instancetype)sharedClient {
    static LDHttpClient *client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[LDHttpClient alloc] init];
    });
    
    return client;
}

- (NSURLSessionDataTask *)sendRequest:(LDRequest *)request
              block:(LDResponseBlock)block {
    NSURLRequest *URLRequest = request.request;
    if (!URLRequest) {
        URLRequest = request.uploadRequest;
    }
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:URLRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable urlResponse, NSError * _Nullable error) {
        LDResponse *response = [LDAPITool handelResponseWithData:data error:error];
        if ([response judgeCodeOK]) {
            if (request.modelClass) {
                if (request.modelType == LDModelTypeArray) {
                    response.data = [NSArray yy_modelArrayWithClass:request.modelClass json:response.data];
                } else if (request.modelType == LDModelTypeDict) {
                    response.data = [request.modelClass yy_modelWithJSON:response.data];
                }
            }
        }
        
        if (block) block(response);
    }];
    [dataTask resume];
    return dataTask;
}

@end
