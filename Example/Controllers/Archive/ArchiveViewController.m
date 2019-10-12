//
//  ArchiveViewController.m
//  Example
//
//  Created by Ezequiel Scaruli on 5/6/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import "ArchiveViewController.h"


@implementation ArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *theURL = [[NSURL alloc] initWithString:@"https://calendar.google.com/calendar/embed?src=campus.fct.unl.pt_rg3q398k6jnmnv1uthpq974r08%40group.calendar.google.com&ctz=Europe%2FLisbon"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:theURL]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

@end
