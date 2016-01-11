//
//  BELoadMoreView.m
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/11.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "BELoadMoreView.h"

@implementation BELoadMoreView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
       // self.backgroundColor = [UIColor colorWithRed:100.0/255 green:150.0/255 blue:100.0/255 alpha:1];
        self.moreImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 25, self.frame.size.height - 55, 50, 50)];
        [self addSubview:self.moreImgView];
    }
    return self;
}

-(void)setimgViewAnimation
{
    [self.moreImgView setAnimationDuration:0.5f];
    [self.moreImgView setAnimationRepeatCount:0];
    [self.moreImgView startAnimating];
}


@end
