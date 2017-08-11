//
//  LDAPITool.h
//  BJBasi
//
//  Created by 刘俊杰 on 2017/7/19.
//  Copyright © 2017年 巴斯. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LDResponse;

@interface LDAPITool : NSObject

+ (LDResponse *)handelResponseWithData:(NSData *)data
                                 error:(NSError *)error;

@end
