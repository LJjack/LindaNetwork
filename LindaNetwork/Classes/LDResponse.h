//
//  LDResponse.h
//  BJShop
//
//  Created by 刘俊杰 on 16/10/9.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LDResponse;

typedef void(^LDResponseBlock)(LDResponse *response);

@interface LDResponse : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic,   copy) NSString *message;

@property (nonatomic, strong) id data;

+ (instancetype)responseOK;

/**
 判断code值是否成功

 @return 成功返回YES
 */
- (BOOL)judgeCodeOK;

/**
 判断code值token是否失效

 @return 失效返回YES
 */
- (BOOL)judgeCodeToken;

@end
