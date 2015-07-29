//
//  WLLoginViewController.m
//  WorldList
//
//  Created by Artem Podustov on 7/28/15.
//  Copyright (c) 2015 OLEArt. All rights reserved.
//

#import "WLLoginViewController.h"

@interface WLLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation WLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {
    self.emailTextField.text = @"ios.test@xyrality.com";
    self.passwordTextField.text = @"password";
    
    if ([self.delegate respondsToSelector:@selector(loginDidClicked:withLogin:andPassword:)]) {
        [self.delegate loginDidClicked:self withLogin:self.emailTextField.text andPassword:self.passwordTextField.text];
    }
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
