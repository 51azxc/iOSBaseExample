/*
 一些动画示例
 */

#import "AnimationViewController.h"
#import "TextFieldViewController.h"

@interface AnimationViewController ()

@property (strong, nonatomic) UIView *view1;

@end

@implementation AnimationViewController

@synthesize view1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view1.backgroundColor = [UIColor blueColor];
    view1.center = self.view.center;
    [self.view addSubview:view1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [self animation1];
    [self performSelector:@selector(animation2) withObject:nil afterDelay:3];
    [self performSelector:@selector(animation3) withObject:nil afterDelay:6];
    [self performSelector:@selector(animation4) withObject:nil afterDelay:9];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 通过动画上下文使用UIKit动画
- (void)animation1 {
    //开始动画
    [UIView beginAnimations:@"view1" context:nil];
    //动画时长
    [UIView setAnimationDuration:2];
    //开始动画设置
    view1.backgroundColor = [UIColor purpleColor];
    //将原来的矩形放大或者缩小，正数表示放大，负数表示缩小
    view1.frame = CGRectInset(view1.frame, 10, -10);
    view1.backgroundColor = [UIColor colorWithRed:100/255.0 green:222/255.0 blue:123/255.0 alpha:0.5];
    
    //动画结束
    [UIView commitAnimations];
}

#pragma mark - 通过animateWithDuration方法实现动画
- (void)animation2 {
    [UIView animateWithDuration:2 animations:^{
        //将原来的矩形变换位置
        self->view1.frame = CGRectOffset(self->view1.frame, 20, -20);
        self->view1.backgroundColor = [UIColor purpleColor];
    }];
}

#pragma mark - 通过CAKeyframeAnimation实现移动动画
- (void)animation3 {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    //初始化路径
    CGMutablePathRef path1 = CGPathCreateMutable();
    //动画起点
    CGPathMoveToPoint(path1, nil, view1.frame.origin.x, view1.frame.origin.y);
    CGPathAddCurveToPoint(path1, nil, 111, 222, 333, 444, 555, 666);
    [animation setPath:path1];
    [animation setDuration:2];
    //动画回到原位
    [animation setAutoreverses:YES];
    //设置渐出效果
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转
    animation.rotationMode = @"auto";
    
    [view1.layer addAnimation:animation forKey:@"position"];
}

#pragma mark - 通过CABasicAnimation实现形变动画
- (void)animation4 {
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithInt:6] forKey:kCATransactionAnimationDuration];
    //按x轴旋转
    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    flipAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //旋转180度,即M_PI
    flipAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    [flipAnimation setDuration:2];
    //旋转后保持状态
    [flipAnimation setFillMode:kCAFillModeForwards];
    [flipAnimation setRemovedOnCompletion:NO];
    [view1.layer addAnimation:flipAnimation forKey:@"flip"];
    [CATransaction commit];
}

#pragma mark - 自定义转场动画
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CATransition *transition = [CATransition animation];
    [transition setDuration:1];
    [transition setType:kCATransitionMoveIn];
    //从右边载入
    [transition setSubtype:kCATransitionFromRight];
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    TextFieldViewController *alertViewController = [[TextFieldViewController alloc] init];
    [self presentViewController:alertViewController animated:NO completion:nil];
}

@end
