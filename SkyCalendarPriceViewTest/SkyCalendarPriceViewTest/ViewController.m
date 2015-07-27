//
//  ViewController.m
//  SkyCalendarPriceViewTest
//
//  Created by skytoup on 15/7/24.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import "ViewController.h"
#import "SkyCalendarPriceView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SkyCalendarPriceView *v;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SkyCalendarPriceModel *model = [SkyCalendarPriceModel calendarPriceModelWithYear:@(2015) withMonth:@(3) withDay:@(22) withPrice:@(30) withCount:@(10)];
    SkyCalendarPriceModel *model2 = [SkyCalendarPriceModel calendarPriceModelWithYear:@(2015) withMonth:@(9) withDay:@(22) withPrice:@(10) withCount:@(10)];
    SkyCalendarPriceModel *model3 = [SkyCalendarPriceModel calendarPriceModelWithYear:@(2015) withMonth:@(7) withDay:@(24) withPrice:@(20) withCount:@(10)];
    _v.datas = @[model, model2, model3];
    _v.today = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
