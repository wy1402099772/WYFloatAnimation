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

#pragma mark - Private
- (void)configureView {
    [self addSubview:self.displayImageView];
}

#pragma mark - Getter
- (UIImageView *)displayImageView {
    if(!_displayImageView) {
        _displayImageView = [[UIImageView alloc] init];
        _displayImageView.frame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height / 2);
        _displayImageView.image = [UIImage imageNamed:@"text0.png"];
    }
    return _displayImageView;
}

@end
