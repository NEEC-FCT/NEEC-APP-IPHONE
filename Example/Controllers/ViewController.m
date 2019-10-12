//
//  ViewController.m
//  Example
//
//  Created by Ezequiel Scaruli on 5/4/15.
//  Copyright (c) 2015 Ezequiel Scaruli. All rights reserved.
//

#import <ESTabBarController/ESTabBarController.h>
#import <UIColor-HexString/UIColor+HexString.h>

#import "ViewController.h"
#import "ArchiveViewController.h"
#import "ClockViewController.h"
#import "MapViewController.h"
#import "GlobeViewController.h"
@import SystemConfiguration.CaptiveNetwork;
#include <SystemConfiguration/SystemConfiguration.h>


@implementation ViewController


#pragma mark - UIViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    // Instance creation.
    ESTabBarController *tabBarController = [[ESTabBarController alloc] initWithTabIconNames:@[@"archive",
                                                                                              @"map",
                                                                                              @"target",
                                                                                              @"clock",
                                                                                              @"globe"]];
    
    // Add child view controller.
    
    [self addChildViewController:tabBarController];
    
    [self.view addSubview:tabBarController.view];
    tabBarController.view.frame = self.view.bounds;
    
    [tabBarController didMoveToParentViewController:self];
    
    // View controllers.
    
    [tabBarController setViewController:[[ArchiveViewController alloc] init]
                                atIndex:0];
    
   
    
    [tabBarController setViewController:[[MapViewController alloc] init]
                                atIndex:1];
    
    [tabBarController setViewController:[[GlobeViewController alloc] init]
                                atIndex:4];
    
    // Colors.
    
    tabBarController.selectedColor = [UIColor colorWithHexString:@"#8BC12B"];
    tabBarController.buttonsBackgroundColor = [UIColor colorWithHexString:@"#F6EBE0"];
    
    // Highlighted buttons.
    
    [tabBarController highlightButtonAtIndex:2];
    
    // Actions.
    
    __weak typeof (self) weakSelf = self;
    
    [tabBarController setAction:^{
        NSString * cargo = [[NSUserDefaults standardUserDefaults] objectForKey: @"cargo"];
        
        NSString *wifiName = nil;
        NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
        for (NSString *ifnam in ifs) {
            NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
            if (info[@"SSID"]) {
                wifiName = info[@"SSID"];
            }
        }
        

        if ([cargo containsString:@"Junior"] || [cargo containsString:@"junior"]) {
            [weakSelf showAlertViewWithTitle:@"Erro"
                                     message:@"Os Juniores não podem abrir a porta"];
        }
        
        
        else  if ([cargo containsString:@"Senior"] || [cargo containsString:@"senior"]) {
          
            if ([wifiName containsString:@"NEEC"]) {
               
                
                NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey: @"token"];
                NSString * email = [[NSUserDefaults standardUserDefaults] objectForKey: @"email"];
                NSString * uuid = [[NSUserDefaults standardUserDefaults] objectForKey: @"IMEI"];;
                //printf("%s", [uuid UTF8String]);
                
                
                NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://neecapp.neec-fct.com/portav2.php?"]];
                [request setHTTPMethod:@"POST"];
                
                NSString *post =[[NSString alloc] initWithFormat:@"token=%@&cargo=%@&IMEI=%@&email=%@",token,cargo,uuid,email];
                printf("%s", [post UTF8String]);
                [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
                
                NSURLResponse *response;
                NSError *err;
                NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
                NSString *myString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                
                printf("%s", [myString UTF8String]);
                if ([myString rangeOfString:@"true"].location == NSNotFound) {
                    [weakSelf showAlertViewWithTitle:@"Erro"
                                             message:@"Ocorreu um erro por favor faça logout"];
                } else {
                    [weakSelf showAlertViewWithTitle:@"Sucesso"
                                             message:@"A porta vai abrir dentro de momentos"];
                }
                
            } else {
                printf("%s", [wifiName UTF8String]);
                [weakSelf showAlertViewWithTitle:@"Erro"
                                         message:@"Os seniores tem de estar ligados ao router do NEEC"];
            }
            
        }
        else {
  
            NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey: @"token"];
            NSString * email = [[NSUserDefaults standardUserDefaults] objectForKey: @"email"];
            NSString * uuid = [[NSUserDefaults standardUserDefaults] objectForKey: @"IMEI"];;
            //printf("%s", [uuid UTF8String]);
            
            
            NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://neecapp.neec-fct.com/portav2.php?"]];
            [request setHTTPMethod:@"POST"];
            
            NSString *post =[[NSString alloc] initWithFormat:@"token=%@&cargo=%@&IMEI=%@&email=%@",token,cargo,uuid,email];
            printf("%s", [post UTF8String]);
            [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSURLResponse *response;
            NSError *err;
            NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
            NSString *myString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            
            printf("%s", [myString UTF8String]);
            if ([myString rangeOfString:@"true"].location == NSNotFound) {
                [weakSelf showAlertViewWithTitle:@"Erro"
                                         message:@"Ocorreu um erro por favor faça logout"];
            } else {
                [weakSelf showAlertViewWithTitle:@"Sucesso"
                                         message:@"A porta vai abrir dentro de momentos"];
            }
        }
        

        
     
        
        
    
    } atIndex:2];
    
    [tabBarController setAction:^{
        [weakSelf showAlertViewWithTitle:@"Brevemente"
                                 message:@"Ainda a ser desenvolvida"];
    } atIndex:3];
    
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
