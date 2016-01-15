//
//  BEAFNetworking.h
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/13.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <objc/message.h>

@interface BEAFNetworking : NSObject

/**
 *  @author ihefe26, 16-01-13 15:01:20
 *
 *  AFNetWorking3.0 get和post 请求
 *
 *  @param url     URL
 *  @param params  参数
 *  @param success 成功数据
 *  @param failure 失败Error
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  @author ihefe26, 16-01-14 11:01:47
 *
 *  获取到现在网络状态  通过runtime获取
    #waring : 当状态栏被隐藏的时候，无法使用此方法
 */
+(NSString *)getNowNetStatus;


@end
