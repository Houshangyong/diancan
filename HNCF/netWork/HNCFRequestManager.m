//
//  HNCFRequestManager.m
//  HNCF
//
//  Created by Apple on 15/11/18.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import "HNCFRequestManager.h"
#import "HNCFCommmon.h"
@interface HNCFRequestManager ()

+ (instancetype)sharedManager;
@property (nonatomic, strong) NSOperationQueue *requestQueue;

@end
@implementation HNCFRequestManager
#pragma mark
#pragma mark -- 单例
+ (instancetype)sharedManager {
    
    static HNCFRequestManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HNCFRequestManager alloc] initWithBaseURL:nil];
        manager.requestQueue = [[NSOperationQueue alloc] init];
        [manager.requestQueue setMaxConcurrentOperationCount:5];
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return manager;
}

/**
 *  发送post请求
 *
 *  @param apiUrl     api路径
 *  @param parameters post请求参数
 *  @param success    网络请求成功Block
 *  @param failure    网络请求失败Block
 *
 *  @return 当前请求实例
 */
+ (NSURLRequest *)post:(NSString *)apiUrl
            parameters:(NSDictionary *)parameters
               success:(void (^)(id))success
               failure:(void (^)(NSError *))failure
{
    NSDictionary *fixedParameters = [self fixedParameters:parameters];
        NSLog(@"%@",fixedParameters);
//    NSError *parseError = nil;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:fixedParameters options:NSJSONWritingPrettyPrinted error:&parseError];
//    
//    NSString *para =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    para = [para stringByReplacingOccurrencesOfString:@" " withString:@""];
//    para = [para stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//    
//    NSLog(@"jsonpara%@",para);
    
//    NSData *data = [[NSString stringWithFormat:@"%@",para] dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error;
//    NSString *encryptedString = [data mt_AESEncryptedDataUsingKey:MJ_ENCRYPTION_KEY error:&error];
//    NSLog(@"encryptedString%@",encryptedString);
//    NSDictionary *dic = @{@"postdata":encryptedString};
    
    NSMutableURLRequest *request = [[HNCFRequestManager sharedManager].requestSerializer requestWithMethod:@"POST" URLString:apiUrl parameters:fixedParameters error:nil];
    [request setTimeoutInterval:10];
    NSLog(@"apiUrl:%@",apiUrl);
    
    AFHTTPRequestOperation *operation = [[HNCFRequestManager sharedManager] HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject); //自动返回主线程
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog ( @"operation------=====------ %@" , operation.responseString );
        failure(error);
    }];
    //    [MJRequestManager sharedManager].responseSerializer = [AFHTTPResponseSerializer serializer];
    [[HNCFRequestManager sharedManager].requestQueue addOperation:operation];
    
    return request;
}



+ (NSDictionary *)fixedParameters:(NSDictionary *)parameters {
    NSMutableDictionary *fixedParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    NSDictionary *userInfo = [HNCFUserDefaultsUtil globalObjectForKey:kMTCurrentUserInfo];
    NSString *userLocationID = [userInfo objectForKey:@"cityid"];
    if (!userLocationID) {
        userLocationID = @"";
    }
//    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
//    long long int date = (long long int)time;
    NSString *userID = [userInfo objectForKey:@"uid"];
    if (!userID) {
        userID = @"";
    }else{
        [fixedParameters setObject:userID forKey:@"uid"]; // 必需参数
        
    }
    

//    [fixedParameters setObject:MT_APP_VERSION forKey:@"AuthorizationVersion"];
////    [fixedParameters setObject:[NSString stringWithFormat:@"%lld%@",date,[NSString stringWithFormat:@"%d", arc4random()%9000+1000]] forKey:@"time"];
//    [fixedParameters setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//                        forKey:@"appvcode"];
//    [fixedParameters setObject:@"ios"
//                        forKey:@"appplat"];
//    //判断版本 以及机型
//    [fixedParameters setObject:[[UIDevice currentDevice] mtgj_UUID] forKey:@"deviceid"];
//    [fixedParameters setObject:[[UIDevice currentDevice] mtgj_platform] forKey:@"devicename"];
//    [fixedParameters setObject:userLocationID forKey:@"subsiteid"]; // 必需参数
    return fixedParameters;
}
/**
 *  取消网络请求
 *
 *  @param requests 网络请求队列
 */
+ (void)cancelRequests:(NSArray *)requests {
    
    for (NSURLRequest *request in requests) {
        for (AFHTTPRequestOperation *operation in [[HNCFRequestManager sharedManager].operationQueue operations]) {
            
            if ([operation.request.URL isEqual:request.URL]) {
                [operation cancel];
            }
        }
    }
}
@end
