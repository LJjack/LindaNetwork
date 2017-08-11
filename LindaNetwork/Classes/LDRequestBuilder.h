//
//  LDRequestBuilder.h
//  platform
//
//  Created by bujiong on 16/6/30.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LDRequest.h"

@class LDRequestBuilder;

typedef LDRequestBuilder *(^LDAddNotParam)();
typedef LDRequestBuilder *(^LDAddStringParam)(NSString *name);
typedef LDRequestBuilder
*(^LDAddClassAndTypeParam)(Class modelClass, LDModelType type);
typedef LDRequestBuilder *(^LDAddIntegerParam)(NSInteger num);
typedef LDRequestBuilder *(^LDAddArrayParam)(NSArray *array);
typedef LDRequestBuilder *(^LDAddKeyValue)(NSString *key, id value);

/** 用来创建LDRequest对象 */
@interface LDRequestBuilder : NSObject

/** POST请求 */
@property (nonatomic, copy, readonly) LDAddNotParam HTTPPOST;

/** GET请求 */
@property (nonatomic, copy, readonly) LDAddNotParam HTTPGET;

/** PUT请求 */
@property (nonatomic, copy, readonly) LDAddNotParam HTTPPUT;

/** 添加签名 */
@property (nonatomic, copy, readonly) LDAddNotParam HTTPSign;
/** 签名 */
@property (nonatomic, copy, readonly) LDAddStringParam HTTPAccessToken;
/** 密钥 */
@property (nonatomic, copy, readonly) LDAddStringParam HTTPSecret;

/** 网络请求基地址 */
@property (nonatomic, copy, readonly) LDAddStringParam address;

/** 请求上线文路径，即使端口后第一个参数路径 */
@property (nonatomic, copy, readonly) LDAddStringParam path;

/** 请求方法名，即使端口后第二个参数路径 */
@property (nonatomic, copy, readonly) LDAddStringParam method;

/** 解析模型Class */
@property (nonatomic, copy, readonly) LDAddClassAndTypeParam modelParam;

/** 添加参数，参数会被编码到url中。任何请求都可以携带参数。 */
@property (nonatomic, copy, readonly) LDAddKeyValue URLParam;

/** 添加内容，内容会被作为请求体的组成部分。 */
@property (nonatomic, copy, readonly) LDAddKeyValue formParam;

/** 添加内容，内容会被作为请求体的组成部分。 */
@property (nonatomic, copy, readonly) LDAddStringParam bodyParam;

/**  添加上传多文件 */
@property (nonatomic, copy, readonly) LDAddArrayParam uploadFiles;

/** 设置超时时间, 不设置默认是30s */
@property (nonatomic, copy, readonly) LDAddIntegerParam timeout;

/** 构建请求 */
@property (nonatomic, strong, readonly) LDRequest *request;

+ (instancetype)createBuilder;

- (LDRequest *)buildRequest;

@end
