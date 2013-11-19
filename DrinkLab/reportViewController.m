//
//  reportViewController.m
//  BAC
//
//  Created by Subash Luitel on 4/3/13.
//  Copyright (c) 2013 Illinois Institute of Technology. All rights reserved.
//

#import "reportViewController.h"

@interface reportViewController (){
    
        CPTXYGraph *graph;
        CPTScatterPlot *ourPlot;
        CPTXYPlotSpace *plotSpace;
    
}

@end

@implementation reportViewController

@synthesize bacInfoArray, appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.theCalc = [[BACCalc alloc] init];
    
    NSNumber *eh = [NSNumber numberWithInt:1];
    [_theCalc addDrink:eh withAlcPercentage:eh];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setUpGraph];
}

//Get Data from the Core Data database
//This Method added by subash
//-(void) getData {
//    NSManagedObjectContext *context = [appDelegate managedObjectContext];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BACInfo" inManagedObjectContext:context];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setFetchBatchSize:20];
//    [request setEntity:entity];
//    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"timeDrank" ascending:NO];
//    NSArray *newArray = [NSArray arrayWithObject:sort];
//    [request setSortDescriptors:newArray];
//    NSError *error;
//    NSMutableArray *results = [[context executeFetchRequest:request error:&error] mutableCopy];
//    [self setBacInfoArray:results];
//}

-(void)setUpGraph
{
    //make graph and dark theme
    graph = [(CPTXYGraph *)[CPTXYGraph alloc] initWithFrame: _hostView.bounds];
    CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
    [graph applyTheme:theme];
    _hostView.hostedGraph = graph;
//    _hostView.allowPinchScaling = YES;
    
    // Graph title
    graph.title = @"BAC Graph";
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color                = [CPTColor blueColor];
    textStyle.fontName             = @"Helvetica-Bold";
    textStyle.fontSize             = 18.0;
    textStyle.textAlignment        = CPTTextAlignmentCenter;
    graph.titleTextStyle           = textStyle;
    graph.titleDisplacement        = CGPointMake(0.0, 25.0);
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    graph.paddingLeft = 10.0;
	graph.paddingTop = 10.0;
	graph.paddingRight = 10.0;
	graph.paddingBottom = 10.0;
    
    ourPlot = [[CPTScatterPlot alloc] init];
    ourPlot.identifier = @"Data Source Plot";
    ourPlot.cachePrecision = CPTPlotCachePrecisionDouble;
    ourPlot.dataSource = self;
    
    
    
    CPTMutableLineStyle *lineStyle    = [ourPlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth              = 2.0;
    lineStyle.lineColor              = [CPTColor greenColor];
    ourPlot.dataLineStyle = lineStyle;
    
    
    plotSpace = (id)graph.defaultPlotSpace;
    [graph addPlot: ourPlot toPlotSpace:plotSpace];
    
    
    // Auto scale the plot space to fit the plot data
    // Extend the y range by 10% for neatness
    
    
    [graph.defaultPlotSpace scaleToFitPlots:[graph allPlots]];
    
    graph.plotAreaFrame.paddingBottom = 50.0;
    graph.plotAreaFrame.paddingLeft = 30.0;
    
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromDouble(1.3f)];
    [xRange setLocation:CPTDecimalFromInt(0)];
    //  [xRange expandRangeByFactor:CPTDecimalFromDouble(1.1f)];
    [xRange setLength:CPTDecimalFromInt(8)];
    
    
    CPTPlotRange *globalXRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f)
                                                              length:CPTDecimalFromFloat(24.0f)];
    plotSpace.globalXRange = globalXRange;
    
    CPTPlotRange *globalYRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f)
                                                              length:CPTDecimalFromFloat(2.0f)];
    plotSpace.globalYRange = globalYRange;
    
    
    
    
    plotSpace.yRange = yRange;
    plotSpace.xRange = xRange;
    
//    plotSpace.allowsUserInteraction = YES;
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    CPTXYAxis *y = axisSet.yAxis;
    // y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0);
    y.axisConstraints = [[CPTConstraints alloc] initWithRelativeOffset:.0];
    
    
    
    
    CPTXYAxis *x = axisSet.xAxis;
    x.majorIntervalLength = CPTDecimalFromString(@"2.0");
    x.minorTicksPerInterval = 1;
    //     x.axisConstraints = [[CPTConstraints alloc] initWithRelativeOffset:.10f];
    x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0);
    
    [self refreshAxisLabels:x];
    
    
    
    
    
    ourPlot.interpolation = CPTScatterPlotInterpolationCurved;
}

-(void)refreshAxisLabels: (CPTXYAxis*)x
{
    
    x.labelRotation = M_PI/4;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    NSMutableArray *customTickLocations =  [[NSMutableArray alloc] init];
    for(int j = 0; j < 23; j++){
        [customTickLocations addObject:[NSDecimalNumber numberWithInt:j]];
    }
    NSUInteger labelLocation = 0;
    NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[self.theCalc.timeIndex count]];
    for (NSNumber *tickLocation in customTickLocations) {
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText: [self.theCalc.timeIndex objectAtIndex:labelLocation++] textStyle:x.labelTextStyle];
        newLabel.tickLocation = [tickLocation decimalValue];
        newLabel.offset = x.labelOffset + x.majorTickLength;
        newLabel.rotation = M_PI/4;
        [customLabels addObject:newLabel];
    }
    
    x.axisLabels =  [NSSet setWithArray:customLabels];
    [x setMajorTickLocations:[NSSet setWithArray:customTickLocations]];
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self.theCalc.bacValues count];
    
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if(fieldEnum==1)
        return [self.theCalc.bacValues objectAtIndex:index];
    
    if(fieldEnum==0)
        return [self.theCalc.bacIndex objectAtIndex:index];
    return 0;
    
}

-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    
    return nil;
}


@end
