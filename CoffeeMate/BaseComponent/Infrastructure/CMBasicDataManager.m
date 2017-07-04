//
//  CMBasicDataManager.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/4.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMBasicDataManager.h"

@interface CMBasicDataManager()
@property (nonatomic , strong) AFHTTPSessionManager *sessionManager;

@end

@implementation CMBasicDataManager

- (instancetype)init {
    self = [super init];
    if(self) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [[self class] jsonResponseSerializer];
        [_sessionManager.requestSerializer setTimeoutInterval:15];
        
    }
    return self;
}

+ (__kindof AFJSONResponseSerializer *)jsonResponseSerializer {
    return [CMJSONResponseSerializer serializer];
}

#pragma mark - CMBasicDataManagerInterface

+ (BOOL)isNetworkReachable {
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(void (^)(id _Nonnull))success
       fail:(void (^)(NSError * _Nonnull))failure {
    
    [self.sessionManager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@" resquest: %@, \n url: %@, \n data: %@ \n", task.currentRequest, task.currentRequest.URL, responseObject);
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@" resquest: %@ failed, \n url: %@, \n error message: %@ \n", task.currentRequest, task.currentRequest.URL, error);
        failure(error);
    }];
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(void (^)(id _Nonnull))success
     failure:(void (^)(NSError * _Nonnull))failure {
    
    [self.sessionManager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@" resquest: %@, \n url: %@, \n data: %@ \n", task.currentRequest, task.currentRequest.URL, responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@" resquest: %@ failed, \n url: %@, \n error message: %@ \n", task.currentRequest, task.currentRequest.URL, error);
        failure(error);
    }];
}

- (void)POST:(NSString *)URLString
        name:(NSString *)name
    fileName:(NSString *)fileName
        data:(NSData *)uploadData
     success:(void (^)(id _Nonnull))success
     failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:uploadData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:NULL completionHandler:^(NSURLResponse * _Nonnull response, id  _Nonnull responseObject, NSError * _Nonnull error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        if (dict[@"name"]) {
            success(dict[@"name"]);
        } else {
            failure(error);
        }
        NSLog(@"aaa %@",responseObject);
    }];
    
    [uploadTask resume];

}


@end
