//
//  VideoCell.m
//  WMVideoPlayer
//
//  Created by zhengwenming on 16/1/17.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "VideoCell.h"
#import "UIImageView+WebCache.h"
#import "NewVideoModel.h"

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)startPlayVideo:(UIButton *)sender{
    if (self.startPlayVideoBlcok) {
        self.startPlayVideoBlcok(self.backgroundIV,self.model);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setModel:(NewVideoModel *)model{
    _model = model;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.text = model.title;
    self.descriptionLabel.text = model.descriptionDe;
    
    [self.backgroundIV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld万",(long)model.playCount];
    self.timeDurationLabel.text = model.ptime;

}
@end
