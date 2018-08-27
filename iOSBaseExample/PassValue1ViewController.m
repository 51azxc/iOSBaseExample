
/*
 iOS页面之间的传值
 直接传递
 */

#import "PassValue1ViewController.h"
#import "PassValue2ViewController.h"

@interface PassValue1ViewController () <passValueDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;

@end

@implementation PassValue1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width/2;
    CGFloat centerY = [UIScreen mainScreen].bounds.size.height/2;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(centerX - 50, centerY - 50, 100, 30)];
    [self.view addSubview:self.label];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(centerX - 50, centerY - 15, 100, 30)];
    self.textField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:self.textField];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(centerX - 50, centerY + 20, 100, 30)];
    [self.button setTitle:@"Next" forState:UIControlStateNormal];
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
    PassValue2ViewController *viewController = [[PassValue2ViewController alloc] init];
    //直接赋值
    viewController.msg = str;
    //用于传值的委托
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)passValue:(NSString *)str {
    self.label.text = str;
}

@end
