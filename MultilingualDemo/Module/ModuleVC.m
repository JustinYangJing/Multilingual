//
//  ModuleVC.m
//  Multilingual
//
//  Created by JustinYang on 2017/7/23.
//  Copyright © 2017年 JustinYang. All rights reserved.
//

#import "ModuleVC.h"
#import <Multilingual/LanguageManager.h>
#import "AppDelegate.h"
@interface ModuleVC ()
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;

@end

@implementation ModuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *code = [LanguageManager currentLanguageCode];
    if ([code isEqualToString:@"en"]) {
        self.languageLabel.text = NSLocalizedStringFromTable(@"英文", @"ModuleTab", @"");
    }else if( [code isEqualToString:@"zh-Hans"] ){
        self.languageLabel.text = NSLocalizedStringFromTable(@"中文", @"ModuleTab", @"");
    }
    
    UILabel *label = [UILabel new];
    label.text = NSLocalizedStringFromTable(@"国际化",@"ModuleTab",@"");
    [label sizeToFit];
    [self.view addSubview:label];
    label.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 50);
}
- (IBAction)setChiese:(id)sender {
    [self setLanguageWithCode:@"zh-Hans"];
}
- (IBAction)setEnglish:(id)sender {
    [self setLanguageWithCode:@"en"];
}
-(void)setLanguageWithCode:(NSString *)code{
    [LanguageManager saveLanguageByCode:code];
    [self reloadRootViewController];
}
- (void)reloadRootViewController
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    delegate.window.rootViewController = [storyboard instantiateInitialViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
