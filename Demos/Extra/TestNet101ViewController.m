//
//  TestNet101ViewController.m
//  Demos
//
//  Created by gaolong on 15/9/4.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TestNet101ViewController.h"

@interface TestNet101ViewController ()<UIWebViewDelegate,NSURLConnectionDataDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSDictionary *paramDict;
@property (nonatomic, strong) NSDictionary *passParam;

@property (nonatomic, strong) NSMutableData *requestData;

@end

@implementation TestNet101ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //[self loadWebView];
    
    
    //异步请求
    //[self asynRequest];
    
    //同步请求
    //[self synRequest];
    
   // [self GetMwthodRequest];
    self.passParam = @{@"name": @"gaolong", @"nation": @"China", @"University": @"South Airline"};
    
   // [self startGETConnection];
    
    //[self startPOSTConnection];
    
    [self loadJsonData];
    
}

- (void)loadWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.y = self.topBarView.bottom;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

#pragma mark - NSURLSession new api
- (void)loadJsonData
{
    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.31.170/netWork.php?name=%@", @"gaolong"];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        if (!error) {
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"DataStr = %@", dataStr);
        }
        else {
            NSLog(@"error is = %@", error.localizedDescription);
        }
    }];
    [dataTask resume];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSError *saveError = nil;
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *fileName = nil;
            NSString *savePath = [cachePath stringByAppendingPathComponent:fileName];
            NSLog(@"Path = %@", savePath);
            NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
            [[NSFileManager defaultManager] copyItemAtPath:location toPath:savePath error:&saveError];
            if (!saveError) {
                NSLog(@"save success");
            }
            else {
                NSLog(@"Error = %@", saveError.localizedDescription);
            }
        }
        else {
            NSLog(@"Error is %@", error.localizedDescription);
        }
    }];
}

#pragma mark - Request
- (void)startGETConnection
{
    static NSString *const BaiduURL = @"http://www.baidu.com/s?wd=nihao&rsv_spt=1&issp=1&rsv_bp=0&ie=utf-8&tn=baiduhome_pg&rsv_sug3=3&rsv_sug=0&rsv_sug1=3&rsv_sug4=36";
    NSURL *url = [NSURL URLWithString:BaiduURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    
}

- (void)startPOSTConnection
{
    static NSString *const BaiduSearch = @"http://weibo.com/rannie";
    static NSString *const SearchBody  = @"wvr=5&";
    
    NSURL *url = [NSURL URLWithString:BaiduSearch];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3.0f];
    request.HTTPMethod = @"POST";
    request.HTTPBody   = [SearchBody dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    NSLog(@"执行POST");
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.requestData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"收到回应");
    if (!self.requestData) {
        self.requestData = [NSMutableData data];
    }
}

//连接结束时调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *outPut = [[NSString alloc] initWithData:self.requestData encoding:NSUTF8StringEncoding];
    NSLog(@"Output Data = %@", outPut);
    
    self.requestData = nil;
}

#pragma mark - GET 、POST Request
- (void)mutableURLRequest
{
    NSString *urlAsString = @"http://www.apple.com";
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest new];
    [urlRequest setURL:url];
    [urlRequest setTimeoutInterval:30.0f];
}

//Get 请求

- (void)serializeDict
{
    NSArray *person = @[@"son", @"duaghter", @"mama"];
    [self.passParam setValue:person forKey:@"family"];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.passParam options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData.length > 0 && !error) {
        NSLog(@"Succefully serialized the dictionary into data.");
        NSString *jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON String = %@", jsonString);
    }
    else if (jsonData.length == 0 && !error) {
        NSLog(@"No data was returned after serialization.");
    }
    else if (error) {
        NSLog(@"An erro happened = %@", error);
    }
    
}

- (void)GetMwthodRequest
{
    NSString *urlAsString = @"http://192.168.31.170/netWork.php";
    urlAsString = [urlAsString stringByAppendingString:@"?name=gaolong"];
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.timeoutInterval = 30;
    [urlRequest setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && !connectionError) {
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"HTML = %@", html);
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (jsonObject) {
                NSLog(@"Successfully deserialized.");
                self.paramDict = (NSDictionary *)jsonObject;
                NSLog(@"Dictionary = %@", self.paramDict);
            }
        }
        else if (data.length == 0 && !connectionError) {
            NSLog(@"Nothing was downloaded.");
        }
        else if (connectionError) {
            NSLog(@"Error happened = %@", connectionError);
        }
    }];
    
}

- (void)asynRequest
{
    __block typeof (&*self) weakSelf = self;
    
    NSString *urlAsString = @"http://www.sdfssapple.com";
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ([data length] > 0 && !connectionError) {
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"HTML = %@", html);
            [weakSelf.webView loadHTMLString:html baseURL:url];
        }
        else if ([data length] == 0 && !connectionError) {
            NSLog(@"Nothing was download!");
        }
        else if (connectionError) {
            NSLog(@"Error = %@", connectionError);
        }
    
    }];
    
}

- (void)synRequest
{
    NSString *urlAsString = @"http://www.yahoo.com";
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data  = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    if (data.length > 0 && !error) {
        NSLog(@"%lu bytes of data was returned.", (unsigned long)data.length);
        [self.webView loadHTMLString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] baseURL:url];
    }
    else if (data.length == 0 && !error) {
        NSLog(@"No data was downloaded.");
    }
    else if (error) {
        NSLog(@"Error happened = %@", error);
    }
}

#pragma mark - WebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return  YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
