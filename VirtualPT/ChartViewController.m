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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    //Add LineChart
	UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
	lineChartLabel.text = @"Line Chart";
	lineChartLabel.textColor = PNFreshGreen;
	lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
	lineChartLabel.textAlignment = NSTextAlignmentCenter;
	
	PNChart * lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 75.0, SCREEN_WIDTH, 200.0)];
    lineChart.type = PNLineType;
	lineChart.backgroundColor = [UIColor clearColor];
	[lineChart setXLabels:@[@"04/01/14",@"04/02/14",@"04/03/14",@"04/04/14",@"04/05/14", @"04/06/14"]];
	[lineChart setYValues:@[@"1",@"10",@"2",@"6",@"3", @"5"]];
	[lineChart strokeChart];
	[self.chartScrollView addSubview:lineChartLabel];
	[self.chartScrollView addSubview:lineChart];

//	//Add BarChart
////	
//	UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 30)];
//	barChartLabel.text = @"Daily Exercise Hours";
//	barChartLabel.textColor = PNFreshGreen;
//	barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
//	barChartLabel.textAlignment = NSTextAlignmentCenter;
//	
//	PNChart * barChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 150.0, SCREEN_WIDTH, 200.0)];
//	barChart.backgroundColor = [UIColor clearColor];
//	barChart.type = PNBarType;
//	[barChart setXLabels:@[@"04/01/14",@"04/02/14",@"04/03/14",@"04/04/14",@"04/05/14"]];
//	[barChart setYValues:@[@"1",@"3",@"1.5",@"2",@"3"]];
//	[barChart strokeChart];
//	[self.chartScrollView addSubview:barChartLabel];
//	[self.chartScrollView addSubview:barChart];
}

\
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
