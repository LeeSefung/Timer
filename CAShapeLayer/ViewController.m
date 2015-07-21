//
//  ViewController.m
//  CAShapeLayer
//
//  Created by rimi on 15/7/21.
//  Copyright (c) 2015年 LeeSefung. All rights reserved.
//  https://github.com/LeeSefung/Timer.git
//

#import "ViewController.h"
#import "LSCircleProgressView.h"
#define LSColor [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]

@interface ViewController ()

//显示秒进度
@property (nonatomic, strong) UILabel *label;
//时间表
@property (nonatomic, strong) UILabel *timeLabel;

//秒进度0~9
@property (nonatomic, strong) LSCircleProgressView *secondTime;

//秒、分、时
@property (nonatomic, strong) LSCircleProgressView *secondProgress;
@property (nonatomic, strong) LSCircleProgressView *minuteProgress;
@property (nonatomic, strong) LSCircleProgressView *hourProgress;

@property (nonatomic, strong) UISlider *secondSlider;
@property (nonatomic, strong) UISlider *minuteSlider;
@property (nonatomic, strong) UISlider *hourSlider;

//计时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.secondTime = ({
        
        LSCircleProgressView *progress = [[LSCircleProgressView alloc] initWithFrame:CGRectMake(7.5, 40, 340, 340)];
        progress.trackColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        progress.progressColor = [UIColor orangeColor];
        progress.progress = .7;
        progress.progressWidth = 20;
        progress;
    });
    [self.view addSubview:self.secondTime];
    
    self.secondProgress = ({
        
        LSCircleProgressView *progress = [[LSCircleProgressView alloc] initWithFrame:CGRectMake(17.5, 50, 300, 300)];
        progress.trackColor = LSColor;
        progress.progressColor = [UIColor purpleColor];
        progress.progress = .7;
        progress.progressWidth = 20;
        progress;
    });
    [self.view addSubview:self.secondProgress];
    
    self.minuteProgress = ({
        
        LSCircleProgressView *progress = [[LSCircleProgressView alloc] initWithFrame:CGRectMake(17.5+10, 50+10, 260, 260)];
        progress.trackColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        progress.progressColor = [UIColor brownColor];
        progress.progress = .7;
        progress.progressWidth = 20;
        progress;
    });
    [self.view addSubview:self.minuteProgress];
    
    self.hourProgress = ({
        
        LSCircleProgressView *progress = [[LSCircleProgressView alloc] initWithFrame:CGRectMake(17.5+20, 50+20, 220, 220)];
        progress.trackColor = LSColor;
        progress.progressColor = [UIColor redColor];
        progress.progress = .7;
        progress.progressWidth = 20;
        progress;
    });
    [self.view addSubview:self.hourProgress];
    
    self.secondSlider = ({
        
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 450, 335, 30)];
        slider.minimumValue = 0;
        slider.maximumValue = 1;
        slider.tag = 10;
        [slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
        slider;
    });
    [self.view addSubview:self.secondSlider];
    
    self.minuteSlider = ({
        
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 450+50, 335, 30)];
        slider.minimumValue = 0;
        slider.maximumValue = 1;
        slider.tag = 11;
        [slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
        slider;
    });
    [self.view addSubview:self.minuteSlider];
    
    self.hourSlider = ({
        
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 450+100, 335, 30)];
        slider.minimumValue = 0;
        slider.maximumValue = 1;
        slider.tag = 12;
        [slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
        slider;
    });
    [self.view addSubview:self.hourSlider];
    
    self.label = ({
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 115)];
        label.textColor = [UIColor grayColor];
        label.center = CGPointMake(188, 250);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:150];
        label;
    });
//    [self.view addSubview:self.label];
    
    self.timeLabel = ({
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 115)];
        label.textColor = [UIColor grayColor];
        label.text = @"00:00:00";
        label.center = CGPointMake(187, 250);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:40];
        label;
    });
    [self.view addSubview:self.timeLabel];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0f target:self selector:@selector(updateSecond) userInfo:nil repeats:YES];
}

- (void)changeValue:(UISlider *)slider {
    
    if (slider.tag == 10) {
        self.secondProgress.progress = slider.value;
        return;
    }
    if (slider.tag == 11) {
        self.minuteProgress.progress = slider.value;
        return;
    }
    if (slider.tag == 12) {
        self.hourProgress.progress = slider.value;
        return;
    }
}

- (void)updateSecond {
    
    static int j = 0;
    self.secondTime.progress = j % 60 / 60.0;
    self.label.text = [NSString stringWithFormat:@"%d",(int)(j % 60 / 60.0 * 10) % 10];
    if (j%60 == 0) {
        [self timeUpdate];
    }
    j++;
}

- (void)timeUpdate {
    
    static int i = 1;
    self.secondProgress.progress = i % 60 / 60.0;
    self.minuteProgress.progress = i / 60 % 60 / 60.0;
    self.hourProgress.progress = i / 3600 % 12 / 12.0;
    self.secondSlider.value = self.secondProgress.progress;
    self.minuteSlider.value = self.minuteProgress.progress;
    self.hourSlider.value = self.hourProgress.progress;
    
    [self updateTimeLabel:i % 60 minute:i / 60 % 60 hour:i / 3600 % 12];
    i++;
}

- (void)updateTimeLabel:(int)second minute:(int)minute hour:(int)hour {
    
    NSMutableString *secondString, *minuteString, *hourString;
    
    if (second < 10) {
        
        secondString = [NSMutableString stringWithFormat:@"0%d",second];
    }else {
        
        secondString = [NSMutableString stringWithFormat:@"%d",second];
    }
    
    if (minute < 10) {
        
        minuteString = [NSMutableString stringWithFormat:@"0%d",minute];
    }else {
        
        minuteString = [NSMutableString stringWithFormat:@"%d",minute];
    }
    
    if (hour < 10) {
        
        hourString = [NSMutableString stringWithFormat:@"0%d",hour];
    }else {
        
        hourString = [NSMutableString stringWithFormat:@"%d",hour];
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hourString, minuteString, secondString];
}

@end
