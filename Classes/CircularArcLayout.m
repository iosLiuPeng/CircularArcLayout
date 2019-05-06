//
//  CircularArcLayout.m
//  Example
//
//  Created by 刘鹏i on 2019/4/8.
//  Copyright © 2019 wuhan.musjoy. All rights reserved.
//

#import "CircularArcLayout.h"

@interface CircularArcLayout ()
@property (assign, nonatomic) NSInteger itemCount;      ///< 总元素个数
@property (assign, nonatomic) CGSize itemSize;          ///< 元素大小
@property (assign, nonatomic) NSInteger currnetIndex;   ///< 当前选中元素序号
@property (strong, nonatomic) UIView *viewCircle;       ///< 大圆
@property (assign, nonatomic) CGRect circleFrame;       ///< 大圆相对于scrollView的位置
@property (assign, nonatomic) BOOL sizeChange;          ///< collectionView大小改变
@end

@implementation CircularArcLayout
#pragma mark - Life Cycle
/// 初始化
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // 大圆的可见高度占视图总高度比例
        _yOffsetRatio = 0.2;
        
        // 大圆可见的角度范围
        _angle = 50;
        
        // item半径占大圆半径比例
        _itemSizeRatio = 0.2;
        
        // 角度间隔
        _angleSpacing = 18;
        
        // item最小缩放大小
        _minScale = 0.4;
        
        // 顺时针旋转
        _clockwise = NO;
        
        // 开启步长滑动，一次只能滑动一个
        _stepScroll = NO;
        
        // 滑动一个元素的长度占视图总宽度比例
        _slidLengthRetio = 0.3;
        
        // 大圆背景色
        _circleColor = [UIColor whiteColor];
    }
    return self;
}

/// 初始化完毕
- (void)awakeFromNib
{
    [super awakeFromNib];

    // 添加圆形背景
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.userInteractionEnabled = NO;
    view.backgroundColor = _circleColor;
    [self.collectionView.superview insertSubview:view belowSubview:self.collectionView];
    _viewCircle = view;
}

#pragma mark - Set
- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    _viewCircle.backgroundColor = circleColor;
}

#pragma mark - Overwrite
/// 布局准备
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 尺寸改变，恢复之前的偏移量
    if (_sizeChange) {
        _sizeChange = NO;
        CGPoint offset = {
            .x = _slidLengthRetio * CGRectGetWidth(self.collectionView.bounds) * _currnetIndex,
            .y = 0,
        };
        [self.collectionView setContentOffset:offset animated:NO];
    }
    
    _itemCount = [self.collectionView numberOfItemsInSection:0];

    // 大圆直径
    CGFloat diameter = CGRectGetWidth(self.collectionView.bounds) / (sinf(M_PI / 180 * _angle / 2.0));
    
    // 现对于collectionView.contentView位置
    CGRect circleFrame = {
        .origin.x = -(diameter - CGRectGetWidth(self.collectionView.bounds)) / 2.0 + self.collectionView.contentOffset.x,
        .origin.y = CGRectGetHeight(self.collectionView.bounds) * (1 - _yOffsetRatio),
        .size.width = diameter,
        .size.height = diameter,
    };
    _circleFrame = circleFrame;
    
    // 相对于collectionView.superview位置
    CGRect realFrame = {
        .origin.x = -(diameter - CGRectGetWidth(self.collectionView.bounds)) / 2.0 + self.collectionView.frame.origin.x,
        .origin.y = CGRectGetHeight(self.collectionView.bounds) * (1 - _yOffsetRatio) + self.collectionView.frame.origin.y,
        .size.width = diameter,
        .size.height = diameter,
    };
    _viewCircle.frame = realFrame;
    _viewCircle.layer.cornerRadius = diameter / 2.0;
    
    // 元素大小
    _itemSize = CGSizeMake(CGRectGetHeight(self.collectionView.bounds) * _itemSizeRatio, CGRectGetHeight(self.collectionView.bounds) * _itemSizeRatio);
}

/// 内容大小
- (CGSize)collectionViewContentSize
{
    CGSize size = self.collectionView.bounds.size;
    // 每多一个元素就多一段内容宽度
    size.width += _itemCount * _slidLengthRetio * CGRectGetWidth(self.collectionView.bounds);
    return size;
}

/// 返回指定范围内的所有元素的布局属性
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arrAttributes = [NSMutableArray array];
    
    // 最中心元素index
    NSInteger centerIndex = floor([self offsetCount]);
    if (centerIndex < 0) {
        centerIndex = 0;
    } else if (centerIndex >= _itemCount) {
        centerIndex = _itemCount - 1;
    }
    
    // 单边最多显示元素个数
    NSInteger maxItems = ceil(360.0 / _angleSpacing);
    
    // 已选序号
    NSMutableArray *arrIndex = [NSMutableArray arrayWithCapacity:maxItems];
    
    // 从中间开始，序号增大
    for (NSInteger i = centerIndex; i < centerIndex + maxItems; i++) {
        if (i < _itemCount) {
            // 取元素布局属性
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            if (CGRectIntersectsRect(self.collectionView.bounds, attributes.frame)) {
                // 在范围中
                [arrAttributes addObject:attributes];
                [arrIndex addObject:@(i)];
            } else {
                // 停止
                break;
            }
        }
    }
   
    // 从中间开始，序号减小
    for (NSInteger i = centerIndex; i > centerIndex - maxItems; i--) {
        if (i >= 0 && arrIndex.count < maxItems && [arrIndex containsObject:@(i)] == NO) {
            // 取元素布局属性
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            if (CGRectIntersectsRect(self.collectionView.bounds, attributes.frame)) {
                // 在范围中
                [arrAttributes addObject:attributes];
                [arrIndex addObject:@(i)];
            } else {
                // 停止
                break;
            }
        }
    }
    
    return arrAttributes;
}

// 移动了多少个元素
- (CGFloat)offsetCount
{
    return self.collectionView.contentOffset.x / (_slidLengthRetio * CGRectGetWidth(self.collectionView.bounds));
}

/// 返回每个元素的布局属性
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = _itemSize;
    
    // 移动了多少个元素
    CGFloat offsetCount = [self offsetCount];

    // 当前元素角度
    CGFloat angle = 90 + (offsetCount - indexPath.item) * _angleSpacing;
    // 中心点
    CGPoint center = {
        .x = CGRectGetMidX(_circleFrame) + (_clockwise? -1: 1) * CGRectGetWidth(_circleFrame) / 2.0 * cosf(angle / 180 * M_PI),
        .y = CGRectGetMidY(_circleFrame) + (-1) * CGRectGetWidth(_circleFrame) / 2.0 * sinf(angle / 180 * M_PI),
    };
    attributes.center = center;

    // 缩放比例间隔
    CGFloat intervalScale = (1 - _minScale) / (_angle / 2.0);
    // 缩放比例
    while (angle >= 360) {
        angle -= 360;
    }
    while (angle < 0) {
        angle += 360;
    }
    CGFloat scale = fmax(_minScale, 1 - fabs(angle - 90) * intervalScale);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    // 层次排序
    attributes.zIndex = indexPath.item;
    return attributes;
}

/// 返回停止滑动时的内容偏移量
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetX = proposedContentOffset.x;
    CGFloat itemConetntWidth = _slidLengthRetio * CGRectGetWidth(self.collectionView.bounds);

    if (_stepScroll) {
        // 步进滑动
        CGFloat differ = offsetX - _currnetIndex * itemConetntWidth;
        NSInteger addit = 0;
        
        if (differ >= itemConetntWidth * 0.5) {
            addit = 1;
        } else if (differ <= -itemConetntWidth * 0.5) {
            addit = -1;
        }
        
        NSInteger index = _currnetIndex + addit;
        if (index >= 0 && index < _itemCount) {
            _currnetIndex = index;
        }
    } else {
        // 推荐位置最近的元素
        NSInteger index = floor(offsetX / itemConetntWidth);
        index += (offsetX - index * itemConetntWidth) >= itemConetntWidth * 0.5? 1: 0;
        if (index >= _itemCount) {
            index = _itemCount - 1;
        } else if (index < 0) {
            index = 0;
        }
        
        _currnetIndex = index;
    }
    
    if (_scrollEndBlock) {
        _scrollEndBlock(_currnetIndex);
    }
    return CGPointMake(_currnetIndex * itemConetntWidth, 0);
}

/// Bounds改变后，是否需要重新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if (CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size) == NO) {
        _sizeChange = YES;
    }
    
    // 只要移动或改变大小就刷新，最高时，与屏幕刷新频率相当
    // TODO: 目前，CPU最高时占用25%，待优化。其实这里单次的计算量不大，根本还是执行频率太高了，所以优化应该从限制return YES;的频率入手
    return YES;
}

@end
