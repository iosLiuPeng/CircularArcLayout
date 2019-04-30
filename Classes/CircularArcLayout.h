//
//  CircularArcLayout.h
//  Example
//
//  Created by 刘鹏i on 2019/4/8.
//  Copyright © 2019 wuhan.musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircularArcLayout : UICollectionViewLayout
@property (assign, nonatomic) IBInspectable CGFloat angle;              ///< 大圆可见的角度范围（1~180，默认50°）
@property (assign, nonatomic) IBInspectable CGFloat yOffsetRatio;       ///< 大圆的可见高度占视图总高度比例（0~1，默认0.2）
@property (strong, nonatomic) IBInspectable UIColor *circleColor;       ///< 大圆背景色（默认白色）

@property (assign, nonatomic) IBInspectable CGFloat angleSpacing;       ///< item之间的间隔（1~180，默认18）
@property (assign, nonatomic) IBInspectable CGFloat itemSizeRatio;      ///< item占视图高度比例（0~1，默认0.2，显示的元素越多应该调得越小）
@property (assign, nonatomic) IBInspectable CGFloat minScale;           ///< item最小缩放大小（0~1，默认0.4）

@property (assign, nonatomic) IBInspectable BOOL clockwise;             ///< 顺时针旋转（默认NO，逆时针）
@property (assign, nonatomic) IBInspectable BOOL stepScroll;            ///< 开启步长滑动，一次只能滑动一个（默认YES）
@property (assign, nonatomic) IBInspectable CGFloat slidLengthRetio;    ///< 滑动一个元素的长度占视图总宽度比例（0~1，默认0.3）

@property (copy, nonatomic) void(^scrollEndBlock)(NSInteger currentIndex);  ///< 滑动结束后，选中序号
@end

NS_ASSUME_NONNULL_END
