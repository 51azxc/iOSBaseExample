
#import "DBManager.h"

@implementation DBManager

@synthesize sharedIntance;

+ (DBManager *)getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

- (BOOL)createDB {
    BOOL isSuccess = YES;
    NSString *docsDir;
    NSArray *dirPaths;
    //get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    //build the path to the database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"test.db"]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:databasePath] == NO) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = "create table if not exists test(regno integer primary key, name text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create table");
                sqlite3_free(errMsg);
            }
            sqlite3_close(database);
            return isSuccess;
        }else{
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

- (BOOL)saveData:(NSString *)name {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into test(regno,name)values(NULL,\"%@\")", name];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            return YES;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

- (BOOL)deleteAllData {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *deleteSQL = @"delete from test";
        const char *insert_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            return YES;
        }
        sqlite3_reset(statement);
    }
    return NO;
}

- (NSArray *) findAll {
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *querySQL = @"select name from test";
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:name];
            }
            return resultArray;
        }
    }
    return nil;
}

@end
