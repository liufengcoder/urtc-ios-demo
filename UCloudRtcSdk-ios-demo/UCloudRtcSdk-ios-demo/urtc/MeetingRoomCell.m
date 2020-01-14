//
//  MeetingRoomCell.m
//  UCloudRtcSdkDemo
//
//  Created by tony on 2019/4/28.
//  Copyright © 2019年 ucloud. All rights reserved.
//

#import "MeetingRoomCell.h"



@interface MeetingRoomCell ()<UCloudRtcRenderDelegate>
@property (nonatomic, weak) UCloudRtcStream *stream;
@end

@implementation MeetingRoomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor grayColor];
}


- (void)configureWithStream:(UCloudRtcStream *)stream {
    self.stream = stream;
    stream.delegate = self;
    [stream renderOnView:self.contentView];
    if (stream.userId) {
        UILabel *streamLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        streamLabel.textColor = [UIColor whiteColor];
        streamLabel.textAlignment = NSTextAlignmentCenter;
        streamLabel.text = [NSString stringWithFormat:@"id:%@",stream.userId];
        [self.contentView addSubview:streamLabel];
        
        UIButton *audioBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20, self.frame.size.height - 20, 20, 20)];
        [audioBtn setImage:[UIImage imageNamed:@"microphone.png"] forState:UIControlStateNormal];
        [audioBtn setImage:[UIImage imageNamed:@"microphone_close.png"] forState:UIControlStateSelected];
        [audioBtn addTarget:self action:@selector(audioClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:audioBtn];
        
        
        UIButton *videoBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 45, self.frame.size.height - 20, 20, 20)];
        [videoBtn setImage:[UIImage imageNamed:@"camera_btn_on.png"] forState:UIControlStateNormal];
        [videoBtn setImage:[UIImage imageNamed:@"camera_btn_off.png"] forState:UIControlStateSelected];
        [videoBtn addTarget:self action:@selector(videoClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:videoBtn];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.stream.preview.frame = self.contentView.bounds;
}

-(void)audioClick:(UIButton *)btn {
    btn.selected =!btn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didMuteStream:muteAudio:)]) {
        [self.delegate didMuteStream:self.stream muteAudio:btn.selected];
    }
}

-(void)videoClick:(UIButton *)btn {
    btn.selected =!btn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didMuteStream:muteVideo:)]) {
        [self.delegate didMuteStream:self.stream muteVideo:btn.selected];
    }
}

#pragma mark --UCloudRtcRenderDelegate
- (void)uCloudRtcRenderVideoFirstFrame:(NSString *)streamID{
    NSLog(@"首帧渲染完成通知:流ID:%@",streamID);
}
@end
