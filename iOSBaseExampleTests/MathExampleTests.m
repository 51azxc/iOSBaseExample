
/*
 一些数学函数使用
 */

#import <XCTest/XCTest.h>

@interface MathExampleTests : XCTestCase

@end

@implementation MathExampleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //指数运算
    XCTAssertEqual(pow(3, 2), 9);
    XCTAssertEqual(pow(3, 3), 27);
    
    //开平方运算
    XCTAssertEqual(sqrt(16), 4);
    XCTAssertEqual(sqrt(81), 9);
    
    //上舍入
    XCTAssertEqual(ceil(3.000000000001), 4);
    XCTAssertEqual(ceil(3.00), 3);
    
    //下舍入
    XCTAssertEqual(floor(3.000000000001), 3);
    XCTAssertEqual(floor(3.9999999), 3);
    
    //四舍五入
    XCTAssertEqual(round(3.5), 4);
    XCTAssertEqual(round(3.46), 3);
    XCTAssertEqual(round(-3.5), -4);
    
    //最小值
    XCTAssertEqual(fmin(5,10), 5);
    
    //最大值
    XCTAssertEqual(fmax(5,10), 10);
    
    //绝对值
    XCTAssertEqual(abs(10), 10);
    XCTAssertEqual(fabs(-10.0f), 10);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
