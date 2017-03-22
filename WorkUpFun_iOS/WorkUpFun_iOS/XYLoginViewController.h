//
//  XYLoginViewController.h
//  YiTuoCompany
//
//  Created by xiyang on 2017/3/8.
//  Copyright © 2017年 xiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;
@property (nonatomic, assign) BOOL isLogOutShow;

- (IBAction)loginBtnAction:(UIButton *)sender;

- (IBAction)securetyAction:(UIButton *)sender;

@end
