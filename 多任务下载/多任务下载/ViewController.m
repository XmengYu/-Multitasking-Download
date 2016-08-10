//
//  ViewController.m
//  多任务下载
//
//  Created by xmy on 16/8/10.
//  Copyright © 2016年 xmy. All rights reserved.
//

#import "ViewController.h"
#import "YYModel.h"
#import "CZBook.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray *booklist;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    
}
- (void)loadData{
    
    //url
    NSURL *url = [NSURL URLWithString:@"http://42.62.15.100/yyting/snsresource/getAblumnAudios.action?ablumnId=2719&imei=RkVGNzBFMkYtNjc2QS00NkQwLUEwOTYtNUU5Q0QyOUVGMzdE&nwt=1&q=50506&sc=1438f6d61a2907bfa8b3ea0973474ac1&sortType=1&token=j5xm1WPkdnI-uxtFXlv6CsWiNfwjfQYPQb63ToXOFc8%2A"];
    
    //发送请求
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != nil || data.length == 0)
        {
            NSLog(@"请求失败%@",error);
            return;
        }
        //反序列化
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        //字典转模型
        NSArray *array = [NSArray yy_modelArrayWithClass:[CZBook class] json:dict[@"list"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.booklist = array;
            //刷新数据
            [self.tableView reloadData];
        });
    }] resume];
}
#pragma mark <UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.booklist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    CZBook *book = self.booklist[indexPath.row];
    
    cell.textLabel.text = book.name;
    
    return cell;
    
}








@end
