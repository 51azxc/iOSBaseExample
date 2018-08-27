/*
 一些零散的功能模块收集。
 */

#import "CommonUtil.h"
/* 加密依赖 */
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#include "base64.h"


@implementation CommonUtil

#pragma mark - HexColor转UIColor
+ (UIColor *)getUIColorWithHexColor: (NSString *)hexColor andAlpha: (CGFloat)alpha {
    // 首先利用`NSScanner`类将传入的`NSString`类型的参数转成16进制的整数，然后再取得对应的RGB数值
    unsigned hex = 0;
    NSScanner *hexScanner = [NSScanner scannerWithString:hexColor];
    if ([hexColor hasPrefix:@"#"]) {
        // pass '#' character
        [hexScanner setScanLocation:1];
    }
    [hexScanner scanHexInt:&hex];
    return [UIColor colorWithRed: ((float)((hex & 0xFF0000) >> 16))/255.0
                           green: ((float)((hex & 0x00FF00) >>  8))/255.0
                            blue: ((float)((hex & 0x0000FF) >>  0))/255.0
                           alpha: alpha];
}

#pragma mark - 根据颜色生成图片
+ (UIImage *)createImageWithColor: (UIColor *)color andSize: (CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 缩放图片
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - md5加密
+ (NSString *)md5:(NSString *) str{
    const char *cstr = [str UTF8String];
    unsigned char digest[16];
    CC_MD5(cstr, strlen(cstr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x",digest[i]];
    }
    
    return result;
}

#pragma mark - sha1加密
+ (NSString *)sha1: (NSString *) str {
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x",digest[i]];
    }
    
    return result;
}

#pragma mark - HMAC SHA1加密
+ (NSString *)hmacsha1:(NSString *)text key:(NSString *)secret {
    NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [text dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[20];
    CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [clearTextData bytes], [clearTextData length], result);
    char base64Result[32];
    size_t theResultLength = 32;
    Base64EncodeData(result, 20, base64Result, &theResultLength,YES);
    NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
    return base64EncodedResult;
}

#pragma mark - 随机生成颜色
+ (UIColor *)randomColor {
    return [UIColor colorWithRed: arc4random_uniform(255)/255.0 green: arc4random_uniform(255)/255.0 blue: arc4random_uniform(255)/255.0 alpha: 1.0];
}

#pragma mark - 使Button图标文字上下排列
+ (void)setButtonImageUpAndTitleDown: (UIButton *)button {
    CGFloat spacing = 5.0;
    CGSize imageSize = button.imageView.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(imageSize.height + spacing), 0);
    CGSize titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0, 0, -titleSize.width);
}

#pragma mark - label根据文字内容自适应高度
+ (void)labelFit:(UILabel *)label {
    //label字体大小
    label.font = [UIFont systemFontOfSize:16.0f];
    //断句模式
    label.lineBreakMode = NSLineBreakByCharWrapping;
    //设定label的行数
    label.numberOfLines = 20;
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attr = @{ NSFontAttributeName:label.font, NSParagraphStyleAttributeName:style.copy };
    //size: 文本占据的大小
    //options: 文本选项
    //attributes: 文字属性
    //context: 上下文
    CGSize labelSize = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, 999.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    NSLog(@"label size: %@", [NSValue valueWithCGSize:labelSize]);
    
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
}

#pragma mark - 使SubView居中
+ (void)subViewCenter:(UIView *)subView parentView:(UIView *)parentView {
    subView.center = CGPointMake(parentView.frame.size.width  / 2, parentView.frame.size.height / 2);
    // or
    subView.center = [parentView convertPoint:parentView.center fromView:parentView.superview];
}


#pragma mark - 删除所有的子视图
+ (void)removeAllSubviews:(UIView *)view {
    [[view subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //不管用时只能使用遍历方法逐个删除
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}

#pragma mark - 更改视图大小
- (void)testChangeViewSize {
    CGRect rect = CGRectMake(100, 100, 100, 100);
    //将原来的矩形放大或者缩小，正数表示放大，负数表示缩小
    CGRect insetRect = CGRectInset(rect, 10, -10);
    NSLog(@"Inset rect x: %.0f, y: %.0f, w: %.0f, h: %.0f", insetRect.origin.x, insetRect.origin.y, insetRect.size.width, insetRect.size.height);
    //将原来的矩形变换位置
    CGRect offsetRect = CGRectOffset(rect, 20, -20);
    NSLog(@"Offset rect: %@", [NSValue valueWithCGRect:offsetRect]);
    //在原来的矩形基础上内切一个矩形
    CGRect edgeInsetRect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(-10, -10, -30, -40));
    NSLog(@"Edge inset rect: %@", [NSValue valueWithCGRect:edgeInsetRect]);
}

#pragma mark - 操作文件系统
- (void)testFileManager {
    /*
     主要目录结构:
        Documents: 可以将程序产生的数据文件保存在此目录中。iTunes同步。
        Library: 存放默认设置或其它状态信息。iTunes同步(除了子目录Caches)。
        Library/Caches: 存放程序产生的缓存文件，例如网络缓存之类。iTunes不同步。
        Library/Preferences：应用程序的偏好设置文件。我们使用NSUserDefaults写的设置数据都会保存到该目录下的一个plist文件中，即.plist文件。iTunes同步。
        tmp: 存放临时文件。系统会自动清除目录下的文件。iTunes不同步。
    */
    
    NSLog(@"home: %@",NSHomeDirectory());
    //获取tmp目录(存放临时文件。系统会自动清除目录下的文件。iTunes不同步)
    NSLog(@"tmp: %@",NSTemporaryDirectory());
    //获取Documents目录(可以将程序产生的数据文件保存在此目录中。iTunes同步)
    NSLog(@"doc: %@",[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    //获取Library目录(存放默认设置或其它状态信息。iTunes同步(除了子目录Caches))
    NSLog(@"lib: %@",[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    //获取Cache目录(存放程序产生的缓存文件，例如网络缓存之类。iTunes不同步。)
    NSLog(@"cache: %@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    
    /*
     NSSearchPathForDirectoriesInDomains三个参数的含义
     directory：NSSearchPathDirectory类型的enum值，表明我们要搜索的目录名称，比如这里用NSDocumentDirectory表明我们要搜索的是Documents目录。如果我们将其换成NSCachesDirectory就表示我们搜索的是Library/Caches目录。
     domainMask：NSSearchPathDomainMask类型的enum值，指定搜索范围，这里的NSUserDomainMask表示搜索的范围限制于当前应用的沙盒目录。还可以写成NSLocalDomainMask（表示/Library）、NSNetworkDomainMask（表示/Network）等。
     expandTilde：BOOL值，表示是否展开波浪线~。在iOS中~的全写形式是/User/userName，该值为YES即表示写成全写形式，为NO就表示直接写成“~”。
     */
    
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *mgr = [NSFileManager defaultManager];
    //创建目录
    NSString *createDir = [cacheDir stringByAppendingPathComponent:@"test"];
    if ([mgr createDirectoryAtPath:createDir withIntermediateDirectories:YES attributes:nil error:nil]) {
        NSLog(@"成功创建文件夹");
    }else{
        NSLog(@"创建文件夹失败");
    }
    //创建文件
    NSString *createFile = [cacheDir stringByAppendingPathComponent:@"json.txt"];
    if ([mgr createFileAtPath:createFile contents:nil attributes:nil]) {
        NSLog(@"成功创建文件");
    }else{
        NSLog(@"创建文件失败");
    }
    //删除文件
    [mgr removeItemAtPath:createFile error:nil];
    //获取文件属性
    NSDictionary *attrDict = [mgr attributesOfItemAtPath:createFile error:nil];
    //获取文件大小
    NSLog(@"file size: %@", [attrDict objectForKey: NSFileSize]);
}

#pragma mark - string 相关操作
- (void)testString {
    
    // 截取制定位置之后的字符串
    NSString *str = @"file:///Users/admin/Documents/test.html";
    NSString *s1 = [str substringFromIndex:5];
    NSLog(@"s1: %@",s1);
    
    // 截取指定下标之前的字符串
    NSString *s2 = [str substringToIndex:5];
    NSLog(@"s2: %@",s2);
    
    // 截取指定范围的字符串
    NSRange range = [str rangeOfString:@"admin"];
    NSString *s3 = [str substringWithRange:range];
    NSLog(@"s3: %@",s3);
    //从反方向截取字符串
    NSRange range1 = [str rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location!=NSNotFound) {
        NSString *s3_1 = [str substringFromIndex:range1.location];
        NSLog(@"s3.1: %@",s3_1);
    }
    
    // 字符串转数组
    NSArray *array1 = [str componentsSeparatedByString:@"/"];
    for(NSString *array_str in array1){
        NSLog(@"array_str: %@",array_str);
    }
    
    // 数组转字符串
    NSString *str_array = [array1 componentsJoinedByString:@"/"];
    NSLog(@"str_array: %@",str_array);
    
    // 拼接字符串
    NSString *s4_1 = [[NSString alloc] initWithFormat:@"%@%@",str,@"?a=1"];
    NSString *s4_2 = [str stringByAppendingString:@"?a=1"];
    NSString *s4_3 = [str stringByAppendingFormat:@"%@%@",@"?",@"a=1"];
    NSLog(@"s4.1: %@\ns4.2: %@\ns4.3: %@",s4_1, s4_2, s4_3);
    
    // CGFloat转NSString
    NSString *temp = [NSString stringWithFormat:@"x:%f,y:%g",1.1,2.2];
    NSLog(@"temp: %@",temp);
    
    // 大小写及开头字母大写
    NSLog(@"upper: %@\nlower: %@\ncap: %@",[str uppercaseString],[str lowercaseString],[str capitalizedString]);

    //NSString 转 NSData
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //NSData 转 NSString
    NSString *s5 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"s5: %@",s5);
    
    //全部替换
    NSString *s6_1 = [str stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSLog(@"s6: %@",s6_1);
    
    NSString *cs1 = @"This is a String1";
    NSString *cs2 = @"This is a String2";
    //判断两者是否相同
    BOOL r1 = [cs1 compare:cs2] == NSOrderedSame;
    //判断对象值的大小
    BOOL r2 = [cs1 compare:cs2] == NSOrderedAscending;
    //不考虑大小写
    BOOL r3 = [cs1 caseInsensitiveCompare:cs2] == NSOrderedSame;
    NSLog(@"same: %i, asc: %i, same: %@",r1,r2,r3?@"YES":@"NO");
    
    //删除部分字符串元素
    NSMutableString *nstr = [NSMutableString stringWithString:str];
    [nstr deleteCharactersInRange:[str rangeOfString:@"admin"]];
    NSLog(@"delete: %@",nstr);
    //插入字符串
    [nstr insertString:@"admin" atIndex:10];
    NSLog(@"insert: %@",nstr);
    
    // NSString CFStringRef互转
    /*
    NSString *yourFriendlyNSString = (__bridge NSString *)yourFriendlyCFString;
    CFStringRef yourFriendlyCFString = (__bridge CFStringRef)yourFriendlyNSString;
     */
    
    // 文件名相关操作
    //添加路径
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent: @"temp.txt"];
    //增加相关后缀名
    NSString *fileName = [@"temp" stringByAppendingPathExtension:@"txt"];
    //通过路径获取文件名
    //lastPathComponent获取到temp.txt,
    //stringByDeletingPathExtension获取到temp
    NSString *fileName1 = [[filePath lastPathComponent] stringByDeletingPathExtension];
    //获取后缀
    NSString *extension = [[filePath lastPathComponent] pathExtension];
    
    // 去除首尾空格
    [@" abc " stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //从通讯录中拿到的电话号码去除空格
    NSString *phone = [[@"123 456" componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    
    //当`String`中含有中文的时候，使用[NSURL URLWithString: str]方法得到的`NSURL`对象为`nil`。为了防止这种情况出现，需要先将`String`对象进行转码,这样能够预防`NSURL`对象返回为`nil`的问题。
    NSURL *url = [NSURL URLWithString: [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

#pragma mark - date相关操作
- (void)testDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //大写HH为24小时制,小写hh为12小时制
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    //string -> date
    NSDate *strDate = [formatter dateFromString:dateStr];
    //NSTimeInterval -> NSInteger
    NSTimeInterval interval = [strDate timeIntervalSince1970];
    //四舍五入
    NSInteger i = round(interval);
    NSLog(@"%ld",i);

    //根据当前时间新增时间，间隔单位为秒，负数则为之前的日期
    NSDate *date1 = [[NSDate alloc] initWithTimeInterval:60 sinceDate:date];
    //获取其中更早的日期
    NSDate *eDate = [date1 earlierDate:date];
    //获取其中更晚的日期
    NSDate *lDate = [date1 laterDate:date];
    //时间间隔
    NSTimeInterval dateInterval = [date timeIntervalSinceDate:date1];
}

#pragma mark - 格式化NSTimeInterval
- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

#pragma mark - 回调block
//无参回调
-(void)testBlock1:(void(^)(void))finish {
    NSLog(@"test1");
    finish();
}
//带参数的回调函数
-(void)testBlock2:(void (^)(int a,int b))result {
    NSLog(@"test2");
    int a = 1;
    int b = 2;
    result(a,b);
}
//将block在调用者处执行的结果返回给方法本身
/*
 使用:
 [bt testBlock3:^int(int a, int b) {
    return  a+b;
 }];
 */
-(void)testBlock3:(int (^)(int a,int b))result {
    NSLog(@"test3");
    int a = 1;
    int b = 2;
    int res = 0;
    if (result) {
        res = result(a,b);
    }
    NSLog(@"result: %d",res);
}

# pragma mark - 延时操作
- (void)delay {
    //1.使用performSelector方法,指定afterDelay为延时长度
    [self performSelector:@selector(testString) withObject:nil afterDelay:0.5];
    
    //2.在方法中使用NSThread的sleepForTimeInterval也可进行短暂挂起。
    [NSThread sleepForTimeInterval:0.5f];
    
    //3.使用`NSTimer`定时器延时触发任务
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(testString) userInfo:nil repeats:NO];
    
    //4.使用dispatch_after
    //NSEC_PER_SEC:秒 NSEC_PER_MSEC:毫秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}



@end
