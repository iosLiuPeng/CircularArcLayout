//
//  SettingView.m
//  Example
//
//  Created by 刘鹏i on 2019/4/29.
//  Copyright © 2019 wuhan.musjoy. All rights reserved.
//

#import "SettingView.h"

@interface SettingView ()
@property (strong, nonatomic) IBOutlet UILabel *lblValue2;
@property (strong, nonatomic) IBOutlet UILabel *lblValue3;
@property (strong, nonatomic) IBOutlet UILabel *lblValue4;
@property (strong, nonatomic) IBOutlet UILabel *lblValue5;
@property (strong, nonatomic) IBOutlet UILabel *lblValue6;
@property (strong, nonatomic) IBOutlet UILabel *lblValue7;
@property (strong, nonatomic) IBOutlet UILabel *lblValue8;
@property (strong, nonatomic) IBOutlet UILabel *lblValue9;
@end

@implementation SettingView
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViewFromXib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self loadViewFromXib];
    }
    return self;
}

- (void)loadViewFromXib
{
    UIView *contentView = [[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    contentView.frame = self.bounds;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleHeight;
    [self addSubview:contentView];
}

#pragma mark - Set
- (void)setParameter:(Parameter *)parameter
{
    _parameter = parameter;
    
     _lblValue2.text = [NSString stringWithFormat:@"%.2f", _parameter.itemSizeRatio];
    UISlider *slider1 = (UISlider *)[self viewWithTag:101];
    [slider1 setValue:_parameter.itemSizeRatio animated:YES];
    
    _lblValue3.text = [NSString stringWithFormat:@"%.2f", _parameter.minScale];
    UISlider *slider2 = (UISlider *)[self viewWithTag:102];
    [slider2 setValue:_parameter.minScale animated:YES];
    
    _lblValue4.text = [NSString stringWithFormat:@"%ld", (long)_parameter.angle];
    UISlider *slider3 = (UISlider *)[self viewWithTag:103];
    [slider3 setValue:_parameter.angle animated:YES];
    
    _lblValue5.text = [NSString stringWithFormat:@"%ld", (long)_parameter.angleSpacing];
    UISlider *slider4 = (UISlider *)[self viewWithTag:104];
    [slider4 setValue:_parameter.angleSpacing animated:YES];
    
    _lblValue6.text = [NSString stringWithFormat:@"%.2f", _parameter.yOffsetRatio];
    UISlider *slider5 = (UISlider *)[self viewWithTag:105];
    [slider5 setValue:_parameter.yOffsetRatio animated:YES];
    
    _lblValue9.text = [NSString stringWithFormat:@"%.2f", _parameter.slidLengthRetio];
    UISlider *slider6 = (UISlider *)[self viewWithTag:106];
    [slider6 setValue:_parameter.slidLengthRetio animated:YES];
    
    _lblValue7.text = _parameter.clockwise? @"YES": @"NO";
    UISwitch *switch0 = (UISwitch *)[self viewWithTag:200];
    switch0.on = _parameter.clockwise;
    
    _lblValue8.text = _parameter.stepScroll? @"YES": @"NO";
    UISwitch *switch1 = (UISwitch *)[self viewWithTag:201];
    switch1.on = _parameter.stepScroll;
}

#pragma mark - Action
/// 滑块事件
- (IBAction)sliderAction:(UISlider *)sender {
    switch (sender.tag) {
        case 101:
            _parameter.itemSizeRatio = sender.value;
            break;
        case 102:
            _parameter.minScale = sender.value;
            break;
        case 103:
            _parameter.angle = sender.value;
            break;
        case 104:
            _parameter.angleSpacing = sender.value;
            break;
        case 105:
            _parameter.yOffsetRatio = sender.value;
            break;
        case 106:
            _parameter.slidLengthRetio = sender.value;
            break;
        default:
            break;
    }
    
    self.parameter = _parameter;

    if (_changedParameterBlock) {
        _changedParameterBlock(_parameter);
    }
}

/// 开关按钮事件
- (IBAction)switchAction:(UISwitch *)sender {
    switch (sender.tag) {
        case 200:
            _parameter.clockwise = sender.on;
            break;
        case 201:
            _parameter.stepScroll = sender.on;
            break;
        default:
            break;
    }
    
    self.parameter = _parameter;

    if (_changedParameterBlock) {
        _changedParameterBlock(_parameter);
    }
}

- (IBAction)doneAction:(id)sender {
    [self removeFromSuperview];
}

@end
