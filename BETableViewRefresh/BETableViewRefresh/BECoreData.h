//
//  BECoreData.h
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/13.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Score.h"

@interface BECoreData : NSObject

+ (instancetype)getInstance;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//初始化Core Data使用的数据库
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;
//managedObjectModel的初始化赋值函数
-(NSManagedObjectModel *)managedObjectModel;
//managedObjectContext的初始化赋值函数
-(NSManagedObjectContext *)managedObjectContext;

#pragma -mark 增加person
-(void)insertPersonData:(NSString *)name andAge:(NSString *)age andSex:(NSString *)sex;

#pragma -mark 搜索person
-(NSMutableArray *)searchPersonByName:(NSString *)name;

#pragma -mark 更新person
-(void)updatePersonByName:(NSString *)name andUpdateAgeCondition:(NSString *)age;

#pragma -mark 删除person
-(void)deletePersonByName:(NSString *)name;


@end
