//
//  YUNRootViewController.m
//  DetailPageArchitecture
//
//  Created by zhiyunyu on 2018/12/21.
//  Copyright © 2018 zhiyunyu. All rights reserved.
//

#import "YUNRootViewController.h"
#import "YUNDetailViewController.h"

@interface YUNRootViewController ()

@end

@implementation YUNRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *enterDetailBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [enterDetailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [enterDetailBtn addTarget:self action:@selector(enterDetail) forControlEvents:UIControlEventTouchUpInside];
    [enterDetailBtn setTitle:@"进入底层页" forState:UIControlStateNormal];
    enterDetailBtn.layer.borderWidth = 2;
    enterDetailBtn.layer.borderColor = [UIColor blueColor].CGColor;
    enterDetailBtn.layer.cornerRadius = 5;
    
    [self.view addSubview:enterDetailBtn];
}

- (void)enterDetail {
    YUNDetailViewController *detailController = [[YUNDetailViewController alloc] init];
    [self.navigationController pushViewController:detailController animated:YES];
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
