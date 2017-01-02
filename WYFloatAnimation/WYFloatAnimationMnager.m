//
//  WYFloatAnimationMnager.m
//  WYFloatAnimation
//
//  Created by wyan assert on 2017/1/2.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "WYFloatAnimationMnager.h"
#import "WYFloatAnimationImageView.h"

static NSInteger const InitPosiValue = -1;
static CGFloat const InitSpinAngle = 0.5;
static CGFloat const PerSpinAngle = 0.0005;
static NSUInteger const InitSpinCount = 5;
static CGFloat const InitLineWidth = 4.f;
static CGFloat const InitLineExtraHeight = 10.f;
static CGFloat const FakeAcclerateSpeedParam = 7;

@interface WYFloatAnimationMnager ()

@property (nonatomic, strong) UIView *associatedView;
@property (nonatomic, strong) WYFloatAnimationImageView *hungImageView;
@property (nonatomic, strong) UIImageView *lineImage;

@property (nonatomic, assign) CGFloat spinAngle;
@property (nonatomic, assign) CGFloat scaleRate;

@property (nonatomic, assign) NSTimer *timer;
@property (nonatomic, assign) NSUInteger spinCount;
@property (nonatomic, assign) CGAffineTransform initImageTransform;
@property (nonatomic, assign) CGAffineTransform initLineTransform;
@property (nonatomic, assign) BOOL isLeftSpin;

@end

@implementation WYFloatAnimationMnager

- (instancetype)initWithAssoicatedView:(UIView *)associatedView {
    if(self = [super init]) {
        _associatedView = associatedView;
        _hungPoint = CGPointMake(InitPosiValue, InitPosiValue);
        _hungSize = CGSizeMake(InitPosiValue, InitPosiValue);
        
        _spinAngle = 0;
        _scaleRate = 1;
        
        [self configureLineImage];
        [self configureHungImage];
    }
    return self;
}

#pragma mark - Public
- (void)startAnimation {
    if([self.timer isValid]) {
        return ;
    }
    self.spinAngle = InitSpinAngle;
    self.spinCount = InitSpinCount - 1;
    [UIView animateWithDuration:0.5 animations:^{
        [self adjustHungImagePosi];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                      target:self
                                                    selector:@selector(adjustHungImagePosi)
                                                    userInfo:nil
                                                     repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }];
    
}

- (void)stopAnimation {
    [self.timer invalidate];
    self.timer = nil;
    
    self.hungImageView.transform = self.initImageTransform;
    self.hungImageView.frame = [self calHungImageInitFrame];
    
    self.associatedView = nil;
}

- (void)changeImage {
    [self.hungImageView changeImage];
}

#pragma mark - Private
- (void)configureHungImage {
    if(!self.associatedView) {
        return ;
    }
    [self.associatedView addSubview:self.hungImageView];
    self.initImageTransform = self.associatedView.transform;
}

- (void)configureLineImage {
    if(!self.associatedView) {
        return ;
    }
    [self.associatedView addSubview:self.lineImage];
    self.initLineTransform = self.lineImage.transform;
}

- (CGRect)calHungImageInitFrame {
    return CGRectMake(self.hungPoint.x - self.hungSize.width / 2, self.hungPoint.y - self.hungSize.height, self.hungSize.width, self.hungSize.height * 2);
}

- (CGRect)calHungLineInitFrame {
    return CGRectMake(self.hungPoint.x - InitLineWidth / 2, - self.hungPoint.y - InitLineExtraHeight, InitLineWidth, (self.hungPoint.y + InitLineExtraHeight) * 2);
}

- (void)adjustHungImagePosi {
    [self.hungImageView setTransform:CGAffineTransformTranslate(self.initImageTransform, - (sin(self.spinAngle) * self.hungPoint.y), - (( 1 - cos(self.spinAngle)) * self.hungPoint.y))];
    [self.hungImageView setTransform:CGAffineTransformRotate(self.hungImageView.transform, self.spinAngle)];
    
    [self.lineImage setTransform:CGAffineTransformRotate(self.initLineTransform, self.spinAngle)];
    
    if(self.spinAngle > InitSpinAngle / (InitSpinCount - self.spinCount)) {
        _isLeftSpin = NO;
    } else if(self.spinAngle < - InitSpinAngle / (InitSpinCount - self.spinCount)) {
        _isLeftSpin = YES;
    }
    
    CGFloat delta = PerSpinAngle * (1 + (InitSpinAngle / (InitSpinCount - self.spinCount) - fabs(self.spinAngle)) * FakeAcclerateSpeedParam);
    if(_isLeftSpin) {
        if(self.spinAngle == 0 || self.spinAngle * (self.spinAngle + delta) < 0) {
            [self hungImageReachLowestPosi];
        }
        self.spinAngle += delta;
    } else {
        if(self.spinAngle == 0 || self.spinAngle * (self.spinAngle - delta) < 0) {
            [self hungImageReachLowestPosi];
        }
        self.spinAngle -= delta;
    }

}

- (void)hungImageReachLowestPosi {
    self.spinCount --;
    
    if(self.spinCount == 0) {
        [self stopAnimation];
    }
}

#pragma mark - Getter
- (CGPoint)hungPoint {
    if(_hungPoint.x == InitPosiValue && _hungPoint.y == InitPosiValue) {
        return CGPointMake([UIScreen mainScreen].bounds.size.width * 0.8, [UIScreen mainScreen].bounds.size.height * 0.1);
    } else {
        return _hungPoint;
    }
}

- (CGSize)hungSize {
    if(_hungSize.height == InitPosiValue && _hungSize.width == InitPosiValue) {
        return CGSizeMake(50, 50);
    } else {
        return _hungSize;
    }
}

- (WYFloatAnimationImageView *)hungImageView {
    if(!_hungImageView) {
        _hungImageView = [[WYFloatAnimationImageView alloc] initWithFrame:[self calHungImageInitFrame]];
    }
    return _hungImageView;
}

- (UIImageView *)lineImage {
    if(!_lineImage) {
        _lineImage = [[UIImageView alloc] init];
        _lineImage.frame = [self calHungLineInitFrame];
        _lineImage.backgroundColor = [UIColor blackColor];
    }
    return _lineImage;
}

@end
