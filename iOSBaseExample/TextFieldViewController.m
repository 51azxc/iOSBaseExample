/*
 关于TextField的一些简单使用方法。
 */

#import "TextFieldViewController.h"

@interface TextFieldViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *usrText;
@property (strong, nonatomic) UITextField *pwdText;
@property (strong, nonatomic) UIButton *loginBtn;

@end

@implementation TextFieldViewController

@synthesize usrText, pwdText, loginBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //去掉navigation导航条
    [self.navigationController setNavigationBarHidden:YES];
    
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width/2;
    CGFloat centerY = [UIScreen mainScreen].bounds.size.height/2;
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:(200.0/255.0) green:(200.0/255.0) blue:(200.0/255.0) alpha: 0.8];
    //设置字体大小
    UIFont *font = [UIFont fontWithName:@"Arial" size:30];
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(centerX - 50, centerY - 120, 100, 60)];
    label.text = @"请登录";
    label.font = font;
    [self.view addSubview: label];
    
    UIView *usrView = [[UIView alloc] initWithFrame: CGRectMake(centerX - 130, centerY - 40, 260, 40)];
    usrView.backgroundColor = [UIColor whiteColor];
    //设置左上/右上角为圆角
    UIBezierPath *usrPath = [UIBezierPath bezierPathWithRoundedRect:usrView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5.0f, 5.0f)];
    CAShapeLayer *usrLayer = [[CAShapeLayer alloc] init];
    usrLayer.frame = usrView.bounds;
    usrLayer.path = usrPath.CGPath;
    usrView.layer.mask = usrLayer;
    
    //第一个文本框 x,y width,height
    usrText = [[UITextField alloc] initWithFrame: CGRectMake(5, 5, 250, 30)];
    usrText.backgroundColor = [UIColor whiteColor];
    //设置委托对象
    usrText.delegate = self;
    
    //键盘样式
    //UIKeyboardTypeDefault,                 默认键盘：支持所有字符
    //UIKeyboardTypeASCIICapable,            支持ASCII的默认键盘
    //UIKeyboardTypeNumbersAndPunctuation,   标准电话键盘，支持+*#等符号
    //UIKeyboardTypeURL,                     URL键盘，有.com按钮；只支持URL字符
    //UIKeyboardTypeNumberPad,               数字键盘
    //UIKeyboardTypePhonePad,                电话键盘
    //UIKeyboardTypeNamePhonePad,            电话键盘，也支持输入人名字
    //UIKeyboardTypeEmailAddress,            用于输入电子邮件地址的键盘
    usrText.keyboardType = UIKeyboardTypeDefault;
    //边框样式
    usrText.borderStyle = UITextBorderStyleNone;
    //替换弹出键盘的返回键
    //UIReturnKeyDefault,       默认：灰色按钮，标有Return
    //UIReturnKeyGo,            标有Go的蓝色按钮
    //UIReturnKeyGoogle,        标有Google的蓝色按钮，用于搜索
    //UIReturnKeyJoin,          标有Join的蓝色按钮
    //UIReturnKeyNext,          标有Next的蓝色按钮
    //UIReturnKeyRoute,         标有Route的蓝色按钮
    //UIReturnKeySearch,        标有Search的蓝色按钮
    //UIReturnKeySend,          标有Send的蓝色按钮
    //UIReturnKeyYahoo,         标有Yahoo!的蓝色按钮，用于搜索
    //UIReturnKeyDone,          标有Done的蓝色按钮
    //UIReturnKeyEmergencyCall, 紧急呼叫按钮
    usrText.returnKeyType = UIReturnKeyNext;
    //编辑时出现清除按钮
    //UITextFieldViewModeNever,         不出现
    //UITextFieldViewModeWhileEditing,  编辑时出现
    //UITextFieldViewModeUnlessEditing, 除了编辑外都出现
    //UITextFieldViewModeAlways         一直出现
    usrText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //键盘外观
    //UIKeyboardAppearanceDefault, 默认外观：浅灰色
    //UIKeyboardAppearanceAlert,   深灰/石墨色
    usrText.keyboardAppearance=UIKeyboardAppearanceDefault;
    //自动更正
    //UITextAutocorrectionTypeDefault,  默认
    //UITextAutocorrectionTypeNo,       不自动更正
    //UITextAutocorrectionTypeYes,      自动更正
    usrText.autocorrectionType = UITextAutocorrectionTypeYes;
    //自动首字母大写
    //UITextAutocapitalizationTypeNone,          不自动大写
    //UITextAutocapitalizationTypeWords,         单词首字母大写
    //UITextAutocapitalizationTypeSentences,     句子首字母大写
    //UITextAutocapitalizationTypeAllCharacters, 所有字母大写
    usrText.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    //文字对齐方式
    usrText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    usrText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //占位符
    usrText.placeholder = @"用户";
    //将文本框加入到主视图中
    [usrView addSubview: usrText];
    [self.view addSubview: usrView];
    
    UIView *pwdView = [[UIView alloc] initWithFrame: CGRectMake(centerX - 130, centerY + 1, 260, 40)];
    pwdView.backgroundColor = [UIColor whiteColor];
    //设置左下/右下角为圆角
    UIBezierPath *pwdPath = [UIBezierPath bezierPathWithRoundedRect:pwdView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0f, 5.0f)];
    CAShapeLayer *pwdLayer = [[CAShapeLayer alloc] init];
    pwdLayer.frame = pwdView.bounds;
    pwdLayer.path = pwdPath.CGPath;
    pwdView.layer.mask = pwdLayer;
    
    pwdText = [[UITextField alloc] initWithFrame: CGRectMake(5, 5, 250, 30)];
    pwdText.backgroundColor = [UIColor whiteColor];
    pwdText.borderStyle = UITextBorderStyleNone;
    pwdText.delegate = self;
    pwdText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    pwdText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    pwdText.placeholder = @"密码";
    //加密输入字符
    pwdText.secureTextEntry = YES;
    pwdText.returnKeyType = UIReturnKeyGo;
    pwdText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [pwdView addSubview: pwdText];
    [self.view addSubview: pwdView];
    
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(centerX - 130, centerY + 60, 260, 40)];
    //按钮颜色
    loginBtn.backgroundColor = [UIColor colorWithRed: (48.0/255.0) green: (113.0/255.0) blue: (169.0/255.0) alpha:1.0];
    //圆角半径
    [loginBtn.layer setCornerRadius:5.0];
    //边框宽度
    [loginBtn.layer setBorderWidth:1.0];
    //文字
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    //文字颜色
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.tintColor = [UIColor whiteColor];
    //添加点击事件
    [loginBtn addTarget: self action: @selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: loginBtn];
    
}

- (void)loginBtnClick:(id)sender {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView {
    long count = [textView.text length];
    NSLog(@"count: %ld", count);
}
# pragma mark - 捕获按下回车键事件
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (1 == range.length) {//回车键
        return YES;
    }
    if ([text isEqualToString:@"\n"]) {//按下return键
        //这里隐藏键盘，不做任何处理
        [textView resignFirstResponder];
        return NO;
    }else {
        if ([textView.text length] < 140) {//判断字符个数
            return YES;
        }
    }
    return NO;
}

# pragma mark - 当按下了返回按钮时触发的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:usrText]) {
        //获取焦点(键盘弹出)
        [usrText resignFirstResponder];
        //移除焦点(键盘回收)
        [pwdText becomeFirstResponder];
    }
    return YES;
}

# pragma mark - 点击空白处隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [usrText resignFirstResponder];
    [pwdText resignFirstResponder];
}

# pragma mark - 开始编辑时调用方法 -来自UITextFieldDelegate
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField:textField up:YES];
    
    //默认选中部分字符
    if ([textField isEqual:self.usrText] && [textField.text containsString:@"."]) {
        //如果为文件名时需要选中文件名部分，无需选中后缀
        NSRange range = [textField.text rangeOfString:@"." options:NSBackwardsSearch];
        UITextPosition *beginPosition = [textField positionFromPosition:textField.beginningOfDocument offset:0];
        UITextPosition *endPosition = [textField positionFromPosition:textField.beginningOfDocument offset:range.location];
        UITextRange *newRange = [textField textRangeFromPosition:beginPosition toPosition:endPosition];
        //定义选中区间
        [textField setSelectedTextRange:newRange];
    } else {
        [self.usrText selectAll:self];
    }
}
# pragma mark - 编辑结束后调用方法 -来自UITextFieldDelegate
-(void) textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField: textField up: NO];
}

# pragma mark - 弹出键盘后视图上移方法
-(void) animateTextField: (UITextField *) textField up: (BOOL) up {
    //设定上移偏移量，单位像素
    const int move = 80;
    //判定是否要上移
    int movement = (up ? -move:move);
    //设置动画名字
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画开始移动位置
    [UIView setAnimationBeginsFromCurrentState:YES];
    //设置动画持续时间
    [UIView setAnimationDuration: 0.3f];
    //设置动画的移动位移
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    //结束动画
    [UIView commitAnimations];
}

@end
