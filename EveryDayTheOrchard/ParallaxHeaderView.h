//
//  ParallaxHeaderView.h
//  ParallaxTableViewHeader
//
//  Created by Vinodh  on 26/10/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.

//

#import <UIKit/UIKit.h>

@interface ParallaxHeaderView : UIView<UIScrollViewDelegate>
@property (nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (nonatomic) UIImage *headerImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic,strong)NSMutableArray *imageViews;         //保存多图情况下的imageView

@property (nonatomic,strong)UIImageView *currentShowImageView; //当前显示的imageView

#warning 适配多个image的情况 
+ (id)parallaxHeaderViewWithImages:(NSArray *)imageNames forSize:(CGSize)headerSize;
+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
+ (id)parallaxHeaderViewWithSubView:(UIView *)subView;
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;
- (void)refreshBlurViewForNewImage;
@end
