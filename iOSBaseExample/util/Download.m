

#import "Download.h"

@implementation Download

-(void)startDownload {
    //默认的配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *downloadURL = [NSURL URLWithString:self.downloadURLString];
    NSURLRequest *requset = [NSURLRequest requestWithURL:downloadURL];
    self.sessionTask = [self.session downloadTaskWithRequest:requset];
    //调用resume方法才会开始启动网络连接
    [self.sessionTask resume];
}
//下载成功后触发的方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *urls = [fileMgr URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSURL *url = [urls objectAtIndex:0];
    NSURL *origionURL = [[downloadTask originalRequest] URL];
    NSURL *destinationPath = [url URLByAppendingPathComponent:[origionURL lastPathComponent]];
    NSError *error = nil;
    [fileMgr removeItemAtURL:destinationPath error:&error];
    BOOL success = [fileMgr copyItemAtURL:location toURL:destinationPath error:&error];
    if (success) {
        NSLog(@"location: %@",location);
        NSLog(@"destinationPath: %@",destinationPath);
    }else{
        NSLog(@"Error during the copy: %@", [error localizedDescription]);
    }
}
//如果出现错误时调用的方法
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error == nil) {
        NSLog(@"Task: %@ completed successfully", task);
    }else{
        NSLog(@"Task: %@ completed with error: %@", task, [error localizedDescription]);
    }
    double progress = (double) task.countOfBytesReceived / (double)task.countOfBytesExpectedToReceive;
    NSLog(@"progress: %f",progress);
    self.sessionTask = nil;
}
//下载过程中得调用方法
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    if (downloadTask == self.sessionTask) {
        double progress = (double) totalBytesWritten / (double) totalBytesExpectedToWrite;
        NSLog(@"DownloadTask: %@ progress: %1f", downloadTask, progress);
        
    }
}

//另一种下载方式
- (void)download:(NSString *)url {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"result: %@",result);
        dispatch_semaphore_signal(semaphore);
    }];
    [dataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //防止内存泄漏
    [session finishTasksAndInvalidate];
}

@end
