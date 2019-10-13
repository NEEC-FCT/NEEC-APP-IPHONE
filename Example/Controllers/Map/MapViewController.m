//
//  MapViewController.m
//  Example
//
//  Created by Ezequiel Scaruli on 5/6/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController ()

@end

@implementation MapViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
      NSString * cargo = [[NSUserDefaults standardUserDefaults] objectForKey: @"cargo"];
      NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey: @"token"];
      NSString * email = [[NSUserDefaults standardUserDefaults] objectForKey: @"email"];
    
    if ([cargo containsString:@"Senior"] || [cargo containsString:@"senior"] || [cargo containsString:@"Junior"] || [cargo containsString:@"junior"]  || [cargo containsString:@"membro"]   || [cargo containsString:@"Membro"]    ) {

        [self showAlertViewWithTitle:@"Permissão"
                             message:@"O Histório é apenas para membros da direcção"];
    }
    
    else{
        NSString *url =   [[NSString alloc] initWithFormat:@"https://neecapp.neec-fct.com/historico/?email=%@&token=%@",email ,token];
        printf("%s\n", [url UTF8String]);
        NSURL *theURL = [[NSURL alloc] initWithString: url];
  
        [self.webView loadRequest:[NSURLRequest requestWithURL:theURL]];

    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


#pragma mark - Private methods

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

