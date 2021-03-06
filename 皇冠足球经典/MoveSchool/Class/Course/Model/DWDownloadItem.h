#import <Foundation/Foundation.h>
#import "DWDownloader.h"

enum {
    DWDownloadStatusWait = 1,
    DWDownloadStatusStart,
    DWDownloadStatusDownloading,
    DWDownloadStatusPause,
    DWDownloadStatusFinish,
    DWDownloadStatusFail
};

typedef NSInteger DWDownloadStatus;

@interface DWDownloadItem : NSObject<NSCoding>

@property (strong, nonatomic)NSString *definition;
@property (strong, nonatomic)NSString *videoId;
@property (strong, nonatomic)NSString *videoPath;
@property (assign, nonatomic)NSInteger videoFileSize;
@property (assign, nonatomic)NSInteger videoDownloadedSize;
@property (assign, nonatomic)float videoDownloadProgress;
@property (assign, nonatomic)DWDownloadStatus videoDownloadStatus;

//图片
@property (copy, nonatomic) NSString *imageUrl;

//标题
@property (copy, nonatomic) NSString *title;

//时长
@property (nonatomic, copy) NSString *duration;

//简介
@property (nonatomic, copy) NSString *desc;


//视频大小
@property (copy, nonatomic) NSString *size;

//视频名称
@property (copy, nonatomic) NSString *name;

//PDF地址
@property (copy, nonatomic) NSString *pdfUrl;

//类型
@property(nonatomic, assign) int format;

//章节ID
@property (copy, nonatomic) NSString *chapterid;

//图片
@property (nonatomic, copy) UIImage *image;

//是否选中
@property (nonatomic, assign) BOOL isSelected;


@property (strong, nonatomic)DWDownloader *downloader;

- (id)initWithItem:(NSDictionary *)item;

- (NSDictionary *)getItemDictionary;
- (NSString*)description;

- (UIImage *)getDownloadStatusImage;

@end


@interface DWDownloadItems : NSObject

@property (strong, nonatomic)NSMutableArray *items;
@property (assign, atomic)BOOL isBusy;

- (id)initWithPath:(NSString *)path;

- (void)removeObjectAtIndex:(NSUInteger)index;

- (BOOL)writeToPlistFile:(NSString*)filename;

@end
