<img src="http://cdn.luxstack.com/assets/razrbit-github-banner-dark-beta.png" style="width:100%"/>

Official SDKs: 
[Android](https://github.com/LUXSTACK/razrbit-sdk-android) | 
iOS | 
[Javascript](https://github.com/LUXSTACK/razrbit-sdk-javascript) | 
[PHP](https://github.com/LUXSTACK/razrbit-sdk-php) | 
[Ruby](https://github.com/LUXSTACK/razrbit-sdk-ruby)

**[LUXSTACK](https://luxstack.com) Bitcoin Platform and SDKs — build, test and scale bitcoin apps faster. Plug in our powerful SDKs to supercharge your bitcoin toolbox.**

# LUXSTACK SDK for iOS (Beta)

This SDK is a singleton which allows access to the REST services offered by Razrbit from the iOS platform. All calls are invoked asynchronously and simply require a block completion callback which will be invoked automatically when the request finishes.

## Installation

Installation is recommended via Cocoapods. Cocoapods is coming very soon. For now, please use the source code directly.
When the pod is online, add pod 'Razrbit' to your Podfile and run 'pod install'.

*Please note that while the Xcode project itself includes the RazrbitHarness which contains unit tests for all flavors of the API calls, this is not needed for simply making calls to Razrbit. Also, it is necessary to run 'pod install' to include project dependencies.'*

## Usage - REST API Calls

Be sure to import the Razrbit.h file where needed:

```
#import "Razrbit.h"
```

Prior to making any REST API calls, invoke the init method passing in your AppId and AppSecret which will be used for all subsequent invocations:

```
[[Razrbit sharedInstance] initWithAppID:@“myAppId” appSecret:@“myAppSecret”];
```

Once this has been done, any available services can be invoked. Response data is accessible in the callback and can be used as needed:

```
[[Razrbit sharedInstance] getBalanceFromAddress:@"1K8ZCd8xpbKZXj2QotFSzPGrgb1YNQV1yT" 
  completion:^(NSDictionary *responseValues, NSError *err) {
    // Callback invoked when the asynchronous call has completed.
    if (!err) {
        // Pull any needed data from the response.
        balance = [responseValues objectForKey:@"satoshiAmount"];
    } else {
        // Handle any errors that may be returned.
        NSLog(@"Error: %@", err.localizedDescription);
    }
}];
```

## API

### Wallet 

```ios
    [[Razrbit sharedInstance].wallet createNewAddressWithCompletion:^(NSDictionary *responseValues, NSError *err) {
            address = [responseValues objectForKey:@"address"];
            privateKey = [responseValues objectForKey:@"privateKey"];
    }];
```
Creates a new bitcoin address in your wallet.  Stores address and private key in the keychain,
and the address is made visible in the user_defaults under the key: ```address```.

```ios
    [[Razrbit sharedInstance].wallet sendAmountFromAddress:@"1exampleFromAddressPrivateKey"
                                                toAddress:@"1exampleToAddress"
                                                   amount:123456
                                               completion:^(NSDictionary *responseValues, NSError *err) {
                                                       output = [responseValues objectForKey:@"result"];
                                                       dummy = [responseValues objectForKey:@"dummy"];
                                               }];
```
Sends bitcoin from one of your addresses to the destination addresses. Amount is measured in bits.

```ios
[[Razrbit sharedInstance].wallet sendAmountFromKeychainForAmount:1234 completion:^(id responseValues, NSError *err) {
NSLog(@"%@", responseValues);
}];
```
Sends bitcoin from address stored in user_defaults to the destination stored in the keychain.


```ios
[[Razrbit sharedInstance].wallet getBalanceFromAddress:@"1EP2BdsBSRLCp8cd8L9Hmh1rGs89eaFcXw"
                                               completion:^(NSDictionary *responseValues, NSError *err) {
                                                       balance = [responseValues objectForKey:@"satoshiAmount"];
                                               }];
```
Returns the balance of the given address in bits.

### Explorer

```ios
[[Razrbit sharedInstance].explorer blockUsingBlockHash:@"000000000000000021c40d35f9c317d2e8c9ead4dec3e24b8d1919862bd8f89d"
                                      completion:^(NSDictionary *responseValues, NSError *err) {
                                          output = [responseValues objectForKey:@"message"];
                                      }];
```
Retrieve details about a given block

```ios
[[Razrbit sharedInstance].explorer transactionUsingTransactionHash:@"cd02255d491dfa1ff0a530c63a20f57e7fd829b2053ad15680390208d6552582"
                                      completion:^(NSDictionary *responseValues, NSError *err) {
                                          output = [responseValues objectForKey:@"blockhash"];
                                      }];
```
Retrieve details about a given transaction

```ios
[[Razrbit sharedInstance].explorer addressFromAddress:@"1K8ZCd8xpbKZXj2QotFSzPGrgb1YNQV1yT"
                                     completion:^(NSDictionary *responseValues, NSError *err) {
                                         output = [responseValues objectForKey:@"balance"];
                                     }];
```
Retrieve details about a given address

```ios
[[Razrbit sharedInstance].explorer addressUnspentOutputs:@"1K8ZCd8xpbKZXj2QotFSzPGrgb1YNQV1yT"
                                        completion:^(NSArray *responseValues, NSError *err) {
                                                if (responseValues.count > 0) {
                                                    NSDictionary *addressData = responseValues[0];
                                                    output = [addressData objectForKey:@"address"];
                                                    NSLog(@"output >> %@", output);
                                                }
                                        }];
```
Returns the list of unspent outputs for a given address

### Network

```ios
[[Razrbit sharedInstance].network getDifficultyWithCompletion:^(NSDictionary *responseValues, NSError *err) {
            output = [responseValues objectForKey:@"difficulty"];
    }];
```
Retrieve the current network difficulty

```ios
[[Razrbit sharedInstance].network pushTransaction:@"01000000010debc86da40173e5e77212e948dc820cf95cf1393e7db4f398d7ba3a427f780d010000006b483045022100d862f4002f52dcdcf0e6a40c2c2b950710138dd9e3163a9657e49fb7205716b2022055337d282f3bda17285509741595e95724afc52e0334a297d6211aa4288099d5012102e99a42d2739ad6e4f0b2d28d1dff36c83951ca24394a1c2afec211376dd23f50ffffffff0230750000000000001976a9141d46c398418cc0e88fc21e2b257a41ff02dabe2688ac00000000000000001976a9140699f547b36380245d9da068ff8aaca74c0b6a6588ac00000000"
                                  completion:^(NSDictionary *responseValues, NSError *err) {
                                      output = [responseValues objectForKey:@"result"];
                                  }];
```
Push a transaction onto the network

### Markets

```currencyCode``` is a valid ISO 4217 code such as ```USD``` or ```EUR```.

```ios
[[Razrbit sharedInstance].markets priceInCurrency:@"USD"
                                  completion:^(NSDictionary *responseValues, NSError *err) {
                                      output = [responseValues objectForKey:@"price"];
                                  }];
```
Returns the current bitcoin price

```ios
[[Razrbit sharedInstance].markets dayPriceInCurrency:@"USD"
                                     completion:^(NSDictionary *responseValues, NSError *err) {
                                         output = [responseValues objectForKey:@"dayPrice"];
                                     }];
```
Returns the day price

```ios
[[Razrbit sharedInstance] historicalPriceInCurrency:@"USD"
                                                onDate:[[NSDate date] dateByAddingTimeInterval:-24*60*60]
                                            completion:^(NSDictionary *responseValues, NSError *err) {
                                                output = [responseValues objectForKey:@""];
                                            }];
```
Returns the historical price at the given date. ```date``` must be a date in the ```yyyy-mm-dd``` format.

### Notifications

```ios
[[Razrbit sharedInstance].notifications address:@"1K8ZCd8xpbKZXj2QotFSzPGrgb1YNQV1yT"
                                      email:@"email@address.com"
                                 completion:^(NSDictionary *responseValues, NSError *err) {
                                     output = [responseValues objectForKey:@"result"];
                                 }];
```
Set up a notification email for a given address

```ios
[[Razrbit sharedInstance].notifications block:@"315692"
                                      email:@"email@address.com"
                                 completion:^(NSDictionary *responseValues, NSError *err) {
                                     output = [responseValues objectForKey:@"result"];
                                 }];
```
Set up a notification email for a given block

```ios
[[Razrbit sharedInstance].notifications transaction:@"7697a507f6084863482e7c072f8b097a78988d1812df814937ac04585c0baafd"
                                            email:@"email@address.com"
                                       completion:^(NSDictionary *responseValues, NSError *err) {
                                           output = [responseValues objectForKey:@"result"];
                                       }];
```
Set up a notification email for a given transaction

# Support

Feel free to request a feature and make suggestions for our [product team](mailto:team@luxstack.com).

* [GitHub Issues](https://github.com/luxstack/razrbit-sdk-ios/issues)

# License

**Code released under [the MIT license](https://github.com/LUXSTACK/razrbit-sdk-ios/blob/master/LICENSE).**

Copyright 2012-2014 LUXSTACK Inc. Razrbit is a trademark maintained by LUXSTACK Inc.

# LUXSTACK Bitcoin SDKs for other platforms

* [Android](https://github.com/LUXSTACK/razrbit-sdk-android)
* iOS
* [Javascript](https://github.com/LUXSTACK/razrbit-sdk-javascript)
* [PHP](https://github.com/LUXSTACK/razrbit-sdk-php)
* [Ruby](https://github.com/LUXSTACK/razrbit-sdk-ruby)