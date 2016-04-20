//
//  FruitCell.m
//  EveryDayTheOrchard
//
//  Created by hejiangshan on 16/4/18.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "FruitCell.h"

@implementation FruitCell

- (void)fillDataToCell:(FruitModel *)fruitModel
{
    self.headerImageView.image = [UIImage imageNamed:fruitModel.imageName];
    self.fruitName.text = fruitModel.fruitName;
    self.fruitDescName.text = fruitModel.fruitDesc;
    self.fruitWeight.text = fruitModel.fruitWeight;
    self.price.text = fruitModel.fruitPrice;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerImageView.layer.cornerRadius = 5;
    self.headerImageView.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
