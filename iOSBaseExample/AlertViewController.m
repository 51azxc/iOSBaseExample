/*
 Alert是弹出框, iOS8之前使用的是UIAlertView, iOS8之后使用的是UIAlertController
 */

/*
 **iOS8**新增了`UIAlertController`用来代替之前的`UIAlertView`以及`UIActionSheet`。如今需要实现着两种弹出提示框不再需要实现各种的代理`<UIAlertViewDelegate>,<UIActionSheetDelegate>`,只需要指定对应的样式即可
 
 * `UIAlertControllerStyleActionSheet`: 对应之前的`UIActionSheet`
 * `UIAlertControllerStyleAlert`: 对应之前的`UIAlertView`
 
 对于新的`UIAlert`来说最大的变化可以添加任意的`TextField`,这样制作一个简单的输入框就方便多了
 */

#import "AlertViewController.h"

@interface AlertViewController ()<UIAlertViewDelegate>
@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //指定导航栏左边按钮的样式功能
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    //指定导航栏标题
    self.title = @"Alert";
}

- (void)viewWillAppear:(BOOL)animated {
    //更改navigationbar的颜色，会同时修改到navigation push的子视图及父视图
    UIColor *tintColor = [UIColor whiteColor];
    UIColor *barTintColor = [UIColor lightGrayColor];
    self.navigationController.navigationBar.tintColor = tintColor;
    self.navigationController.navigationBar.barTintColor = barTintColor;
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:tintColor, NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attr];
}

- (void)back {
    //返回上一视图
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - 点击屏幕产生事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 判断版本号
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Hello World" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        //查看是否显示
        NSLog(@"%d", alert.visible);
        //添加按钮
        [alert addButtonWithTitle:@"other"];
        //按钮总数
        NSLog(@"buttons: %ld",(long)alert.numberOfButtons);
        //根据索引获取按钮标题
        NSLog(@"button1: %@",[alert buttonTitleAtIndex:1]);
        //获取取消按钮索引
        NSLog(@"cancel button index: %ld",(long)alert.cancelButtonIndex);
        //显示alert
        [alert show];
    } else {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"UIAlertController" message:@"actionSheet or alert" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *defaultAlertAction = [UIAlertAction actionWithTitle:@"默认样式" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            
            UIAlertController *defaultAlert = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
            
            [defaultAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [defaultAlert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:defaultAlert animated:YES completion:nil];
        }];
        
        UIAlertAction *multiBtnAlertAction = [UIAlertAction actionWithTitle:@"多按钮" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            
            UIAlertController *multiBtnAlert = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
            
            //UIAlertActionStyleDefault为默认样式
            [multiBtnAlert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
                NSLog(@"Yes");
            }]];
            //UIAlertActionStyleDestructive为警告样式
            [multiBtnAlert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:^(UIAlertAction* action) {
                NSLog(@"No");
            }]];
            //UIAlertActionStyleCancel为取消样式
            [multiBtnAlert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {
                NSLog(@"Cancel");
            }]];
            
            [self presentViewController:multiBtnAlert animated:YES completion:nil];
        }];
        
        UIAlertAction *inputAlertAction = [UIAlertAction actionWithTitle:@"带输入框" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            
            UIAlertController *inputAlert = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
            
            [inputAlert addTextFieldWithConfigurationHandler:^(UITextField*  textField) {
                textField.placeholder = @"username";
            }];
            
            [inputAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
                textField.placeholder = @"password";
                textField.secureTextEntry = YES;
            }];
            
            [inputAlert addAction:[UIAlertAction actionWithTitle:@"Sign In" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
                UITextField *userInput = inputAlert.textFields.firstObject;
                UITextField *passwdInput = inputAlert.textFields.lastObject;
                NSLog(@"username: %@, password: %@", userInput.text, passwdInput.text);
            }]];
            
            [self presentViewController:inputAlert animated:YES completion:nil];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {
            NSLog(@"ActionSheet Cancel");
        }];
        
        [actionSheet addAction:defaultAlertAction];
        [actionSheet addAction:multiBtnAlertAction];
        [actionSheet addAction:inputAlertAction];
        [actionSheet addAction:cancelAction];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
}
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma mark - UIAlertView协议相关方法
//点击按钮触发的事件
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"click button index: %ld",(long)buttonIndex);
    
    //alertViewCancel方法是系统退出了alertview时被触发，
    //而不是点击了cancelButton后被触发，如果需要指定点击退出按钮触发，
    //可以使用`clickedButtonAtIndex`方法，通过其中的按钮索引判断是否点击了退出按钮再做下一步
    if (buttonIndex == alertView.cancelButtonIndex) {
        NSLog(@"cancel");
    }
}
//显示之前的事件
-(void)willPresentAlertView:(UIAlertView *)alertView {
    NSLog(@"willPresentAlertView");
}
//显示之后的事件
-(void)didPresentAlertView:(UIAlertView *)alertView {
    NSLog(@"didPresentAlertView");
}
//消失之前的事件
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"willDismissWithButtonIndex");
}
//消失完成后的事件
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"didDismissWithButtonIndex");
}
//被系统退出后的事件
-(void)alertViewCancel:(UIAlertView *)alertView {
    NSLog(@"alertViewCancel");
}

@end
