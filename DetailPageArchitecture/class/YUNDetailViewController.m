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
#import "UIView+QNUtil.h"

/**
 * 处理内容底层页的架构设计
 * 1、协同滚动
 * 2、
 */
@interface YUNDetailViewController () <WKUIDelegate, WKNavigationDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

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
    NSLog(@"viewDidLoad %f", self.tableview.contentSize.height);
    
    self.newsList = [NSMutableArray array];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"全球科技媒体头条|谷歌抨击亚马逊贸然商业化面部识别技术" imgUrl:@"WechatIMG19.jpeg"]];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"较真|从不省电的角度，建议你拔掉不经常使用电器的电源" imgUrl:@"WechatIMG18.jpeg"]];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"2018福布斯全球科技女性 TOP 50 榜单 ：李飞飞 柳青" imgUrl:@"WechatIMG17.jpeg"]];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"基辛格弟子、79岁的经济学家预言：免费商业模式即将死亡" imgUrl:@"WechatIMG16.jpeg"]];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"对话被打的滴滴投资人：被司机暴打后，我要这种公司干嘛" imgUrl:@"WechatIMG15.jpeg"]];
    [self.newsList addObject:[[YUNNewsItem alloc] initWithTitle:@"腾讯宣布已向港交所提交有关腾讯音乐分拆建议，得到港交所确认" imgUrl:@"WechatIMG14.jpeg"]];
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://www.weiyun.com/"];
    
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
        _tableview.backgroundColor = [UIColor greenColor];
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
        _webView.backgroundColor = [UIColor blueColor];
    }
    return _webView;
}

- (UIScrollView *)containerScrollView {
    if (!_containerScrollView) {
        _containerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height  - 64)];
        // contentSize的高度理论上要计算的，我暂时写成足够大的，屏幕的四倍大，足够放下目前的webview 的内容和tableview 的内容
        _containerScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height - 64) * 4);
//        [_containerScrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _containerScrollView.delegate = self;
        _containerScrollView.backgroundColor = [UIColor redColor];
    }
    return _containerScrollView;
}

#pragma mark WKNavigationDelegate
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSURL *url = navigationAction.request.URL;
//    //拦截百度页面
//    if ([url.absoluteString containsString:@"baidu"]) {
//        decisionHandler(WKNavigationActionPolicyCancel);
//    } else {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//}

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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 权哥这里说的对，白屏是因为webview的frame被动了，后来才知道，原来是scrollViewDidScroll 这个函数同时对应了外层的scrollview和内层的tableview,所以offsetscrollview有时候属于scrollview有时候属于tableview ，当然会有bug, 所以这里需要区分下是不是外层scrollview
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    self.containerScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.tableview.contentSize.height + self.webView.scrollView.contentSize.height);
    
//    NSLog(@"tableview%f", self.tableview.contentSize.height);
//    NSLog(@"webView%f", self.webView.scrollView.contentSize.height);
    CGPoint offset = scrollView.contentOffset;

    /*
     * 先考虑简单的情况：目前是上方一个webview,下方一个tableview （而且这个）
     * 其实这个情况还是挺麻烦的，要考虑很多因素的。
     * tableview的content
     */
    
    // 把webview往下移动
    if (offset.y < self.webView.scrollView.contentSize.height - self.webView.frame.size.height) {
        NSLog(@"***********%f", offset.y);
        self.webView.qn_top =  offset.y;
        // 同时修改webView的ContentOffset，达到滚动的目的
        [self.webView.scrollView setContentOffset:CGPointMake(0, offset.y)];
        
        /*
         * 1、同时，要把tableview往下移动，
         * 2、但是一旦上方webView 的内容都显示完了，tableview就不能再移动了，
         * 3、然后等到tableview已经展示完第一页的时候，再次往下移动tableview，同时修改tableview的contentoffset,类似于上方webview的初始过程
         */
        self.tableview.qn_top = self.webView.scrollView.contentSize.height;
    } else if (offset.y > self.webView.scrollView.contentSize.height) {
        self.tableview.qn_top = offset.y;
        [self.tableview setContentOffset:CGPointMake(0, offset.y - self.webView.scrollView.contentSize.height)];
    } else {
        NSLog(@"不动");
    }
    
}

@end
