//
//  MembersViewController.m
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/13.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "MembersViewController.h"

#import "Member.h"
#import "HUDTool.h"
#import "AddMemberViewController.h"

@interface MembersViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_arrDataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = _objFamily.name;
    
    
    _arrDataSource = _objFamily.members.allObjects;
    
    UIBarButtonItem *itemRight =[[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemAction)];
    self.navigationItem.rightBarButtonItem = itemRight;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self refreshTableData];
}
-(void)barButtonItemAction{
    
    AddMemberViewController *vcNew = [[AddMemberViewController alloc] init];
    vcNew.objFamily = _objFamily;
    [self.navigationController pushViewController:vcNew animated:YES];
}
-(void)refreshTableData{
    _arrDataSource = _objFamily.members.allObjects;
    [_tableView reloadData];
}
#pragma mark - tableview delegate/datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrDataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strId = @"memberCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strId];
    }
    
    Member *member = _arrDataSource[indexPath.row];
    cell.textLabel.text = member.name;
    cell.detailTextLabel.text = member.phone;
    
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Member *member = _arrDataSource[indexPath.row];
        __block id safeSelf = self;
        [Member deleteMember:member FromFamily:_objFamily success:^{
            [safeSelf refreshTableData];
        } failure:^(NSError * _Nonnull error) {
            [HUDTool showFailureAlertmessage:@"删除信息失败"];
        }];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     Member *member = _arrDataSource[indexPath.row];
    
    AddMemberViewController *vcNew = [[AddMemberViewController alloc] init];
    vcNew.objFamily = _objFamily;
    vcNew.objMember = member;
    [self.navigationController pushViewController:vcNew animated:YES];
}

#pragma mark - members

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
