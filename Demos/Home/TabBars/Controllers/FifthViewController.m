//
//  FifthViewController.m
//  Demos
//
//  Created by schiller on 15/7/20.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "FifthViewController.h"
#import "Masonry.h"
//#import "AFNetworking.h"

@interface FifthViewController ()<UITextFieldDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) UITextField   *tf;
@property (nonatomic, strong) NSMutableData *data;

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    //[self setOneViewSize];
    //[self setTwoViewSize];
    //[self setTwoViewSpiltSuperView];
   // [self setTextFieldView];
    
    self.data = [NSMutableData data];
    //[self startGetConnection];
    //[self testNetWorking];
    // [self postNetWorking];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
   
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [_tf mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardHeight);
    }];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [_tf mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50);
    }];
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark -
#pragma mark  AFNetworking
//- (void)testNetWorking
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSDictionary *param = @{@"name": @"gaolong"};
//  //  NSError *error = nil;
//   
//    [manager POST:@"http://172.30.38.192/test.php"
//      parameters:param
//         success:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//       NSLog(@"JSON: %@", responseObject);
//        id  jsonString = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                         options:NSJSONReadingAllowFragments
//                                                           error:nil];
//        if (jsonString != nil )
//        {
//            NSLog(@"反序列化成功, %@", jsonString);
//            
//            if ([jsonString isKindOfClass:[NSMutableDictionary class]]) {
//                NSDictionary *dict = (NSDictionary *)jsonString;
//                NSLog(@"dict = %@", dict);
//                NSString *key = dict[@"result"];
//                NSLog(@"the result is %@", key);
//                
//            }else if([jsonString isKindOfClass:[NSMutableArray class]])
//            {
//                NSArray *arr = (NSArray *)jsonString;
//                NSLog(@"arr = %@", arr);
//            }else
//            {
//                NSLog(@"fuck is not dic nor arr");
//                
//            }
//            
//        }else
//        {
//            NSLog(@"shit");
//        }
//        
//    }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//       NSLog(@"Error: %@", error);
//    }];
//}

#pragma mark - 
#pragma mark - shishi
//-(void)postNetWorking
//{
//    NSURL *url = [NSURL URLWithString:@"http://172.30.38.192/shit.php"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSString *postString = @"firstName=gao&lastName=long";
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
//    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (error) {
//            NSLog(@"发生错误啦哥哥");
//        }else
//        {
//            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"dataString -==== %@", dataString);
//        }
//    }];
//    
//    [task resume];
//}
//
- (void)sendPictureToServer
{
    NSURL *url = [NSURL URLWithString:@"http://172.30.38.192/shit.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSString *boundary    = @"----MultipartPostBoundaryTestTestTest";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body    = [NSMutableData data];
    NSMutableData *tempData = [NSMutableData data];
    NSString *fileName = @"testImg.png";
    NSString *parameterName = @"imgFile";
    
    
    
}

    
- (void)callBack:(NSString *)resultString
{
    
}

#pragma mark -
#pragma mark ios networking
- (void)startGetConnection
{
   // static NSString *const baiduUrl = @"http://www.baidu.com/s?wd=nihao&rsv_spt=1&issp=1&rsv_bp=0&ie=utf-8&tn=baiduhome_pg&rsv_sug3=3&rsv_sug=0&rsv_sug1=3&rsv_sug4=36";
    static NSString *const localUrl = @"http://172.30.38.192/test.php";
    NSURL *url = [NSURL URLWithString:localUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];

    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"收到回应");
    if (!self.data) {
        self.data = [NSMutableData data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *output = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", output);
    
    self.data = nil;
    
}


#pragma mark -
#pragma mark show views
- (void)setOneViewSize
{
    __weak typeof(self) weakSelf = self;
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myView];
    
    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 150));
        make.center.equalTo(weakSelf.view);
    }];
 
}

- (UIView *)setCustomView:(UIColor *)color
{
    UIView *blackView = [UIView new];
    blackView.backgroundColor = color;
    [self.view addSubview:blackView];
    
    return blackView;

}
- (void)setTwoViewSize
{

    UIView *blackView = [self setCustomView:[UIColor blackColor]];
    
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.and.top.mas_equalTo(20);
    }];
    
    UIView *grayView   = [self setCustomView:[UIColor grayColor]];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.and.top.equalTo(blackView);
        make.right.mas_equalTo(-20);
    }];
    
}

- (void)setTwoViewSpiltSuperView
{
     __weak typeof(self) weakSelf = self;
    UIView *blackView = [self setCustomView:[UIColor blackColor]];
    UIView *grayView  = [self setCustomView:[UIColor grayColor]];
    
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    
    }];
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.right.mas_equalTo(-20);
        make.height.equalTo(blackView);
        make.top.equalTo(blackView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view.mas_centerX).offset(0);

    }];
}

#pragma mark -
#pragma mark test textField

- (void)setTextFieldView
{
    __weak typeof(self) weakSelf = self;
    _tf = [UITextField new];
    _tf.backgroundColor = [UIColor colorWithRed:0.356 green:0.650 blue:0.126 alpha:0.850];
    _tf.delegate = self;
    [self.view addSubview:_tf];
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-50);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(weakSelf.view);
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _tf) {
        [_tf resignFirstResponder];
    }
    return  YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
