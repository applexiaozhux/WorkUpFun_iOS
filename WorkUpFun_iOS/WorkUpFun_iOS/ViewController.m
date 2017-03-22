//
//  ViewController.m
//  WorkUpFun_iOS
//
//  Created by xiyang on 2017/3/18.
//  Copyright © 2017年 xiyang. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+Extension.h"
@interface ViewController ()

@property (nonatomic, retain) NSMutableArray *dateArr;
@property (nonatomic, retain) NSDateFormatter *formatter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self initSubViews];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initSubViews{
    
    NSDate *currentDate = [NSDate date];
    NSLog(@"current:%zd",currentDate.hour);
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    _dateArr = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        
        NSDate *d = [NSDate dateWithDaysFromNow:i];
        /*
        //测试
        if (i==0) {
            [_dateArr addObject:d];
        }
         */
        //end
        if ([d isTypicallyWorkday]) {
        
            [_dateArr addObject:d];
        }
    }
    //早上上班卡
    NSString *morningTime = [NSString stringWithFormat:@"08:%.2i",[self getRandomNumber:20 to:29]];
    [self configureWorkEndTime:morningTime];
    
//    //中午上班卡
    NSString *noonTime = [NSString stringWithFormat:@"13:%.2i",[self getRandomNumber:15 to:30]];
    [self configureWorkEndTime:noonTime];
//    
//    //下午下班卡
    NSString *eveningTime = [NSString stringWithFormat:@"18:%.2i",[self getRandomNumber:15 to:25]];
    [self configureWorkEndTime:eveningTime];
    
}

-(void)configureWorkEndTime:(NSString *)endTime{
    
    NSMutableArray *morningDate = [NSMutableArray array];
    for (NSDate *date in _dateArr) {
        
 //       endTime = [NSString stringWithFormat:@"15:39"]; //调试
        NSString *dateStr = [_formatter stringFromDate:date];
        NSMutableString *muStr = [[NSMutableString alloc] initWithString:dateStr];
        
        [muStr replaceCharactersInRange:NSMakeRange(11, 5) withString:endTime];
        //        NSLog(@"now:%@",muStr);
        NSDate *endDate = [_formatter dateFromString:muStr];
        [morningDate addObject:endDate];
    }
    
    for (NSDate *date in morningDate) {
        
        NSDate *nowDate = [NSDate date];
        
        NSLog(@"%zd",[nowDate minutesBeforeDate:date]);
        
        NSInteger minute = [nowDate minutesBeforeDate:date];
        if (minute>0) {
            NSTimeInterval furtue = minute*60;
            [self createNotificationWithTime:furtue];
        }
    }
    
}

-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

-(void)createNotificationWithTime:(NSTimeInterval)time{
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:time];
    localNotification.alertBody = @"记得打卡";
    localNotification.alertAction = @"你有没有忘记打卡啊，点点我吧～";
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.soundName = @"dingdang.caf";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.hasAction = YES;
    localNotification.alertLaunchImage = @"lunach";
//    localNotification.alertTitle = @"哈哈哈哈哈";
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}


- (IBAction)pushBtnAction:(UIButton *)sender {
    
//    for (int i=0; i<3; i++) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:10];
        localNotification.alertBody = @"记得打卡";
        localNotification.alertAction = @"哈哈哈，是不是忘了打卡？";
        localNotification.applicationIconBadgeNumber = 1;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertAction = @"Hello";
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    }
    
}





@end
