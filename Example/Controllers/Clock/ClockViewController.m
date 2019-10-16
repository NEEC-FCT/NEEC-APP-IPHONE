//
//  ClockViewController.m
//  Example
//
//  Created by Ezequiel Scaruli on 5/6/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import "ClockViewController.h"


@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/yyyy"];
    NSDate* enteredDate = [df dateFromString:@"10/18/2019"];
    NSDate * today = [NSDate date];
    NSComparisonResult result = [today compare:enteredDate];
     NSURL *theURL ;
    switch (result)
    {
        case NSOrderedAscending:
            NSLog(@"Future Date");
            theURL = [[NSURL alloc] initWithString:@"https://expofct.neec-fct.com/schedule/"];
                        break;
        case NSOrderedDescending:
            NSLog(@"Earlier Date");
            theURL = [[NSURL alloc] initWithString:@"https://neecapp.neec-fct.com/lista/index.html"];
                        break;
        case NSOrderedSame:
            NSLog(@"Today/Null Date Passed"); //Not sure why This is case when null/wrong date is passed
            theURL = [[NSURL alloc] initWithString:@"https://neecapp.neec-fct.com/lista/index.html"];
                        break;
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:theURL]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
