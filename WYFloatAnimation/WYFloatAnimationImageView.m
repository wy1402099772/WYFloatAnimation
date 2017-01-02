//
//  WYFloatAnimationImageView.m
//  WYFloatAnimation
//
//  Created by wyan assert on 2017/1/2.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "WYFloatAnimationImageView.h"

@interface WYFloatAnimationImageView ()

@property (nonatomic, strong) UIImageView *displayImageView;

@end

@implementation WYFloatAnimationImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self configureView];
    }
    return self;
}

#pragma mark - Public
- (void)changeImage {
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.displayImageView.frame = CGRectMake(self.frame.size.width / 2, self.frame.size.height / 2, 0, self.frame.size.height / 2);
                     }completion:^(BOOL finished) {
                         self.displayImageView.image = [UIImage imageNamed:[self randomImageName]];
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.displayImageView.frame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height / 2);
                                          }];
                     }];
}

#pragma mark - Private
- (void)configureView {
    [self addSubview:self.displayImageView];
}

- (NSString *)randomImageName {
    NSInteger num = arc4random() % 10;
    return [NSString stringWithFormat:@"test%ld.png", num];
}

#pragma mark - Getter
- (UIImageView *)displayImageView {
    if(!_displayImageView) {
        _displayImageView = [[UIImageView alloc] init];
        _displayImageView.frame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height / 2);
        _displayImageView.image = [UIImage imageNamed:[self randomImageName]];
    }
    return _displayImageView;
}

@end
