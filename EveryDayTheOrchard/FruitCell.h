//
//  FruitCell.h
//  EveryDayTheOrchard
//
//  Created by hejiangshan on 16/4/18.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FruitModel.h"

@interface FruitCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *fruitName;
@property (weak, nonatomic) IBOutlet UILabel *fruitDescName;
@property (weak, nonatomic) IBOutlet UILabel *fruitWeight;
@property (weak, nonatomic) IBOutlet UILabel *price;

- (void)fillDataToCell:(FruitModel *)fruitModel;

@end
