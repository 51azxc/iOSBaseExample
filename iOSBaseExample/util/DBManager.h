
/*
使用sqlite低级API创建数据库。需要引入libsqlite3.dylib库。
建议使用FMDB
 */

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

@property (nonatomic, strong) DBManager *sharedIntance;

+ (DBManager *)getSharedInstance;
- (BOOL)saveData:(NSString *)name;
- (BOOL)deleteAllData;
- (NSArray *) findAll;

@end
