//
//  FruitDetailViewController.h
//  EveryDayTheOrchard
//
//  Created by hejiangshan on 16/4/19.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FruitModel.h"
#import "ParallaxHeaderView.h"

@interface FruitDetailViewController : UIViewController

@property(nonatomic,strong)FruitModel *fruitModel;

@property(nonatomic,strong)UIView *currentShowView;

@property(nonatomic,strong)ParallaxHeaderView *headerView;

@end
