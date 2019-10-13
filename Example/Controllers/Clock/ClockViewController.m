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
    
    NSURL *theURL = [[NSURL alloc] initWithString:@"https://neecapp.neec-fct.com/lista/index.html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:theURL]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
