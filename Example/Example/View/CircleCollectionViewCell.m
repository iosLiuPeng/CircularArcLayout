//
//  CircleCollectionViewCell.m
//  Example
//
//  Created by 刘鹏i on 2019/4/28.
//  Copyright © 2019 wuhan.musjoy. All rights reserved.
//

#import "CircleCollectionViewCell.h"

@interface CircleCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIView *viewBg;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation CircleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.clipsToBounds = YES;
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    
    _viewBg.backgroundColor = bgColor;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    _lblTitle.text = [NSString stringWithFormat:@"%ld", (long)index];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.bounds.size.height / 2.0;
}

@end
