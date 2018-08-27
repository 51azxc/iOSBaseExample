/*
 UIViewController生命周期
 
 视图控制对象通过alloc和init来创建，但是视图控制对象不会在创建的那一刻就马上创建相应的视图，而是等到需要使用的时候才通过调用loadView来创建，这样的做法能提高内存的使用率。比如，当某个标签有很多UIViewController对象，那么对于任何一个UIViewController对象的视图，只有相应的标签被选中时才会被创建出来。

 */

/*
 利用setNeedsStatusBarAppearanceUpdate方法隐藏状态栏
 */

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

# pragma mark - UIViewController加载视图时调用
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

# pragma mark - UIViewController对象的视图即将加入窗口时调用
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //调用此方法可以隐藏状态栏
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - UIViewController对象的视图已经加入到窗口时调用
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    TableViewController *viewController = [[TableViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UIViewController对象的视图即将消失、被覆盖或是隐藏时调用
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - UIViewController对象的视图已经消失、被覆盖或是隐藏时调用
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - 控制屏幕旋转方向
//只支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
//禁止旋转
- (BOOL)shouldAutorotate {
    return NO;
}
//初始屏幕旋转方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


@end
