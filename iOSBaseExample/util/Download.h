
/*
 使用NSURLSession完成下载功能。
 建议使用AFNetworking框架
 */

#import <Foundation/Foundation.h>

@interface Download : NSObject<NSURLSessionDownloadDelegate, NSURLSessionTaskDelegate, NSURLSessionDelegate>

@property (strong, nonatomic) NSString *downloadURLString;
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionDownloadTask *sessionTask;

- (void)startDownload;

@end
