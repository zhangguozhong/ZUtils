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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *dict = @{
                           @"name":@"zhangsan",
                           @"id":@"10001",
                           @"cournces":@[@"数学",@"语文"],
                           @"className":@"三年二班"
                           };
    NSLog(@"%@",[dict toQueryString]);
    
    //NSString *urlString = @"http://www.test.com/index.html?key=sgsgs&name=[\"1\",\"2\",\"3\"]#demo?className=的幸福感的&noId=1001";
    NSString *urlString = [NSString stringWithFormat:@"http://www.test.com/index.html%@",[dict toQueryString]];
    
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
