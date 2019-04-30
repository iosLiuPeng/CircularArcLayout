//
//  ViewController.m
//  Example
//
//  Created by 刘鹏i on 2019/4/8.
//  Copyright © 2019 wuhan.musjoy. All rights reserved.
//

#import "ViewController.h"
#import "CircleCollectionViewCell.h"
#import "CircularArcLayout.h"
#import "Parameter.h"
#import "SettingView.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *arrColor;

@property (strong, nonatomic) Parameter *parameter;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewConfig];
    
    [self dataConfig];
}

#pragma mark - Subjoin
- (void)viewConfig
{
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CircleCollectionViewCell class])];
}

- (void)dataConfig
{
    NSMutableArray *muarr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        
        UIColor *color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        [muarr addObject:color];
    }
    _arrColor = [muarr copy];
    
    
    CircularArcLayout *layout = (CircularArcLayout *)_collectionView.collectionViewLayout;
    
    _parameter = [[Parameter alloc] init];
    _parameter.itemSizeRatio = layout.itemSizeRatio;
    _parameter.minScale = layout.minScale;
    _parameter.angle = layout.angle;
    _parameter.angleSpacing = layout.angleSpacing;
    _parameter.yOffsetRatio = layout.yOffsetRatio;
    _parameter.clockwise = layout.clockwise;
    _parameter.stepScroll = layout.stepScroll;
    _parameter.slidLengthRetio = layout.slidLengthRetio;
}

#pragma mark - Set
- (void)setParameter:(Parameter *)parameter
{
    _parameter = parameter;
    
    CircularArcLayout *layout = (CircularArcLayout *)_collectionView.collectionViewLayout;
    layout.itemSizeRatio = parameter.itemSizeRatio;
    layout.minScale = parameter.minScale;
    layout.angle = parameter.angle;
    layout.angleSpacing = parameter.angleSpacing;
    layout.yOffsetRatio = parameter.yOffsetRatio;
    layout.clockwise = parameter.clockwise;
    layout.stepScroll = parameter.stepScroll;
    layout.slidLengthRetio = parameter.slidLengthRetio;
    
    [layout invalidateLayout];
}

#pragma mark - Action
- (IBAction)editAction:(id)sender {
    SettingView *view = [[SettingView alloc] initWithFrame:self.view.bounds];
    view.parameter = _parameter;
    __weak typeof(self) weakSelf = self;
    view.changedParameterBlock = ^(Parameter * _Nonnull parameter) {
        weakSelf.parameter = parameter;
    };
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:view];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择了: %@", indexPath);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrColor.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CircleCollectionViewCell class]) forIndexPath:indexPath];
    cell.bgColor = _arrColor[indexPath.row];
    cell.index = indexPath.row + 1;
    return cell;
}

@end
