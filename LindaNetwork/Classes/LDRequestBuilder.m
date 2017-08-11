//
//  LDRequestBuilder.m
//  platform
//
//  Created by bujiong on 16/6/30.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import "LDRequestBuilder.h"

@interface LDRequestBuilder()

@property (nonatomic, strong) LDRequest *request;
@property (nonatomic, strong) NSMutableDictionary *URLParamDicts;
@property (nonatomic, strong) NSMutableDictionary *formDataDicts;

@end

@implementation LDRequestBuilder

@synthesize HTTPPOST        = _HTTPPOST;
@synthesize HTTPGET         = _HTTPGET;
@synthesize HTTPPUT         = _HTTPPUT;
@synthesize HTTPSign        = _HTTPSign;
@synthesize HTTPAccessToken = _HTTPAccessToken;
@synthesize HTTPSecret      = _HTTPSecret;
@synthesize address         = _address;
@synthesize path            = _path;
@synthesize method          = _method;
@synthesize modelParam      = _modelParam;
@synthesize URLParam        = _URLParam;
@synthesize formParam       = _formParam;
@synthesize bodyParam       = _bodyParam;
@synthesize uploadFiles     = _uploadFiles;
@synthesize timeout         = _timeout;
@synthesize request         = _request;

+ (instancetype)createBuilder {
    return [[LDRequestBuilder alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        self.request = [[LDRequest alloc] init];
        self.URLParamDicts = [NSMutableDictionary dictionary];
        self.formDataDicts = [NSMutableDictionary dictionary];
    }
    return self;
}

- (LDAddNotParam)HTTPPOST {
    if (!_HTTPPOST) {
        __weak typeof(self) weakSelf = self;
        _HTTPPOST = ^() {
                weakSelf.request.httpMethod = @"POST";
            return weakSelf;
        };
    }
    return _HTTPPOST;
}

- (LDAddNotParam)HTTPGET {
    if (!_HTTPGET) {
        __weak typeof(self) weakSelf = self;
        _HTTPGET = ^() {
                weakSelf.request.httpMethod = @"GET";
            return weakSelf;
        };
    }
    return _HTTPGET;
}

- (LDAddNotParam)HTTPPUT {
    if (!_HTTPPUT) {
        __weak typeof(self) weakSelf = self;
        _HTTPPUT = ^() {
            weakSelf.request.httpMethod = @"PUT";
            return weakSelf;
        };
    }
    return _HTTPPUT;
}

- (LDAddNotParam)HTTPSign {
    if (!_HTTPSign) {
        __weak typeof(self) weakSelf = self;
        _HTTPSign = ^() {
                weakSelf.request.isSignature = YES;
            return weakSelf;
        };
    }
    return _HTTPSign;
}

- (LDAddStringParam)HTTPAccessToken {
    if (!_HTTPAccessToken) {
        __weak typeof(self) weakSelf = self;
        _HTTPAccessToken = ^(NSString *name) {
            weakSelf.request.accessToken = name;
            return weakSelf;
        };
    }
    return _HTTPAccessToken;
}

- (LDAddStringParam)HTTPSecret {
    if (!_HTTPSecret) {
        __weak typeof(self) weakSelf = self;
        _HTTPSecret = ^(NSString *name) {
            weakSelf.request.secret = name;
            return weakSelf;
        };
    }
    return _HTTPSecret;
}

- (LDAddStringParam)address {
    if (!_address) {
        __weak typeof(self) weakSelf = self;
        _address = ^(NSString *name) {
            weakSelf.request.baseAddress = name;
            return weakSelf;
        };
    }
    return _address;
}

- (LDAddStringParam)path {
    if (!_path) {
        __weak typeof(self) weakSelf = self;
        _path = ^(NSString *name) {
            weakSelf.request.contextPath = name;
            return weakSelf;
        };
    }
    return _path;
}

- (LDAddStringParam)method {
    if (!_method) {
        __weak typeof(self) weakSelf = self;
        _method = ^(NSString *name) {
            weakSelf.request.methodName = name;
            return weakSelf;
        };
    }
    return _method;
}

- (LDAddClassAndTypeParam)modelParam {
    if (!_modelParam) {
        __weak typeof(self) weakSelf = self;
        _modelParam = ^(Class modelClass, LDModelType type) {
            weakSelf.request.modelClass = modelClass;
            weakSelf.request.modelType = type;
            return weakSelf;
        };
    }
    return _modelParam;
}

- (LDAddKeyValue)URLParam {
    if (!_URLParam) {
        __weak typeof(self) weakSelf = self;
        _URLParam = ^(NSString *key, id value) {
            weakSelf.URLParamDicts[key] = value;
            return weakSelf;
        };
    }
    return _URLParam;
}

- (LDAddKeyValue)formParam {
    if (!_formParam) {
        __weak typeof(self) weakSelf = self;
        _formParam = ^(NSString *key, id value) {
            weakSelf.formDataDicts[key] = value;
            return weakSelf;
        };
    }
    return _formParam;
}

- (LDAddStringParam)bodyParam {
    if (!_bodyParam) {
        __weak typeof(self) weakSelf = self;
        _bodyParam = ^(NSString *body) {
            weakSelf.request.bodyParam = body;
            return weakSelf;
        };
    }
    return _bodyParam;
}

- (LDAddArrayParam)uploadFiles {
    if (!_uploadFiles) {
        __weak typeof(self) weakSelf = self;
        _uploadFiles = ^(NSArray *array) {
                weakSelf.request.uploadFileArray = array;
            return weakSelf;
        };
    }
    return _uploadFiles;
}

- (LDAddIntegerParam)timeout {
    if (!_timeout) {
        __weak typeof(self) weakSelf = self;
        _timeout = ^(NSInteger num) {
                weakSelf.request.timeout = num;
            return weakSelf;
        };
    }
    return _timeout;
}


- (LDRequest *)buildRequest {
    if (self.URLParamDicts.allKeys.count) {
        self.request.urlParam = [self toURLStringWithDict:self.URLParamDicts];
    }
    
    if (self.formDataDicts.allKeys.count) {
        self.request.formParam = [self toURLStringWithDict:self.formDataDicts];
    }
    return self.request;
}

#pragma mark - Private Medthod 

- (NSString *)toURLStringWithDict:(NSDictionary *)dict {
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in [dict allKeys]) {
        if ([string length]) {
            [string appendString:@"&"];
        }
        id value = dict[key];
        //NSArray
        if ([value isKindOfClass:[NSArray class]]) {
            for (NSString *str in value) {
                if (str) {
                    [string appendFormat:@"%@=%@&", key, [self toStringWithString:str]];
                }
            }
            [string deleteCharactersInRange:NSMakeRange(string.length-1, 1)];
        }
        //NSDictionary
        if ([value isKindOfClass:[NSDictionary class]]) {
            [string appendString:[self toURLStringWithDict:value]];
        }
        //NSString
        if ([value isKindOfClass:[NSString class]]) {
            NSString *str = value;
            if (str) {
                [string appendFormat:@"%@=%@", key, [self toStringWithString:str]];
            }
        }
        //NSNumber
        if ([value isKindOfClass:[NSNumber class]]) {
            NSString *str = [value stringValue];
            if (str) {
                [string appendFormat:@"%@=%@", key, [value stringValue]];
            }
        }
        
    }
    return string;
}
//转义字符
- (NSString *)toStringWithString:(NSString *)string {
    //去掉两端的空格
    if ([string isKindOfClass:[NSString class]]) {
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return string;
}

@end
