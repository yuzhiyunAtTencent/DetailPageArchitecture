//
//  YUNDetailViewController.m
//  DetailPageArchitecture
//
//  Created by zhiyunyu on 2018/12/21.
//  Copyright © 2018 zhiyunyu. All rights reserved.
//

#import "YUNDetailViewController.h"
#import <WebKit/WebKit.h>
#import "YUNNewsCell.h"
#import "YUNNewsItem.h"

@interface YUNDetailViewController () <WKUIDelegate, WKNavigationDelegate>

@property(nonatomic, strong) UIScrollView *containerScrollView;
@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) UITableView *tableview;

@property(nonatomic, strong) NSMutableArray<YUNNewsItem *> *newsList;

@end

@implementation YUNDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.containerScrollView];
    [self.containerScrollView addSubview:self.webView];
    [self.containerScrollView addSubview:self.tableview];
    
    self.newsList = [NSMutableArray array];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"全球科技媒体头条|谷歌抨击亚马逊贸然商业化面部识别技术" imgUrl:@"WechatIMG19.jpeg"]];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"较真|从不省电的角度，建议你拔掉不经常使用电器的电源" imgUrl:@"WechatIMG18.jpeg"]];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"2018福布斯全球科技女性 TOP 50 榜单 ：李飞飞 柳青" imgUrl:@"WechatIMG17.jpeg"]];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"基辛格弟子、79岁的经济学家预言：免费商业模式即将死亡" imgUrl:@"WechatIMG16.jpeg"]];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"对话被打的滴滴投资人：被司机暴打后，我要这种公司干嘛" imgUrl:@"WechatIMG15.jpeg"]];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"腾讯宣布已向港交所提交有关腾讯音乐分拆建议，得到港交所确认" imgUrl:@"WechatIMG14.jpeg"]];
    
//    NSURL *url = [[NSURL alloc] initWithString:@"https://www.jianshu.com/nb/21258903"];
    NSURL *url = [[NSURL alloc] initWithString:@"https://www.jianshu.com/nb/19826337"]; // 内容很长的链接
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.webView loadRequest:request];
}

-(void)dealloc {
    self.tableview.delegate = nil;
    self.tableview.dataSource = nil;
}

#pragma mark Override

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64) style:UITableViewStylePlain];
        _tableview.scrollEnabled = NO;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[YUNNewsCell class] forCellReuseIdentifier:NSStringFromClass([YUNNewsCell class])];
    }
    
    return _tableview;
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration =[[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64) configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

- (UIScrollView *)containerScrollView {
    if (!_containerScrollView) {
        _containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _containerScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height - 64) * 2);
    }
    return _containerScrollView;
}

#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    //拦截百度页面
    if ([url.absoluteString containsString:@"baidu"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUNNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YUNNewsCell class]) forIndexPath:indexPath];
    [cell layoutWithData:[self.newsList objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [YUNNewsCell height];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
}

@end
