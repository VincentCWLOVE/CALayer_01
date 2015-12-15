//
//  ViewController.m
//  CALayer_01
//
//  Created by vincent on 15/12/15.
//  Copyright © 2015年 vincent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UIImageView *bg;

@property (nonatomic, weak) IBOutlet UIImageView *hour;
@property (nonatomic, weak) IBOutlet UIImageView *minute;
@property (nonatomic, weak) IBOutlet UIImageView *second;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = self.testView.bounds;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.anchorPoint = CGPointMake(0, 0);
    [self.testView.layer addSublayer:layer];
    
  
    
    //改变锚点，实质适应
    self.second.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minute.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.hour.layer.anchorPoint = CGPointMake(0.5f, 0.9f);

    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    //set initial hand positions
    [self tick];
    
    
    
}
- (void)tick
{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    //calculate hour hand angle //calculate minute hand angle
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
    self.hour.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minute.transform = CGAffineTransformMakeRotation(minsAngle);
    self.second.transform = CGAffineTransformMakeRotation(secsAngle);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
