//
//  RazorpayEventEmitter.m
//  RazorpayCheckout
//
//  Created by Abhinav Arora on 11/10/17.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RazorpayEventEmitter.h"

#import "RCTBridge.h"
#import "RCTEventDispatcher.h"


NSString *const kPaymentError = @"PAYMENT_ERROR";
NSString *const kPaymentSuccess = @"PAYMENT_SUCCESS";
NSString *const kUpiApps = @"UPI_APPS";
NSString *const kPaymentMethods=@"PAYMENT_METHODS";
NSString *const kPaymentMethodsError=@"PAYMENT_METHODS_ERROR";
NSString *const kCardNetwork=@"CARD_NETWORK";
NSString *const kCardNetworkLength=@"CARD_NETWORK_LENGTH";
NSString *const kCredAppAvailable=@"CRED_APP_AVAILABLE";
NSString *const kWalletLogoUrl=@"WALLET_LOGO_URL";
NSString *const kSubscriptionAmount=@"SUBSCRIPTION_AMOUNT";
NSString *const kCardNumberValidity=@"CARD_NUMBER_VALIDITY";
NSString *const kVpaValidity=@"VPA_VALIDITY";
NSString *const kBankLogoUrl=@"BANK_LOGO_URL";
NSString *const kSqWalletLogoUrl=@"SQ_WALLET_LOGO_URL";

@implementation RazorpayEventEmitter

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
    return @[
        @"Razorpay::PAYMENT_SUCCESS",
        @"Razorpay::PAYMENT_ERROR",
        @"Razorpay::UPI_APPS",
        @"Razorpay::PAYMENT_METHODS",
        @"Razorpay::PAYMENT_METHODS_ERROR",
        @"Razorpay::CARD_NETWORK",
        @"Razorpay::CARD_NETWORK_LENGTH",
        @"Razorpay::CRED_APP_AVAILABLE",
        @"Razorpay::WALLET_LOGO_URL",
        @"Razorpay::SUBSCRIPTION_AMOUNT",
        @"Razorpay::CARD_NUMBER_VALIDITY",
        @"Razorpay::VPA_VALIDITY",
        @"Razorpay::BANK_LOGO_URL",
        @"Razorpay::SQ_WALLET_LOGO_URL"
    ];
}

- (void)startObserving {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(walletLogoUrl:)
                                                 name:kWalletLogoUrl
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(paymentSuccess:)
                                                 name:kPaymentSuccess
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(paymentError:)
                                                 name:kPaymentError
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(upiApps:)
                                                 name:kUpiApps
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(paymentMethods:)
                                                 name:kPaymentMethods
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(paymentMethodsError:)
                                                 name:kPaymentMethodsError
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cardNetwork:)
                                                 name:kCardNetwork
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cardNetworkLength:)
                                                 name:kCardNetworkLength
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(credAppAvailable:)
                                                 name:kCredAppAvailable
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(subscriptionAmount:)
                                                 name:kSubscriptionAmount
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cardNumberValidity:)
                                                 name:kCardNumberValidity
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(validVpa:)
                                                 name:kVpaValidity
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(bankLogoUrl:)
                                                 name:kBankLogoUrl
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sqWalletLogoUrl:)
                                                 name:kSqWalletLogoUrl
                                               object:nil];
}

- (void)stopObserving {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)paymentSuccess:(NSNotification *)notification {
    [self sendEventWithName:@"Razorpay::PAYMENT_SUCCESS"
                       body:notification.userInfo];
}

- (void)paymentError:(NSNotification *)notification {
    [self sendEventWithName:@"Razorpay::PAYMENT_ERROR"
                       body:notification.userInfo];
}

- (void)upiApps:(NSNotification *)notification {
    [self sendEventWithName:@"Razorpay::UPI_APPS"
                       body:notification.userInfo];
}

- (void)paymentMethods:(NSNotification *)notification{
    [self sendEventWithName:@"Razorpay::PAYMENT_METHODS"
                        body:notification.userInfo];
}

- (void)paymentMethodsError:(NSNotification *)notification{
    [self sendEventWithName:@"Razorpay::PAYMENT_METHODS_ERROR" body:notification.userInfo];
}

- (void)cardNetwork:(NSNotification *)notification{
    [self sendEventWithName:@"Razorpay::CARD_NETWORK" body:notification.userInfo];
}

- (void)cardNetworkLength:(NSNotification *)notification{
    [self sendEventWithName:@"Razorpay::CARD_NETWORK_LENGTH" body:notification.userInfo];
}

- (void)credAppAvailable:(NSNotification *)notification{
    [self sendEventWithName:@"Razorpay::CRED_APP_AVAILABLE" body:notification.userInfo];
}

- (void)walletLogoUrl:(NSNotification *) notification{
    [self sendEventWithName:@"Razorpay::WALLET_LOGO_URL" body:notification.userInfo];
}

- (void)subscriptionAmount:(NSNotification *) notification{
    [self sendEventWithName:@"Razorpay::SUBSCRIPTION_AMOUNT" body:notification.userInfo];
}

- (void)cardNumberValidity:(NSNotification *) notification{
    [self sendEventWithName:@"Razorpay::CARD_NUMBER_VALIDITY" body:notification.userInfo];
}

- (void)validVpa:(NSNotification *) notification{
    [self sendEventWithName:@"Razorpay::VPA_VALIDITY" body:notification.userInfo];
}

- (void)bankLogoUrl:(NSNotification *) notification{
    [self sendEventWithName:@"Razorpay::BANK_LOGO_URL" body:notification.userInfo];
}

- (void)sqWalletLogoUrl:(NSNotification *) notification{
    [self sendEventWithName:@"Razorpay::SQ_WALLET_LOGO_URL" body:notification.userInfo];
}



+ (void)onPaymentSuccess:(NSString *)payment_id
                 andData:(NSDictionary *)response {
    NSDictionary *payload = [NSDictionary dictionaryWithDictionary:response];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPaymentSuccess
                                                        object:nil
                                                      userInfo:payload];
}



+ (void)onPaymentError:(int)code
           description:(NSString *)str
               andData:(NSDictionary *)response {

    NSMutableDictionary *payload = [response mutableCopy];
    [payload setValue:@(code) forKey:@"code"];
    [payload setValue:str forKey:@"description"];

    [[NSNotificationCenter defaultCenter] postNotificationName:kPaymentError
                                                        object:nil
                                                      userInfo:payload];
}

+ (void)upiApps:(NSArray *)upiApps {
    NSMutableArray *apps = [[NSMutableArray alloc] init];
    for (NSString *app in upiApps) {
        NSDictionary *dataDict = @{ @"appName" : app};
        [apps addObject:dataDict];
    }
    NSDictionary *payload = @{ @"data" : apps};
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpiApps
                                                        object:nil
                                                      userInfo:payload];
}

+ (void)paymentMethods:(NSDictionary *)paymentMethods{
    NSDictionary *methods = [NSDictionary dictionaryWithDictionary:paymentMethods];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPaymentMethods
                                                        object:nil
                                                        userInfo:methods];
}

+ (void)paymentMethodsError:(NSDictionary *)error{
    NSDictionary *errorObj = [NSDictionary dictionaryWithDictionary:error];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPaymentMethodsError
                                                        object:nil
                                                        userInfo:errorObj];
}

+ (void)cardNetwork:(NSDictionary *)response{
    NSDictionary *obj = [NSDictionary dictionaryWithDictionary:response];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCardNetwork
                                                        object:nil
                                                      userInfo:obj];
}

+ (void)cardNetworkLength:(NSDictionary *)response{
    NSDictionary *obj = [NSDictionary dictionaryWithDictionary:response];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCardNetworkLength
                                                        object:nil
                                                      userInfo:obj];
}

+ (void) credAppAvailable:(NSDictionary *)response{
    NSDictionary *obj = [NSDictionary dictionaryWithDictionary:response];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCredAppAvailable
                                                        object:nil
                                                      userInfo:obj];
}



+ (void) subscriptionAmount:(NSDictionary *)response{
    NSDictionary *obj = [NSDictionary dictionaryWithDictionary:response];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSubscriptionAmount
                                                        object:nil
                                                      userInfo:obj];
}

+ (void) cardNumberValidity:(NSDictionary *)response{
    NSDictionary *obj = [NSDictionary dictionaryWithDictionary:response];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCardNumberValidity
                                                        object:nil
                                                      userInfo:obj];
}

+ (void) validVpa:(NSDictionary *)response{
    NSDictionary *obj = [NSDictionary dictionaryWithDictionary:response];
    [[NSNotificationCenter defaultCenter] postNotificationName:kVpaValidity
                                                        object:nil
                                                      userInfo:obj];
}

+ (void) bankLogoUrl:(NSDictionary *)response{
    NSDictionary *obj = [NSDictionary dictionaryWithDictionary:response];
    [[NSNotificationCenter defaultCenter] postNotificationName:kBankLogoUrl
                                                        object:nil
                                                      userInfo:obj];
}

+ (void) walletLogoUrl:(NSDictionary *)response{
    NSDictionary *obj = [NSDictionary dictionaryWithDictionary:response];
    [[NSNotificationCenter defaultCenter] postNotificationName:kWalletLogoUrl
                                                    object:nil
                                                  userInfo:obj];
}

+ (void) sqWalletLogoUrl:(NSDictionary *)response{
    NSDictionary *obj = [NSDictionary dictionaryWithDictionary:response];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSqWalletLogoUrl
                                                        object:nil
                                                      userInfo:obj];
}


@end
