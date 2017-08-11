//
//  NSString+LJHash.h
//  BJShop
//
//  Created by 刘俊杰 on 16/9/29.
//  Copyright © 2016年 不囧. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  加密
 */
@interface NSString (LJHash)

#pragma mark - 加密

@property (readonly) NSString *lj_md5String;

@property (readonly) NSString *lj_sha1String;

@property (readonly) NSString *lj_sha256String;

@property (readonly) NSString *lj_sha512String;

#pragma mark - 带密钥加密

- (NSString *)lj_hmacMD5StringWithKey:(NSString *)key;

- (NSString *)lj_hmacSHA1StringWithKey:(NSString *)key;

- (NSString *)lj_hmacSHA256StringWithKey:(NSString *)key;

- (NSString *)lj_hmacSHA512StringWithKey:(NSString *)key;

@end
