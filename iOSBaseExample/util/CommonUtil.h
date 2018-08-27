/*
 一些零散的功能收集。
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonUtil : NSObject

//HexColor转UIColor
+ (UIColor *)getUIColorWithHexColor: (NSString *)hexColor andAlpha: (CGFloat)alpha;
//根据颜色生成图片
+ (UIImage *)createImageWithColor: (UIColor *)color andSize: (CGSize)size;
//缩放图片
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size;
//md5加密
+ (NSString *)md5:(NSString *) str;
//sha1加密
+ (NSString *)sha1: (NSString *) str;
//HMAC SHA1加密
+ (NSString *)hmacsha1:(NSString *)text key:(NSString *)secret;
//随机生成颜色
+ (UIColor *)randomColor;
//使Button图标文字上下排列
+ (void)setButtonImageUpAndTitleDown: (UIButton *)button;
//label根据文字内容自适应高度
+ (void)labelFit:(UILabel *)label;
//删除所有的子视图
+ (void)removeAllSubviews:(UIView *)view;
//使SubView居中
+ (void)subViewCenter:(UIView *)subView parentView:(UIView *)parentView;

@end
