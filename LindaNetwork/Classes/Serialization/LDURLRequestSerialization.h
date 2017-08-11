//
//  LDURLRequestSerialization.h
//  BJNetworking
//
//  Created by 刘俊杰 on 16/7/13.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDURLRequestSerialization : NSObject

+ (instancetype)serialization;

/**
 *  包装上传 JSON 的请求
 *
 *  @param request 去 BJMURLRequest 设置
 *  @param bodyData    NSData
 */
- (void)uploadJSONWithRequest:(NSMutableURLRequest *)request formData:(NSData *)bodyData;

/**
 *  包装上传文件的请求
 *
 *  @param request   去 BJMURLRequest 设置
 *  @param fileArray 字典 eg. @{@"data":NSData,@"fileName":NSString,@"name":NSString,@"mimeType":NSString}
 *                           data 是上传的二进制数据 fileName 是上传文件的名称 mimeType 是文件的类型 如：图片是 image/png
 */
- (void)uploadFileWithRequest:(NSMutableURLRequest *)request
                    fileArray:(NSArray<NSDictionary *> *)fileArray;

@end
