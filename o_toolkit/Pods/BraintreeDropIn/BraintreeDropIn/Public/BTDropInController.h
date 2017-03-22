#import <UIKit/UIKit.h>
#import "BTDropInBaseViewController.h"
#import "BTDropInResult.h"
#import "BTDropInRequest.h"
#import "BTPaymentSelectionViewController.h"
#import "BTCardFormViewController.h"

@class BTPaymentMethodNonce;
@protocol BTAppSwitchDelegate;
@protocol BTViewControllerPresentingDelegate;

NS_ASSUME_NONNULL_BEGIN

/// The primary UIViewController for Drop-In. BTDropInController will manage the other UIViewControllers and return a BTDropInResult.
@interface BTDropInController : UIViewController <UIToolbarDelegate, UIViewControllerTransitioningDelegate>

typedef void (^BTDropInControllerHandler)(BTDropInController * _Nonnull controller, BTDropInResult * _Nullable result, NSError * _Nullable error);

/// Initialize a new Drop-in view controller.
///
/// @param authorization A Braintree tokenization key, or a client token generated by your server.
/// Passing an invalid value may return `nil`.
/// @param handler A callback block that is invoked when tokenization has succeeded or failed.
///
/// @return A Drop-in controller that is ready to be presented, or `nil` if `authorization` is invalid.
- (nullable instancetype)initWithAuthorization:(NSString *)authorization
                                       request:(BTDropInRequest *)request
                                       handler:(nullable BTDropInControllerHandler)handler;

/// The API client used for communication with Braintree servers.
@property (nonatomic, strong, readonly) BTAPIClient *apiClient;

/// The BTDropInRequest used to customize Drop-in
@property (nonatomic, strong, readonly) BTDropInRequest *dropInRequest;

/// Show the BTCardFormViewController
///
/// @param sender The sender requesting the view be changed.
- (void)showCardForm:(id)sender;

@end

NS_ASSUME_NONNULL_END
