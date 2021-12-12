//
//  ProgessView.h
//  ProgressViewDemo
//
//  Created by 郭庆 on 2021/12/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgessView : UIView

@property (nonatomic, strong) UIColor *fromColor;
@property (nonatomic, strong) UIColor *toColor;

/// 进度值
@property (assign, nonatomic) CGFloat progress;
@end

NS_ASSUME_NONNULL_END
