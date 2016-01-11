//
//  ViewController.h
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/11.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BETableViewRefresh.h"

@interface ViewController : UIViewController<BETableViewRefreshDelegate>

@property (nonatomic, strong) BETableViewRefresh *tableViewBE;


@end

