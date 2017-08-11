//
//  LDRequest.h
//  platform
//
//  Created by bujiong on 16/6/30.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LDModelType) {
    LDModelTypeNone,
    LDModelTypeDict,
    LDModelTypeArray,
};

/**
 * 业务请求对象
 */
@interface LDRequest : NSObject

#pragma mark - 请求配置URL

/** 网络请求基地址 */
@property(nonatomic, copy) NSString *baseAddress;

/** 调用服务端api对应的路径 */
@property(nonatomic, copy) NSString *contextPath;

/** 方法名 */
@property(nonatomic, copy) NSString *methodName;

/** url参数 */
@property(nonatomic, copy) NSString *urlParam;

/** post、put请求的数据 */
@property(nonatomic, copy) NSString *formParam;

/** 参数体 */
@property (nonatomic, copy) NSString *bodyParam;

/** 超时设置 */
@property(nonatomic, assign) NSInteger timeout;

/** http方法名 */
@property(nonatomic, copy) NSString *httpMethod;

/** 是否签名 */
@property (nonatomic, assign) BOOL isSignature;

/** 签名 */
@property (nonatomic, copy) NSString *accessToken;

/** 密钥 */
@property (nonatomic, copy) NSString *secret;

#pragma mark - 请求设置

// 唯一标识一个请求
@property (nonatomic, assign) NSInteger requestId;

/** 是否是数组模型 */
@property (nonatomic, assign, getter = isArrayModel) BOOL arrayModel;

/** 模型的Class */
@property (nonatomic, strong) Class modelClass;

@property (nonatomic, assign) LDModelType modelType;

/** 上传文件数组，数组内包含上传文件的文件名 */
@property (nonatomic, copy) NSArray<NSData *> *uploadFileArray;

@property (nonatomic, strong, readonly) NSURLRequest *request;

@property (nonatomic, strong, readonly) NSURLRequest *uploadRequest;

@end
