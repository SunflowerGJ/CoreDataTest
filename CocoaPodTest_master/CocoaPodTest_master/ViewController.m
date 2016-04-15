//
//  ViewController.m
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/11.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "ViewController.h"

#import "MBProgressHUD.h"
#import "HUDTool.h"

#import "AppDelegate.h"
#import "Family.h"
#import "MembersViewController.h"

@interface ViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSArray *_arrDatasource;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self dataFetchRequest];
    
}
- (IBAction)rightAddBtnAction:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"创建" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"创建", nil];
    [alertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    UITextField *txfName = [alertView textFieldAtIndex:0];
    UITextField *txfAddress =[alertView textFieldAtIndex:1];
    txfAddress.secureTextEntry = NO;
    [txfName setPlaceholder:@"name"];
    txfAddress.placeholder = @"addresss";
    
    [alertView show];
    
}
#pragma mark - alertView 
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
        {
            UITextField *txfName =[alertView textFieldAtIndex:0];
            UITextField *txfAddress = [alertView textFieldAtIndex:1];
            
            [self addNewInfoToSQLite:txfName.text address:txfAddress.text];
        }
            break;
        default:
            break;
    }
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}
#pragma mark - tableview delegate/datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrDatasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strId = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strId];
    }
    
    NSManagedObject *object = _arrDatasource[indexPath.row];
    cell.textLabel.text = [object valueForKey:@"name"];
    cell.detailTextLabel.text = [object valueForKey:@"address"];
    
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Family *family = _arrDatasource[indexPath.row];
        __block id safeSelf = self;
        [Family deleteFamily:family success:^{
            [safeSelf dataFetchRequest];
        } failure:^(NSError * _Nonnull error) {
            [HUDTool showFailureAlertmessage:@"删除失败"];
        }];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSManagedObject *object = _arrDatasource[indexPath.row];
    
    MembersViewController *vcNext =[[MembersViewController alloc] init];
    vcNext.objFamily = (Family *)object;
    [self.navigationController pushViewController:vcNext animated:YES];
}

#pragma mark - control
//insert new object to sqlite
- (void)addNewInfoToSQLite:(NSString *)name address:(NSString *)address{
    
    __block id safeSelf = self;
    [Family addNewFamilyWithName:name address:address success:^{
        [safeSelf dataFetchRequest];
    } failure:^(NSError *error){
        [NSException raise:@"访问数据库错误" format:@"%@",error.description];
    }];
}
//fetch all objects list from sqlite
- (void)dataFetchRequest
{
    _arrDatasource = [Family fetchFamilyLists];
    
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
