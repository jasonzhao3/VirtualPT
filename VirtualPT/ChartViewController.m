//
//  ChartViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/13/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "ChartViewController.h"
#import "PNChart.h"
@interface ChartViewController ()

@end

@implementation ChartViewController

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog (@"the string is %@", self.titleString);
    
    [self drawPlot : self.titleString];
}


- (void)drawPlot:(NSString *)titleString
{
    if ([titleString isEqualToString:@"Daily Exercise Hours"])
        [self drawLinePlot];
    else if ([titleString isEqualToString:@"Daily Feelings"])
        [self drawBarPlot];
    else
        [self drawCirclePlot];
    
    self.title = self.titleString;
}

- (void)drawLinePlot
{
    //Add LineChart
    UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
    lineChartLabel.text = self.titleString;
    lineChartLabel.textColor = PNFreshGreen;
    lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    lineChartLabel.textAlignment = NSTextAlignmentCenter;
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart setXLabels:@[@"04/01/14",@"04/02/14",@"04/03/14",@"04/04/14",@"04/05/14"]];
    
    // Line Chart Nr.1
    NSArray * data01Array =@[@"1",@"3",@"1.5",@"2",@"3"];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data01Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart Nr.2
    NSArray * data02Array = @[@0.5, @1, @0.5, @1, @1];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data02Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    
//    lineChart.delegate = self;
    
    [self.chartScrollView addSubview:lineChartLabel];
    [self.chartScrollView addSubview:lineChart];
    
}


- (void) drawBarPlot
{
	//Add BarChart
    UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 30)];
    barChartLabel.text = self.titleString;
    barChartLabel.textColor = PNFreshGreen;
    barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    barChartLabel.textAlignment = NSTextAlignmentCenter;
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    barChart.backgroundColor = [UIColor clearColor];
    [barChart setXLabels:@[@"04/01/14",@"04/02/14",@"04/03/14",@"04/04/14",@"04/05/14",@"04/06/14",@"04/07/14"]];
    [barChart setYValues:@[@1,@24,@12,@18,@30,@10,@21]];
    [barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNYellow,PNGreen]];
    [barChart strokeChart];
    
    [self.chartScrollView addSubview:barChartLabel];
    [self.chartScrollView addSubview:barChart];

}

- (void)drawCirclePlot
{
    UILabel *circleChartLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 30)];
    circleChartLabel.text = @"Recovery Process";
    circleChartLabel.textColor = PNFreshGreen;
    circleChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    circleChartLabel.textAlignment = NSTextAlignmentCenter;
    
    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 80.0, SCREEN_WIDTH, 100.0) andTotal:[NSNumber numberWithInt:100] andCurrent:[NSNumber numberWithInt:60] andClockwise:NO];
    circleChart.backgroundColor = [UIColor clearColor];
    [circleChart setStrokeColor:PNGreen];
    [circleChart strokeChart];
    
    [self.chartScrollView addSubview:circleChartLabel];
    [self.chartScrollView addSubview:circleChart];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
