//
//  WKSettingViewController.m
//  CosChat
//
//  Created by zzx🐹 on 15/4/30.
//  Copyright (c) 2015年 WeiKe. All rights reserved.
//

#import "WKSettingViewController.h"
#import "WKSettingItem.h"
#import "WKMainViewController.h"
@interface WKSettingViewController ()

@end

@implementation WKSettingViewController
-(id)init
{
    return  [super initWithStyle:UITableViewStyleGrouped];
}
-(id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

-(NSArray*)data
{
    if (_data==nil) {
        _data=[NSMutableArray array];
        
        
        WKSettingItem *item00=[WKSettingItem itemWithTitle:@"第一行" vcClass:[WKMainViewController class] ];
        WKSettingItem *item01=[WKSettingItem itemWithTitle:@"第二行" vcClass:[WKMainViewController class] ];
        NSArray *array0=@[item00,item01];
        
        WKSettingItem *item10=[WKSettingItem itemWithTitle:@"第一行" vcClass:[WKMainViewController class] ];
        WKSettingItem *item11=[WKSettingItem itemWithTitle:@"第二行" vcClass:[WKMainViewController class] ];
        NSArray *array1=@[item10,item11];
        
        [_data addObject:array0];
        [_data addObject:array1];
        
    }
    return _data;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.标题
    self.title = @"设置";
    

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *subdata=self.data[section];
    return subdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    static NSString *CellIdentifer=@"setting";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifer];
    }
    WKSettingItem *item=self.data[indexPath.section][indexPath.row];
    cell.textLabel.text=item.title;
    // 3.返回cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取消选中这行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    WKSettingItem *item=self.data[indexPath.section][indexPath.row];
    UIViewController *vc=[[item.vcClass alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end