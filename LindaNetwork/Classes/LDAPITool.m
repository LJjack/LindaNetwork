//
//  LDAPITool.m
//  BJBasi
//
//  Created by 刘俊杰 on 2017/7/19.
//  Copyright © 2017年 巴斯. All rights reserved.
//

#import "LDAPITool.h"
#import "LDResponse.h"
#import "YYModel.h"

@implementation LDAPITool

+ (LDResponse *)handelResponseWithData:(NSData *)data
                                 error:(NSError *)error {
    LDResponse *response;
    if (error || !data.length) {
        response = [[LDResponse alloc] init];
        response.message = error.localizedDescription;
        response.code = -1;
    } else {
        response = [LDResponse yy_modelWithJSON:data];
    }
    return response;
}

@end
