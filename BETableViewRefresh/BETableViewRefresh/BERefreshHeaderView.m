//
//  BERefreshHeaderView.m
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/11.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "BERefreshHeaderView.h"

@implementation BERefreshHeaderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithRed:100.0/255 green:150.0/255 blue:100.0/255 alpha:1];
        self.freshLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 75, self.frame.size.height - 55, 150, 20)];
        self.freshLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.freshLabel];
        
        self.freshDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 100, self.frame.size.height - 25, 200, 20)];
        self.freshDataLabel.textAlignment = NSTextAlignmentCenter;
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.freshDataLabel.text = [dateFormatter stringFromDate:nowDate];
        [self addSubview:self.freshDataLabel];
        
        self.freshImgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, self.frame.size.height - 60, 50, 50)];
        
        [self addSubview:self.freshImgView];
    }
    return self;
}

-(void)setimgViewAnimation
{
    [self.freshImgView setAnimationDuration:0.5f];
    [self.freshImgView setAnimationRepeatCount:0];
    [self.freshImgView startAnimating];
}



@end
