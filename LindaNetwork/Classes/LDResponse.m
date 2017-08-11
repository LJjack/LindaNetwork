//
//  LDResponse.m
//  BJShop
//
//  Created by 刘俊杰 on 16/10/9.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import "LDResponse.h"

#define kResponseCodeOK 0
#define kResponseCodeToken 5000 //token失效值

@implementation LDResponse

+ (instancetype)responseOK {
    LDResponse *response = [[LDResponse alloc] init];
    response.code = kResponseCodeOK;
    return response;
}

- (BOOL)judgeCodeOK {
    return self.code == kResponseCodeOK;
}

- (BOOL)judgeCodeToken {
    return self.code == kResponseCodeToken;
}

@end
