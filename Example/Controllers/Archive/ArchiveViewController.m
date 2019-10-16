//
//  ArchiveViewController.m
//  Example
//
//  Created by Ezequiel Scaruli on 5/6/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import "ArchiveViewController.h"
#import <CoreLocation/CoreLocation.h>

@implementation ArchiveViewController

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
            theURL = [[NSURL alloc] initWithString:@"https://expofct.neec-fct.com/Departamentos/iphone.html"];
                        break;
        case NSOrderedDescending:
            NSLog(@"Earlier Date");
            theURL = [[NSURL alloc] initWithString:@"https://calendar.google.com/calendar/embed?src=campus.fct.unl.pt_rg3q398k6jnmnv1uthpq974r08%40group.calendar.google.com&ctz=Europe%2FLisbon"];
                        break;
        case NSOrderedSame:
            NSLog(@"Today/Null Date Passed"); //Not sure why This is case when null/wrong date is passed
            theURL = [[NSURL alloc] initWithString:@"https://calendar.google.com/calendar/embed?src=campus.fct.unl.pt_rg3q398k6jnmnv1uthpq974r08%40group.calendar.google.com&ctz=Europe%2FLisbon"];
                        break;
    }
    

    [self.webView loadRequest:[NSURLRequest requestWithURL:theURL]];
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

@end
