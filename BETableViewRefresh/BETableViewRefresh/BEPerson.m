//
//  BEPerson.m
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/14.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "BEPerson.h"

@interface BEPerson ()
{
    NSString *name;
}

-(void)sayHello;

@end

@implementation BEPerson

-(instancetype)init
{
    if(self = [super init])
    {
        name = @"zhang";
        self.age = 20;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@, age:%d", name, self.age];
}
- (void)sayHello
{
    NSLog(@"%@ says hello to you!", name);
}
- (void)sayGoodbay
{
    NSLog(@"%@ says goodbya to you!", name);
}

@end
