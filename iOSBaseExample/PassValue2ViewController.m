
/*
 iOS页面之间的传值
 委托传递
 */

#import "PassValue2ViewController.h"

@interface PassValue2ViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;

@end

@implementation PassValue2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width/2;
    CGFloat centerY = [UIScreen mainScreen].bounds.size.height/2;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(centerX - 50, centerY - 50, 100, 30)];
    self.label.text = self.msg;
    [self.view addSubview:self.label];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(centerX - 50, centerY - 15, 100, 30)];
    self.textField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:self.textField];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(centerX - 50, centerY + 20, 100, 30)];
    [self.button setTitle:@"Back" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendMessage {
    NSString *str = self.textField.text;
    //通过委托传值
    if (self.delegate && [self.delegate respondsToSelector:@selector(passValue:)]) {
        [self.delegate passValue:str];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
