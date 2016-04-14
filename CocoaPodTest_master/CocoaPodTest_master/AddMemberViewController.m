//
//  AddMemberViewController.m
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/14.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "AddMemberViewController.h"

#import "HUDTool.h"
@interface AddMemberViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txfName;
@property (weak, nonatomic) IBOutlet UITextField *txfPhone;
@property (weak, nonatomic) IBOutlet UITextField *txfSex;

@end

@implementation AddMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    UIBarButtonItem *itemDone = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneBtnItemAction)];
    self.navigationItem.rightBarButtonItem = itemDone;
    
    if (_objMember) {
        _txfName.text = _objMember.name;
        _txfPhone.text = _objMember.phone;
        _txfSex.text = _objMember.age;
    }
}
-(void)doneBtnItemAction{
    if (_txfName.text.length+_txfPhone.text.length+_txfSex.text.length<=0) {
        [HUDTool showSuccessAlertMessage:@"请将信息填写完整"];
        return;
    }else{
        __block id safeSelf = self;
        if (_objMember) {
            [Member updateMember:_objMember WithName:_txfName.text age:_txfSex.text phone:_txfPhone.text success:^{
                
                [[safeSelf navigationController] popViewControllerAnimated:YES];
                
            } failure:^(NSError * _Nonnull error) {
                [HUDTool showFailureAlertmessage:@"信息更新失败"];
            }];
        }else{
            [Member addNewMemberToFamily:_objFamily WithName:_txfName.text age:_txfSex.text phone:_txfPhone.text success:^{
                
                [[safeSelf navigationController] popViewControllerAnimated:YES];
                
            } failure:^(NSError * _Nonnull error) {
                [HUDTool showFailureAlertmessage:@"成员添加失败"];
            }];
        }
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
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
