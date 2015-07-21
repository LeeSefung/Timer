//
//  LSCircleProgressView.h
//  CAShapeLayer
//
//  Created by rimi on 15/7/21.
//  Copyright (c) 2015年 LeeSefung. All rights reserved.
//  https://github.com/LeeSefung/Timer.git
//

#import <UIKit/UIKit.h>

@interface LSCircleProgressView : UIView {
    
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
}

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic) float progress;//0~1之间的数
@property (nonatomic) float progressWidth;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
