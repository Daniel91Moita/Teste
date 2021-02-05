//
//  BookCollectionViewCell.m
//  BookStore_DanielMoita
//
//  Created by itsector on 01/02/2021.
//

#import "BookCollectionViewCell.h"
@interface BookCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnail;

@end

@implementation BookCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageThumbnail.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)configureCellWithBook:(Book *)book
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:book.bookCover];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageThumbnail.image = [UIImage imageWithData:data];
        });
    });
}

@end
