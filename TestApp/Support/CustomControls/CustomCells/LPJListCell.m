//
//  LPJListCell.m
//  TestApp
//
//  Created by Leonardo Parro Jr on 9/3/13.
//  Copyright (c) 2013 Leonardo Parro Jr. All rights reserved.
//

#import "LPJListCell.h"

@interface LPJListCell()
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailIconImgView;
@end

///////////////////////////////////////////////////////////////////////////////
@implementation LPJListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods
///////////////////////////////////////////////////////////////////////////////
- (void)bindData:(NSDictionary *)dParams
{
    self.nameLabel.text = dParams[@"title"];
    
    id sDescription = dParams[@"description"]; // check for NSNull
    self.descriptionLabel.text = (sDescription != [NSNull null]) ? (NSString *)sDescription : @"";  
    
    id imgHref = dParams[@"imageHref"];
    NSString *sImgURL = (imgHref != [NSNull null]) ? (NSString *)imgHref : @"";

    if ([sImgURL length] > 0) {
        [self.thumbnailIconImgView setImageWithURL:[NSURL URLWithString:sImgURL]];
    }
    else {
        [self.thumbnailIconImgView setImage:nil];
    }
}

@end
