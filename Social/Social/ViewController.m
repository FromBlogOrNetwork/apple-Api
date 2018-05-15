//
//  ViewController.m
//  Social
//
//  Created by Kenshin Cui on 14/04/05.
//  Copyright (c) 2015年 cmjstudio. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - 控制器视图事件
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UI事件
- (IBAction)shareClick:(UIBarButtonItem *)sender {
    [self shareToSina];
}


#pragma mark - 私有方法
-(void)shareToSina{
    //检查新浪微博服务是否可用
    if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]){
        NSLog(@"新浪微博服务不可用.");
        return;
    }
    //初始化内容编写控制器，注意这里指定分享类型为新浪微博
    SLComposeViewController *composeController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    //设置默认信息
    [composeController setInitialText:@"Kenshin Cui's Blog..."];
    //添加图片
    [composeController addImage:[UIImage imageNamed:@"stevenChow"]];
    //添加连接
    [composeController addURL:[NSURL URLWithString:@"http://www.cnblogs.com/kenshincui"]];
    //设置发送完成后的回调事件
    __block SLComposeViewController *composeControllerForBlock=composeController;
    composeController.completionHandler=^(SLComposeViewControllerResult result){
        if (result==SLComposeViewControllerResultDone) {
            NSLog(@"开始发送...");
        }
        [composeControllerForBlock dismissViewControllerAnimated:YES completion:nil];
    };
    //显示编辑视图
    [self presentViewController:composeController animated:YES completion:nil];
}

@end
