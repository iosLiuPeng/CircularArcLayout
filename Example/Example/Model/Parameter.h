//
//  Parameter.h
//  Example
//
//  Created by 刘鹏i on 2019/4/29.
//  Copyright © 2019 wuhan.musjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Parameter : NSObject
@property (assign, nonatomic) NSInteger itemsDispaly;     ///< 元素显示个数（默认3，只能为单数）
@property (assign, nonatomic) CGFloat itemSizeRatio;      ///< item占大圆比例（0~1，默认0.2，显示的元素越多应该调得越小）
@property (assign, nonatomic) CGFloat minScale;           ///< item最小缩放大小（0~1，默认0.4）

@property (assign, nonatomic) CGFloat angle;              ///< 大圆可见的角度范围（0~180，默认60°）
@property (assign, nonatomic) CGFloat angleSpacing;       ///< item之间的间隔（0~180，默认将angle进行元素个数n等分）
@property (assign, nonatomic) CGFloat yOffsetRatio;       ///< 大圆的可见高度占视图总高度比例（0~1，默认0.2）
@property (strong, nonatomic) UIColor *circleColor;       ///< 大圆背景色（默认白色）

@property (assign, nonatomic) BOOL clockwise;             ///< 顺时针旋转（默认NO，逆时针）
@property (assign, nonatomic) BOOL stepScroll;            ///< 开启步长滑动，一次只能滑动一个（默认YES）
@property (assign, nonatomic) CGFloat slidLengthRetio;    ///< 滑动一个元素的长度占视图总宽度比例（0~1，默认0.3）
@end

NS_ASSUME_NONNULL_END
