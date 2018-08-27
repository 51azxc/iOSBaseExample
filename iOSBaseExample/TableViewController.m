/*
 UITableViewController 简单使用
 */

#import "TableViewController.h"
#import "AlertViewController.h"
#import "CollectionViewController.h"
#import "GestureViewController.h"
#import "PageViewController.h"
#import "ScrollViewController.h"
#import "TextFieldViewController.h"
#import "TextViewController.h"
#import "WebAppViewViewController.h"
#import "TabBarViewController.h"
#import "AnimationViewController.h"
#import "PassValue1ViewController.h"

//必须要实现的两个代理
@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *list;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UITableViewStylePlain为方形
    //UITableViewStyleGrouped为圆角，类似系统设置页面
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    //指定分割线颜色
    self.tableView.separatorColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //创建Array的快捷方法
    self.list = @[@"Alert",
                  @"Collections",
                  @"Gesture",
                  @"PageControl",
                  @"ScrollView",
                  @"TextField",
                  @"TextView",
                  @"WebView",
                  @"TabBar",
                  @"Animation",
                  @"Pass value"];
    
    [self.view addSubview: self.tableView];
    
    //tableview默认铺满全屏，如果不喜欢这样可以如下设置，这样就是根据数据显示多少行。
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - 返回section个数
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

# pragma mark - 返回table行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.list count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    //使用定义的标记符表示需要重用的单元
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果没有多余的单元，则需创建
    if (cell == nil) {
        //UITableViewCellStyleDefault: 不能显示detailLabelText
        //UITableViewCellStyleSubtitle: detailLabelText显示在第二行
        //UITableViewCellStyleValue1: textLabel与detailTextLabel分别显示在两边
        //UITableViewCellStyleValue2: textLabel与detailTextLabel粘在一起显示
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.detailTextLabel.text = @"detail";
    //显示数组里面的内容
    cell.textLabel.text = [self.list objectAtIndex:indexPath.row];
    
    //UITableViewCellAccessoryNone: cell最右边不显示任何图标
    //UITableViewCellAccessoryCheckmark: 显示勾
    //UITableViewCellAccessoryDetailButton: 显示详细信息图标
    //UITableViewCellAccessoryDetailDisclosureButton: 显示详细信息图标与小箭头
    //UITableViewCellAccessoryDisclosureIndicator: 显示一个小箭头
    //如果不能满足可以使用cell.accessoryView来重绘指定一个UIView
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    //UITableViewCellSelectionStyleNone: cell选中状态为没有反应
    //UITableViewCellSelectionStyleDefault: 默认状态
    //UITableViewCellSelectionStyleBlue: 选中为蓝色状态
    //UITableViewCellSelectionStyleGray: 选中为灰色状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
# pragma mark - 设置行高
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
# pragma mark - 行缩进
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] % 2 == 0) {
        return 0;
    }
    return 1;
}
# pragma mark - 选择事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取当前cell在view中的位置
    CGRect cellRect = [self.tableView convertRect: [self.tableView rectForRowAtIndexPath: indexPath] toView: self.view];
    NSUInteger index = indexPath.row;
    NSLog(@"choose %@, cell rect: %@", self.list[index], [NSValue valueWithCGRect:cellRect]);
    switch (index) {
        case 0: {
            AlertViewController *viewController = [[AlertViewController alloc] init];
            //导航通过pushViewController方法跳转页面
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1: {
            CollectionViewController *viewController = [CollectionViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 2: {
            GestureViewController *viewController = [GestureViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 3: {
            PageViewController *viewController = [PageViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 4: {
            ScrollViewController *viewController = [ScrollViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 5: {
            TextFieldViewController *viewController = [TextFieldViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 6: {
            TextViewController *viewController = [TextViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 7: {
            WebAppViewViewController *viewController = [WebAppViewViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 8: {
            TabBarViewController *viewController = [TabBarViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 9: {
            AnimationViewController *viewController = [AnimationViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 10: {
            PassValue1ViewController *viewController = [PassValue1ViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
