//
//  LDRequest.m
//  platform
//
//  Created by bujiong on 16/6/30.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import "LDRequest.h"
#import "LDURLRequestSerialization.h"
#import "NSString+LJHash.h"

@implementation LDRequest

- (instancetype)init {
    if (self = [super init]) {
        // 配置默认值
        self.timeout = 20;
    }
    return self;
}

- (NSURLRequest *)request {
    if (self.uploadFileArray && self.uploadFileArray.count) {
        return nil;
    }
    NSString *urlParam = @"";
    if (self.urlParam.length) {
        urlParam = [NSString stringWithFormat:@"?%@",self.urlParam];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",  self.baseAddress, self.contextPath, self.methodName, urlParam]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:self.timeout];
    [request setHTTPShouldHandleCookies:NO];
    [request setHTTPMethod:self.httpMethod];
    
    if (self.isSignature) {
        [self handleSiginRequest:request];
    }
    if (self.formParam.length) {
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        request.HTTPBody = [self.formParam dataUsingEncoding:NSUTF8StringEncoding];
    }
    if (self.bodyParam.length) {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        request.HTTPBody = [self.bodyParam dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    return request;
}

- (NSURLRequest *)uploadRequest {
    NSString *urlParam = @"";
    if (self.urlParam.length) {
        urlParam = [NSString stringWithFormat:@"?%@",self.urlParam];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",  self.baseAddress, self.contextPath, self.methodName, urlParam]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:self.timeout];
    NSMutableArray *fileMArray = [NSMutableArray array];
    [self.uploadFileArray enumerateObjectsUsingBlock:^(NSData * _Nonnull fileData, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *item = @{@"mimeType" : @"binary/any",
                               @"fileName" : [NSString stringWithFormat:@"%d.jpg",(int)idx+1],
                               @"name"     : [NSString stringWithFormat:@"%d",(int)idx+1],
                               @"data"     : fileData};
        [fileMArray addObject:item];
    }];
    
    [[LDURLRequestSerialization serialization] uploadFileWithRequest:request fileArray:fileMArray.copy];
    
    return request;
}

/**
 电商签名 POST "bb=2&aa=1"排序后形成 aa=1bb=2
 电商签名 GET "bb=2&aa=1"排序后形成 aa=1bb=2
 */
- (void)handleSiginRequest:(NSMutableURLRequest *)request {
    NSString *param = @"";
    if ([self.httpMethod isEqualToString:@"POST"] || [self.httpMethod isEqualToString:@"PUT"]) {
        if (self.formParam.length) {
            NSArray<NSString *> *array = [self.formParam componentsSeparatedByString:@"&"];
            array = [array sortedArrayUsingComparator:^NSComparisonResult(NSString * _Nonnull obj1, NSString * _Nonnull obj2) {
                return [obj1 compare:obj2];
            }];
            param = [array componentsJoinedByString:@""];
        }
        if (self.bodyParam.length) {
            param = self.bodyParam;
        }
        
    } else if ([self.httpMethod isEqualToString:@"GET"]) {
        if (self.urlParam.length) {
            NSArray<NSString *> *array = [self.urlParam componentsSeparatedByString:@"&"];
            array = [array sortedArrayUsingComparator:^NSComparisonResult(NSString * _Nonnull obj1, NSString * _Nonnull obj2) {
                return [obj1 compare:obj2];
            }];
            param = [array componentsJoinedByString:@""];
        }
    }
    NSString *signmMD5 = [NSString stringWithFormat:@"%@%@%@",self.secret,param,self.accessToken].lj_md5String;
    
    [request setValue:self.accessToken forHTTPHeaderField:@"Access-Token"];
    [request setValue:signmMD5 forHTTPHeaderField:@"signature"];
}

@end
