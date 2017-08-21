//
//  ViewController.m
//  MultilingualDemo
//
//  Created by JustinYang on 2017/7/23.
//  Copyright © 2017年 JustinYang. All rights reserved.
//

#import "ViewController.h"
#import "ModuleVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [UILabel new];
    label.text = NSLocalizedString(@"Localizable中的文字", @"");
    [label sizeToFit];
    [self.view addSubview:label];
    label.center = self.view.center;
    
}

- (IBAction)nextVC:(id)sender {
    [self.navigationController pushViewController:[[ModuleVC alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
