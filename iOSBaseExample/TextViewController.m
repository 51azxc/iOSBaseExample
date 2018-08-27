/*
 关于TextView的简单使用
 TextView可以加载HTML页面，通过代理可以捕获链接
 */

#import "TextViewController.h"

@interface TextViewController () <UITextViewDelegate>

@property (strong, nonatomic) UITextView *textView;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.frame];
    
    NSString *message = @"<h1>Hello World</h1><p>click <a href='#'>this</a></p>";
    
    //将HTML格式的文字做对应的转换
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithData:[message dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    self.textView.attributedText = string;
    self.textView.delegate = self;
    //不允许编辑
    self.textView.editable = NO;
    
    //根据文字适配大小
    self.textView.translatesAutoresizingMaskIntoConstraints = YES;
    [self.textView sizeToFit];
    self.textView.center = self.view.center;
    [self.textView layoutIfNeeded];
    
    [self.view addSubview:self.textView];
    
    //如果需要捕捉点击事件，就要做如下设置
    self.textView.selectable = YES;
    //找到链接位置
    NSRange range = [string.string rangeOfString:@"this" options:NSBackwardsSearch];
    [string setAttributes:@{NSLinkAttributeName:@"link:",
                            NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                            NSUnderlineColorAttributeName:[UIColor blueColor]
                            } range:range];
}

#pragma mark - textview delegate代理方法,用于捕捉点击链接事件
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction  API_AVAILABLE(ios(10.0)){
    NSLog(@"url:%@",[URL absoluteString]);
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
