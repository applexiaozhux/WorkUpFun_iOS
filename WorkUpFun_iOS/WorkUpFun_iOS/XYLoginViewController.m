
//
//  XYLoginViewController.m
//  YiTuoCompany
//
//  Created by xiyang on 2017/3/8.
//  Copyright © 2017年 xiyang. All rights reserved.
//

#import "XYLoginViewController.h"

//#import "ColorUtils.h"
//#import "UIImage+XYColorString.h"
//#import "YiTuoStaticLet.h"
//#import "XYTabBarController.h"
@interface XYLoginViewController ()<UITextFieldDelegate>

@end

@implementation XYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"登录";
    
    [self initSubViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{
//                                                                      NSForegroundColorAttributeName : [UIColor colorWithString:darkColorStr]
//                                                                      }];
//    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage navigationBarImageWithColorString:@"#fafafa"] forBarMetrics:UIBarMetricsDefault];
//}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



-(void)initSubViews{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

//-(void)backClick{
//    [self.view endEditing:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    if (self.isLogOutShow) {
//        
//        XYTabBarController *tabBarVc = (XYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//        [tabBarVc showCurrentViewController:StoreChildViewController];
//    }
//}

#pragma mark - IBActions

- (IBAction)loginBtnAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)securetyAction:(UIButton *)sender {
    
    self.tf_password.secureTextEntry = sender.isSelected;
    
    sender.selected = !sender.isSelected;
}






//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    XYRegistViewController *registVC =(XYRegistViewController *) segue.destinationViewController;
//    registVC.isRegist = [sender boolValue];
//    
//    
//}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self setLoginEnableWithPhone:self.tf_phone.text password:self.tf_password.text];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *textStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField.tag==100) {
        
        if (textStr.length>11) {
            
            return NO;
        }
        [self setLoginEnableWithPhone:textStr password:self.tf_password.text];
        
    }else{
        if (textStr.length>16) {
            
            return NO;
        }
        
        [self setLoginEnableWithPhone:self.tf_phone.text password:textStr];
        
    }
    
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    [self changeLoginStatues:NO];
    return YES;
}


-(void)setLoginEnableWithPhone:(NSString *)phone password:(NSString *)password{
    
    BOOL enable = NO;
    if (phone.length==11&&password.length>=6&&password.length<=16) {
        enable = YES;
    }
    
    [self changeLoginStatues:enable];
}

-(void)changeLoginStatues:(BOOL)enable{
    
    UIColor *colorStr = enable?[UIColor redColor]:[UIColor lightGrayColor];
    self.loginBtn.backgroundColor = colorStr;
    self.loginBtn.userInteractionEnabled = enable;
    
}


#pragma mark - UIKeyboard
-(void)keyboardWillShow:(NSNotification *)noti{
    
    double time = [[[noti userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:time animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -140);
    }];
}

-(void)keyboardWillHide:(NSNotification *)noti{
    double time = [[[noti userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:time animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
