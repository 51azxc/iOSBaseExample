
/*
 自定义TabBar
 */

#import "TabBarViewController.h"
#import "WebAppViewViewController.h"
#import "ScrollViewController.h"
#import "CommonUtil.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WebAppViewViewController *firstViewController = [[WebAppViewViewController alloc] init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    ScrollViewController *secondViewController = [ScrollViewController new];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    
    //加载的视图
    self.viewControllers = @[firstNav, secondNav];
    //显示tabBar
    //self.tabBar.hidden = YES;
    
    UIImage *selectedImage = [CommonUtil createImageWithColor:[UIColor redColor] andSize:CGSizeMake(50, 50)];
    UIImage *unSelectedImage = [CommonUtil createImageWithColor:[UIColor grayColor] andSize:CGSizeMake(50, 50)];
    //设置选中的图片
    [self.tabBar setSelectionIndicatorImage:selectedImage];
    //更改第一个按钮的名称
    [[self.tabBar.items objectAtIndex:0] setTitle:@"First"];
    //设置按钮名称的位置，默认在底部
    [[self.tabBar.items objectAtIndex:0] setTitlePositionAdjustment:UIOffsetMake(0, -15)];
    //设置按钮名称属性，主要是修改字体大小，默认比较小
    [[self.tabBar.items objectAtIndex:0] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:16], NSFontAttributeName, nil] forState:UIControlStateNormal];
    //同样设置第二个按钮
    [[self.tabBar.items objectAtIndex:1] setTitle:@"Second"];
    [[self.tabBar.items objectAtIndex:1] setTitlePositionAdjustment:UIOffsetMake(0, -15)];
    [[self.tabBar.items objectAtIndex:1] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:16], NSFontAttributeName, nil] forState:UIControlStateNormal];
    //设置tabBar的位置大小，主要更改位置，默认tabBar在底部
    self.tabBar.frame = CGRectMake(0, 64, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
    //设置tabBar的背景图片
    [self.tabBar setBackgroundImage:unSelectedImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
