//
//  ViewController.m
//  WYFloatAnimation
//
//  Created by wyan assert on 2017/1/2.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "ViewController.h"
#import "WYFloatAnimationMnager.h"

@interface ViewController ()

@property (nonatomic, strong) WYFloatAnimationMnager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    button1.backgroundColor = [UIColor redColor];
    [button1 addTarget:self action:@selector(action2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

- (void)action:(UIButton *)sender {
    [self.manager startAnimation];
}

- (void)action2:(UIButton *)sender {
    [self.manager changeImage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (WYFloatAnimationMnager *)manager {
    if(!_manager) {
        _manager = [[WYFloatAnimationMnager alloc] initWithAssoicatedView:self.view];
    }
    return _manager;
}

@end
