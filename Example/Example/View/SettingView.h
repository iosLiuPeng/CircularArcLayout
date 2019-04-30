//
//  SettingView.h
//  Example
//
//  Created by 刘鹏i on 2019/4/29.
//  Copyright © 2019 wuhan.musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parameter.h"
NS_ASSUME_NONNULL_BEGIN

@interface SettingView : UIView
@property (strong, nonatomic) Parameter *parameter;

@property (copy, nonatomic) void(^changedParameterBlock)(Parameter *parameter);
@end

NS_ASSUME_NONNULL_END
