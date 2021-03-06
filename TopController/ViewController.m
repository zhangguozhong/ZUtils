//
//  ViewController.m
//  TopController
//
//  Created by user on 2018/1/26.
//  Copyright © 2018年 user. All rights reserved.
//

#import "ViewController.h"
#import "NSString+ConvertToJson.h"
#import "NSArray+ConvertToJson.h"
#import "NSDictionary+ConvertToString.h"
#import "ZFullViewController.h"
#import "DeviceInfos.h"

@interface ViewController (){
    dispatch_queue_t serialQueue;
    NSString *globalVal;
}
@property (nonatomic, strong) NSString *ssdsg;

@property (nonatomic, strong) NSString *strKey;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.strKey = [NSString stringWithFormat:@"sdfsdfsdgsdg"];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *dict = @{
                           @"name":@"zhangsan",
                           @"id":@"10001",
                           @"cournces":@[@"数学",@"语文"],
                           @"className":@"三年二班"
                           };
    NSLog(@"%@",[dict toQueryString]);
    
    NSDictionary *dict2 = @{
                           @"name":@"",
                           @"id":@"",
                           @"cournces":@[@"数学",@"语文"],
                           @"className":@"三年二班"
                           };
    
    NSLog(@"%@", [dict2 toQueryString]);
    
    //NSString *urlString = @"http://www.test.com/index.html?key=sgsgs&name=[\"1\",\"2\",\"3\"]#demo?className=的幸福感的&noId=1001";
    NSString *urlString = [NSString stringWithFormat:@"http://www.test.com/index.html%@",[dict2 toQueryString]];
    
    NSMutableCharacterSet *testCha = [[NSMutableCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    //[testCha addCharactersInString:@"#"] ;
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[testCha copy]]];
    
    NSLog(@"urlString---%@",[url absoluteString]);
    NSURLComponents *conponents = [NSURLComponents componentsWithString:[url absoluteString]];
    NSLog(@"test--%@",conponents.queryItems);
    
    for (NSURLQueryItem *queryItem in conponents.queryItems) {
        //if ([queryItem.value isKindOfClass:[NSArray class]]) {
            NSLog(@"%@ - %@",queryItem.name,[queryItem.value toJson]);
        //}
    }
    //NSLog(@"testStr -- %@",conponents.percentEncodedFragment);
    
    NSArray *testA = @[@"1",@"2",@"3"];
    NSLog(@"str -- %@",[testA toJsonString]);
    
    NSMutableArray *testStr = [NSMutableArray array];
    static NSString *str = @"zsxvx";
    globalVal = [NSString stringWithFormat:@"fsdf"];
    NSLog(@"pre %p,%p",_strKey, &_strKey);
    void(^testBlock)(void) = ^{
        
        //testStr = [NSString stringWithFormat:@"ssdfsfs"];
        str = @"dfds";
        globalVal = [NSString stringWithFormat:@"dfsd"];
        self.strKey = [NSString stringWithFormat:@"sfdfsdsdfsd"];
        [testStr addObject:@"sfsdf"];
        NSLog(@"aft %p,%p",_strKey, &_strKey);
    };
    
    testBlock();
    NSLog(@"aft2 %p,%p",_strKey, &_strKey);
    NSLog(@"%@",testStr);
    NSLog(@"%@",self.strKey);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, 200, 40);
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    serialQueue = dispatch_queue_create("com.lai.www", DISPATCH_QUEUE_SERIAL);
//
//    [NSThread detachNewThreadSelector:@selector(readAction) toTarget:self withObject:nil];
//
//    [NSThread detachNewThreadSelector:@selector(writeAction) toTarget:self withObject:nil];
    
    
    NSArray *initArray = @[@"zhangsan",@"tangs",@"wangfd"];
    NSArray *newArray = [initArray sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
        return obj1 < obj2;
    }];
    
    NSLog(@"%@", newArray);
    
    NSString *test = @"dfjdhg54625467.poiiada65765";
    
    NSLog(@"sort string == %@",[test toSortString]);
}

- (void)handleAction{
    ZFullViewController *fullViewController = [[ZFullViewController alloc] init];
    [self.navigationController pushViewController:fullViewController animated:NO];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

//- (void)readAction {
//
//    for (int i = 0; i < 10; i++) {
//        dispatch_sync(serialQueue, ^{
//            // NSLog(@"1");
//            NSLog(@"read thread -- %@",[NSThread currentThread]);
//            sleep(3);
//            NSLog(@"read");
//        });
//    }
//}
//
//- (void)writeAction {
//
//    for (int j = 0; j < 10; j++) {
//        dispatch_sync(serialQueue, ^{
//            // NSLog(@"1");
//            NSLog(@"write thread -- %@",[NSThread currentThread]);
//            sleep(1);
//            NSLog(@"write");
//        });
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
