//
//  BERefreshHeaderView.h
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/11.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BERefreshHeaderView : UIView

@property (nonatomic, strong) UILabel *freshLabel;

@property (nonatomic, strong) UIImageView *freshImgView;

@property (nonatomic, strong) UILabel *freshDataLabel;

-(void)setimgViewAnimation;

@end
