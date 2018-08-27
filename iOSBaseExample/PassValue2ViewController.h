
#import <UIKit/UIKit.h>

//定义用于传值的委托
@protocol passValueDelegate <NSObject>

- (void)passValue:(NSString *)str;

@end

@interface PassValue2ViewController : UIViewController

// 用于直接传递的值
@property (nonatomic, strong) NSString *msg;
// 用于传值的委托
@property (nonatomic, weak) id<passValueDelegate> delegate;

@end
