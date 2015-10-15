//
//  ViewController.m
//  TestGraphy
//
//  Created by Craig McFarlane on 2/09/2015.
//  Copyright (c) 2015 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyViewController.h"

#import "dbc_def.h"
#import "GraphyView.h"
#import "GraphyLabel.h"
#import "GraphyPlot.h"
#import "GraphyPlotPart.h"
#import "GraphyFill.h"
#import "GraphyLegend.h"
#import "trace_def.h"


@interface GraphyViewController (hidden)

-(void)updateDisplay;

@end


#define TRACE_FLAG  (NO)

@implementation GraphyViewController

// ============================================================================================


-(void)viewDidLoad {
    TRACE_START();
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateDisplay];
}

// ============================================================================================


-(void)didReceiveMemoryWarning {
    TRACE_START();
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ============================================================================================


/**
 * does all the calculations needed for the graph
 *
 * this could be done in a different thread - perhaps even as part of the TOU Operation we're already using
 *
 * This example uses a contrived power use profile we've hard-coded here for convenience.
 * We also have a list of known tariffs and their respective colors.
 * The power use profile consists of five days of power readings
 * Each day is split into four tariff segments.  Each segment consists of the tariff and
 * the power used under that tariff.
 */
-(void)setupGraphView {
    NSMutableArray* plots = nil;
    NSMutableArray* plotParts = nil;
    NSMutableArray* xLabels = nil;
    GraphyLegend* legend = nil;
    
    TRACE_START();
    
    TRACE_CHECK( @"graph.bounds (%f:%f),(%f:%f)", self.graph.bounds.origin.x, self.graph.bounds.origin.y, self.graph.bounds.size.width, self.graph.bounds.size.height);
    TRACE_CHECK( @"self.graph.contentScaleFactor: %f", self.graph.contentScaleFactor);
    
    // pull apart readings and update graph
    NSArray* readings = @[
                          @{
                              @"reading_time":@"01-10-2010T10:43:10",
                              @"reading_value":@12312.77,
                              @"tou":@[
                                      @{
                                          @"tariff":@1,
                                          @"value":@4.00
                                          },
                                      @{
                                          @"tariff":@2,
                                          @"value":@45.00
                                          },
                                      @{
                                          @"tariff":@3,
                                          @"value":@53.00
                                          },
                                      @{
                                          @"tariff":@4,
                                          @"value":@43.00
                                          }
                                      ]
                              },
                          @{
                              @"reading_time":@"02-10-2010T10:43:10",
                              @"reading_value":@12312.77,
                              @"tou":@[
                                      @{
                                          @"tariff":@1,
                                          @"value":@43.00
                                          },
                                      @{
                                          @"tariff":@2,
                                          @"value":@4.00
                                          },
                                      @{
                                          @"tariff":@3,
                                          @"value":@3.00
                                          },
                                      @{
                                          @"tariff":@4,
                                          @"value":@53.00
                                          }
                                      ]
                              },
                          @{
                              @"reading_time":@"03-10-2010T10:43:10",
                              @"reading_value":@12312.77,
                              @"tou":@[
                                      @{
                                          @"tariff":@1,
                                          @"value":@33.00
                                          },
                                      @{
                                          @"tariff":@2,
                                          @"value":@24.00
                                          },
                                      @{
                                          @"tariff":@3,
                                          @"value":@13.00
                                          },
                                      @{
                                          @"tariff":@4,
                                          @"value":@23.00
                                          }
                                      ]
                              },
                          @{
                              @"reading_time":@"04-10-2010T10:43:10",
                              @"reading_value":@12312.77,
                              @"tou":@[
                                      @{
                                          @"tariff":@1,
                                          @"value":@11.00
                                          },
                                      @{
                                          @"tariff":@2,
                                          @"value":@29.00
                                          },
                                      @{
                                          @"tariff":@3,
                                          @"value":@7.00
                                          },
                                      @{
                                          @"tariff":@4,
                                          @"value":@44.00
                                          }
                                      ]
                              },
                          @{
                              @"reading_time":@"05-10-2010T10:43:10",
                              @"reading_value":@12312.77,
                              @"tou":@[
                                      @{
                                          @"tariff":@1,
                                          @"value":@11.00
                                          },
                                      @{
                                          @"tariff":@2,
                                          @"value":@29.00
                                          },
                                      @{
                                          @"tariff":@3,
                                          @"value":@7.00
                                          },
                                      @{
                                          @"tariff":@4,
                                          @"value":@44.00
                                          }
                                      ]
                              }
                          ];
    NSEnumerator* readingEnum = [readings objectEnumerator];
    NSDictionary* thisReading = nil;
    float maxDayPower = 0.0;
    plots = [[NSMutableArray alloc] init];
    UIFont* labelFont = [UIFont systemFontOfSize:12.0];
    NSInteger plotNo = 0;
    
    /* create the array of x axis labels.  If you want to put a label at the origin,
     * put something other than a blank string there like we have.
     */
    xLabels = [[NSMutableArray alloc] initWithObjects:@"", nil];
    
    // set up legend - a list of tariffs and their respective colors
    UIFont* legendFont = [UIFont systemFontOfSize:32.0];
    legend = [[GraphyLegend alloc] initWithFont:legendFont color:[UIColor whiteColor]];
    legend.labelHeading = NSLocalizedString( @"Tariff", @"Tariff");
    legend.colorHeading = NSLocalizedString( @"Color", @"Color");
    NSArray* daysOfWeek = @[@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun"];
    NSDictionary* tariffInfo = @{
                                 @1:@{@"Color":@"redColor", @"Rate":@1.20},
                                 @2:@{@"Color":@"greenColor", @"Rate":@2.30},
                                 @3:@{@"Color":@"brownColor", @"Rate":@3.40},
                                 @4:@{@"Color":@"blueColor", @"Rate":@4.50}
                                 };
    
    self.titleLabel.text = @"Segmented Bar Chart";
    self.titleLabel.textColor = [UIColor whiteColor];
    
    // for each reading, construct a plot from the component segments
    /* each reading consists of a single day, split into four tariff segments
     * each segment has a tariff name, and the amount of power used with that tariff
     */
    while (thisReading = [readingEnum nextObject])
    {
        TRACE_CHECK( @"thisReading: %@", thisReading);
        
        // create x-axis label
        /* if this was serious, we'd get the date from the reading and convert it to a DOW
         * but for this we'll just grab it out of our day of week array.
         */
        NSString* labelText = daysOfWeek[plotNo];
        GraphyLabel* plotLabel = nil;
        [xLabels addObject:labelText];
        
        // for each tariff, calculate the segment
        NSArray* tariffs = [thisReading objectForKey:@"tou"];
        NSEnumerator* tariffEnum = [tariffs objectEnumerator];
        NSDictionary* thisTariff = nil;
        plotParts = [[NSMutableArray alloc] init];
        float thisDayPower = 0.0;
        while (thisTariff = [tariffEnum nextObject])
        {
            // for each tariff segment, get the tariff name, power value, relevant color and make a new plot part
            float tariffPower = [[thisTariff objectForKey:@"value"] floatValue];
            thisDayPower += tariffPower;
            NSDecimalNumber* tariffNo = [thisTariff objectForKey:@"tariff"];
            TRACE_CHECK( @"tariffNo: %@", tariffNo);
            NSString* tariffName = [tariffNo stringValue];
            TRACE_CHECK( @"tariffName: %@", tariffName);
            NSDictionary* thisTariffInfo = [tariffInfo objectForKey:tariffNo];
            SEL mySel = NSSelectorFromString( [thisTariffInfo objectForKey:@"Color"]);
            UIColor* tariffColor = [UIColor performSelector:mySel];
            GraphyFill* partFill = [[GraphyFill alloc] initWithText:tariffName startColor:tariffColor endColor:tariffColor];
            GraphyPlotPart* plotPart = [[GraphyPlotPart alloc] initWithValue:tariffPower fill:partFill];
            [plotParts addObject:plotPart];
            
            // if the legend hasn't learnt this tariff, add it
            if (![legend hasName:tariffName])
            {
                [legend addName:tariffName color:tariffColor];
            }
        }
        // this is to remember the maximum Y value of the chart which we'll use later
        if (thisDayPower > maxDayPower)
        {
            maxDayPower = thisDayPower;
        }
        // make a new plot from the plot parts
        GraphyPlot* thisPlot = [[GraphyPlot alloc] initWithBaseCoord:plotNo+1 width:25.0 label:plotLabel parts:plotParts];
        [plots addObject:thisPlot];
        plotNo++;
    }
    TRACE_CHECK( @"plots: %@", plots);
    
    /* In this case we won't worry about rounding the numbers to nearest 50 or 100,
     * but you could do that.  In this case they'll be odd looking, but sane numbers.
     */
    float yMajorInc = trunc( maxDayPower / 5);
    
    // set up graphy view
    [self.graph setLegend:legend];
    [self.graph setXOrigin:0.0];
    [self.graph setYOrigin:0.0];
    [self.graph setXMajorGraduation:1.0];
    [self.graph setXMinorGraduation:1.0];
    [self.graph setYMajorGraduation:yMajorInc];
    [self.graph setYMinorGraduation:5.00];
    TRACE_CHECK( @"xLabels: %@", xLabels);
    [self.graph setXMajorGraduationLabels:xLabels];		// make strings for X Axis graduations
    
    // make labels for major Y graduations.
    NSMutableArray* yLabels = [[NSMutableArray alloc] init];
    for ( float dayPower = 0; dayPower < maxDayPower; dayPower += yMajorInc) {
        // make strings for Y Axis graduations
        NSString* thisLabel = [NSString stringWithFormat:@"%2.0f", dayPower];
        TRACE_CHECK( @"thisLabel: %@", thisLabel);
        [yLabels addObject:thisLabel];
    }
    TRACE_CHECK( @"yLabels: %@", yLabels);
    [self.graph setYMajorGraduationLabels:yLabels];		// make strings for X Axis graduations
    
    GraphyLabel* xLabel = [[GraphyLabel alloc] initWithText:@"Day of Week" color:[UIColor whiteColor] font:labelFont angle:0];
    [self.graph setXLabel:xLabel];
    GraphyLabel* yLabel = [[GraphyLabel alloc] initWithText:@"kWh" color:[UIColor whiteColor] font:labelFont angle:0];
    [self.graph setYLabel:yLabel];
    [self.graph setXRangeWithMin:0.0 max:[readings count]];
    [self.graph setYRangeWithMin:0.0 max:maxDayPower];
    [self.graph setPlots:plots];
    TRACE_END();
}

// ============================================================================================


/**
 * updates the display with info from model
 */
-(void)updateDisplay {
    TRACE_START();
    /* we're doing the graph calculations here, but we could do them anywhere prior to the display update,
     * including in another thread.
     */
    [self setupGraphView];
    
    [self.graph setNeedsDisplay];
    TRACE_END();
    return;
}

// ============================================================================================


/**
 * called when the user touches the graph
 *
 * @param qSender the button that was pressed
 */
-(IBAction)graphPressed:(id)qSender {
    TRACE_START();
    if (qSender == self.legendButton)
    {
        if (self.graph.showLegend)
        {
            self.graph.showLegend = NO;
        }
        else
        {
            self.graph.showLegend = YES;
        }
        [self.graph setNeedsDisplay];
    }
    TRACE_END();
}


@end
