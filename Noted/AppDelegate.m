#import "AppDelegate.h"

#import "../Dropbox.framework/Headers/Dropbox.h"

#import "MasterViewController.h"

@implementation AppDelegate

@synthesize noteListViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  NSString* APP_KEY = @"dy750oc3p2bdph2";
  NSString* APP_SECRET = @"na14frfewjf5mr7";
  
  DBAccountManager* accountMgr = [[DBAccountManager alloc] initWithAppKey:APP_KEY secret:APP_SECRET];
  [DBAccountManager setSharedManager:accountMgr];
  
  DBAccount* account = [DBAccountManager sharedManager].linkedAccount;
  
  if (account.isLinked) {
    DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:account];
    [DBFilesystem setSharedFilesystem:filesystem];
  }
  
  return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
  sourceApplication:(NSString *)source annotation:(id)annotation {
  DBAccount* account = [[DBAccountManager sharedManager] handleOpenURL:url];
  

  if (account) {
    DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:account];
    [DBFilesystem setSharedFilesystem:filesystem];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AccountLinked" object:nil];
    
    return YES;
  }
  
  return NO;
}

@end
