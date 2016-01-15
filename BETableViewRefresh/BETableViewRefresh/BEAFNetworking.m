//
//  BEAFNetworking.m
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/13.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "BEAFNetworking.h"

@implementation BEAFNetworking

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.securityPolicy = [AFSecurityPolicy defaultPolicy];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/jpeg",@"application/json", nil];    
    [session GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.securityPolicy = [AFSecurityPolicy defaultPolicy];
  
    [session POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+(NSString *)getNowNetStatus
{
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    NSLog(@"----%d", type);
    if(type == 0)
    {
        return @"无网络";
    }else if(type == 1)
    {
        return @"2G网络";
    }else if(type == 2)
    {
        return @"3G网络";
    }else if(type == 3)
    {
        return @"4G网络";
    }else
    {
        return @"WIFI网络";
    }
}



@end
