//
//  ViewController.m
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/11.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableViewBE = [[BETableViewRefresh alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableViewBE.delegate = self;
    self.tableViewBE.dataArray = [NSMutableArray array];
    for(int i = 1; i < 20; i ++)
    {
        [self.tableViewBE.dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.tableViewBE.tableViewBE reloadData];
    [self.view addSubview:self.tableViewBE];
    
   // [self testCoredata];
    [self testAFN];
   // [self testRunTime];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    NSString *netStatus =  [BEAFNetworking getNowNetStatus];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 测试coredata
-(void)testCoredata
{
    [[BECoreData getInstance] insertPersonData:@"king" andAge:@"man" andSex:@"10"];
    [[BECoreData getInstance] insertPersonData:@"lily" andAge:@"woman" andSex:@"12"];
    NSMutableArray *arr = [[BECoreData getInstance] searchPersonByName:@"lily"];
    Person *person = arr[0];
    NSLog(@"%@,%@,%@",person.name,person.sex,person.age);
    [[BECoreData getInstance] updatePersonByName:@"king" andUpdateAgeCondition:@"15"];
    NSMutableArray *arr1 = [[BECoreData getInstance] searchPersonByName:@"king"];
    NSLog(@"%@",arr1);
    [[BECoreData getInstance] deletePersonByName:@"lily"];
    NSMutableArray *arr2 = [[BECoreData getInstance] searchPersonByName:@"lily"];
    NSLog(@"%@",arr2);
}

#pragma testAFN
-(void)testAFN
{
//    NSString *url = @"http://192.168.30.115:8080/mobiledoctor/casehistory/home/52081/101";
//    [BEAFNetworking get:url params:nil success:^(id responseObj) {
//        NSLog(@"%@",responseObj);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//    
//    NSString *url1 = @"http://192.168.20.127:8080/ihealth/personal/getList?page=1";
//     NSDictionary *parameters = @{@"sessionId":@"@5D0FBBMC1D767BD11012D@11CAFBCBF"};
//    [BEAFNetworking post:url1 params:parameters success:^(id responseObj) {
//        NSLog(@"%@",responseObj);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 100, 100)];
   
    for(int i = 0;i <= 50; i ++)
    {
        NSURL *urlImg = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.10.20:8838/getPng?patientId=0800394331&studyId=2015121415083069&seriesId=1.3.12.2.1107.5.1.4.65018.30000015121509475617100003543&index=%d",i]];
        NSLog(@"1111111");
        if(i == 50)
        {
            
        }
        [imgv setImageWithURL:urlImg];
    }

    [self.view addSubview:imgv];
}

#pragma 测试Runtime   修改类的私有变量
-(void)testRunTime
{
    BEPerson *person = [[BEPerson alloc] init];
    NSLog(@"%@",[person description]);
    
    unsigned int count = 0;
    Ivar *members = class_copyIvarList([BEPerson class], &count);
    for(int i = 0;i < count;i++)
    {
        Ivar var = members[i];
        const char *memberName = ivar_getName(var);
        const char *memberType = ivar_getTypeEncoding(var);
        NSLog(@"%s,%s",memberName,memberType);
    }
    Ivar m_name = members[0];
    object_setIvar(person, m_name, @"li");
    NSLog(@"%@",[person description]);
}

#pragma 刷新 加载更多
-(void)loadRefreshData
{
    [NSThread sleepForTimeInterval:2.0f];
    self.tableViewBE.dataArray = [NSMutableArray array];
    for(int i = 0; i < 15; i ++)
    {
        [self.tableViewBE.dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    [self.tableViewBE.tableViewBE reloadData];
}

-(void)loadMoreData
{
    [NSThread sleepForTimeInterval:2.0f];
    self.tableViewBE.dataArray = [NSMutableArray array];
    for(int i = 1; i < 100; i ++)
    {
        [self.tableViewBE.dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
        [self.tableViewBE.tableViewBE reloadData];

}

@end
