//
//  BECoreData.m
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/13.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "BECoreData.h"

@implementation BECoreData

static BECoreData *coredata = nil;

+ (instancetype)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coredata = [[BECoreData alloc] init];
    });
    return coredata;
}
-(id)init {
    
    if (self = [super init]) {
        
    }
    return self;
}


+ (instancetype)alloc
{
    if (coredata) {
        return coredata;
    }
    return [super alloc];
}

- (id)copy
{
    if (coredata) {
        return coredata;
    }
    return [super copy];
}


-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return  _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        
        return _persistentStoreCoordinator;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folderPath = [NSString stringWithFormat:@"%@/Calendar",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    
    if(![fileManager fileExistsAtPath:folderPath]){//如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
        
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    NSLog(@"本地数据库路径:%@",folderPath);
    
    NSURL *storeURL = [NSURL fileURLWithPath:[folderPath stringByAppendingPathComponent:@"BECoreData.sqlite"]];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             
                             [NSNumber numberWithBool:YES],
                             
                             NSMigratePersistentStoresAutomaticallyOption,
                             
                             [NSNumber numberWithBool:YES],
                             
                             NSInferMappingModelAutomaticallyOption, nil];
    
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        abort();
        
    }
    
    return _persistentStoreCoordinator;
}
-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator =[self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc]init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma -mark 增加数据person
-(void)insertPersonData:(NSString *)name andAge:(NSString *)age andSex:(NSString *)sex
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Person *person = (Person *)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [person setName:name];
    [person setAge:age];
    [person setSex:sex];
    NSError *error;
    if([context save:&error])
    {
        NSLog(@"save person successfully");
    }else
    {
        NSLog(@"save person error:%@",error);
    }
}

#pragma -mark 搜索person
-(NSMutableArray *)searchPersonByName:(NSString *)name
{
    NSManagedObjectContext *context = [self managedObjectContext];
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person"inManagedObjectContext:context];
    //设置请求实体
    [request setEntity:entity];
    
    //查询条件
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name==%@",name];
    [request setPredicate:predicate];
    
    //指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError *error = nil;
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    NSMutableArray *entries = mutableFetchResult;
    NSLog(@"The count of person:%lu",(unsigned long)[entries count]);
    NSMutableArray *arr = [NSMutableArray array];
    for (Person *person in entries) {
        NSLog(@"%@",person);
        [arr addObject:person];
    }
    return arr;
}

#pragma -mark 更新person
-(void)updatePersonByName:(NSString *)name andUpdateAgeCondition:(NSString *)age
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    [request setEntity:user];
    
    
    //查询条件
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name==%@",name];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[context executeFetchRequest:request error:&error] mutableCopy];
    
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of Person: %lu",(unsigned long)[mutableFetchResult count]);
    //更新后要进行保存，否则没更新
    for (Person* person in mutableFetchResult) {
        [person setAge:age];
    }
    [context save:&error];
}

#pragma -mark 删除person
-(void)deletePersonByName:(NSString *)name
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* user=[NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    [request setEntity:user];
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name==%@",name];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[context executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of Person: %lu",(unsigned long)[mutableFetchResult count]);
    for (Person* person in mutableFetchResult) {
        [context deleteObject:person];
    }
    if ([context save:&error]) {
        NSLog(@"delete person ok!");
    }else
    {
        NSLog(@"delete person error:%@",error);
    }
}


@end
