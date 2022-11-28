# react-native-customui
[![npm](https://img.shields.io/npm/l/express.svg)]()

[![NPM](https://nodei.co/npm/react-native-customui.png?downloads=true)](https://nodei.co/npm/react-native-customui/)

React Native wrapper around our Android and iOS mobile SDKs

* [Installation](#installation)
* [Linking](#linking)
* [Usage](#usage)
* [UPI Intent Flow](#upi-intent-flow)

The following documentation is only focussed on the react-native wrapper around our Android and iOS sdks. To know more about our react-native SDK, refer to the following documentation - 

https://razorpay.com/docs/payment-gateway/react-native-integration/

To know more about Razorpay payment flow and steps involved, read up here:
<https://docs.razorpay.com/docs>

## Installation

Using npm:

```shell
npm install --save react-native-customui
```

or using yarn:

```shell
yarn add react-native-customui
```
## Linking

### Automatic

<details>
    <summary>iOS</summary>

1. `$ npm install react-native-customui --save` // Install the Razorpay React Native Custom UI SDK using the npm command.

2. `react-native link react-native-customui` // Link the SDK with React Native Project using Xcode.

3. Drag the `Razorpay.framework` file from the Libraries folder and drop it under the root folder, for more info follow [this link](https://razorpay.com/docs/payment-gateway/react-native-integration/standard/#step-2---link-the-sdk-with-react),
after this go to **Target** > **General Settings**> **Framework, Libraries and Embedded Content** section, set the **Embed** status of Razorpay.framework to **Embed & Sign**. 

6. Also make sure the razorpay framework is added in the embedded binaries section and you have Always Embed Swift 
   Standard Binaries set to yes in build settings.
</details>

### Manual

<details>
    <summary>iOS (via CocoaPods)</summary>

Add the following line to your build targets in your `Podfile`

`pod 'react-native-customui', :path => '../node_modules/react-native-customui'`

Then run `pod install`

</details>

<details>
    <summary>iOS (without CocoaPods)</summary>

In XCode, in the project navigator:

* Right click _Libraries_
* Add Files to _[your project's name]_
* Go to `node_modules/react-native-customui`
* Add the `.xcodeproj` file

In XCode, in the project navigator, select your project.

* Add the `libRNDeviceInfo.a` from the _deviceinfo_ project to your project's _Build Phases ➜ Link Binary With Libraries_
* Click `.xcodeproj` file you added before in the project navigator and go the _Build Settings_ tab. Make sure _All_ is toggled on (instead of _Basic_).
* Look for _Header Search Paths_ and make sure it contains both `$(SRCROOT)/../react-native/React` and `$(SRCROOT)/../../React`
* Mark both as recursive (should be OK by default).

Run your project (Cmd+R)

</details>

<details>
    <summary>Android </summary>


1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.razorpay.rn.RazorpayPackage;` to the imports at the top of
  the file
  - Add `new RazorpayPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
    ```gradle
    include ':react-native-razorpay'
    project(':react-native-razorpay').projectDir = new File(rootProject.projectDir,   '../node_modules/react-native-customui/android')
    ```
3. Insert the following lines inside the dependencies block in
`android/app/build.gradle`:
    ```gradle
    implementation project(':react-native-customui')
    ```
</details>

## Usage

Sample code to integrate with Razorpay can be found in
[index.js][index.js] in the included example directory.

To run the example, simply do the following in example directory and then
link iOS SDK as explained in the previous section:

`$ npm i`

### Steps

1. Import Razorpay module to your component:
    ```js
    import Razorpay from 'react-native-customui';
    ```

2. Call `Razorpay.open` method with the payment `options`. The method
returns a **JS Promise** where `then` part corresponds to a successful payment
and the `catch` part corresponds to payment failure.
    ```js
    <TouchableHighlight onPress={() => {
      var options = {
        description: 'Credits towards consultation',
        currency: 'INR',
        key_id: 'rzp_test_1DP5mmOlF5G5ag',
        amount: '5000', // amount in currency subunits. Defaults to INR. 100 = 100 paise = INR 1.
        email: 'void@razorpay.com',
        contact: '9999999123',
        method: 'netbaking',
        bank: 'HDFC'
        
      }
      Razorpay.open(options).then((data) => {
        // handle success
        alert(`Success: ${data.razorpay_payment_id}`);
      }).catch((error) => {
        // handle failure
        alert(`Error: ${error.code} | ${error.description}`);
      });
    }}>
    ```

## UPI Intent flow

For using UPI Intent flow in Razorpay's React Native Custom UI plugin, you have to follow below steps.

### Steps

1. Call getAppsWhichSupportUPI function for getting all the avilable apps in users phone. 

    ```js
    Razorpay.getAppsWhichSupportUPI((data) => {
        console.log("Supported Apps",data);
    }); 
    ```

2. Ensure that the `upi_app_package_name` is passed from the `getSupportedUPIApps()` method value. Otherwise, it will not pass the validation.

      ```js
      var options = {
        description: 'Credits towards consultation',
        currency: 'INR',
        key_id: 'rzp_test_1DP5mmOlF5G5ag',
        amount: '5000', // amount in currency subunits. Defaults to INR. 100 = 100 paise = INR 1.
        email: 'void@razorpay.com',
        contact: '9999999123',
        method: 'upi',
        upi_app_package_name : "google_pay",
        '_[flow]' : "intent"
        }
      ```
      
3. Your iOS app must seek permission from the device to open the UPI PSP app that the customer selects on the Checkout. For this, you must make the following changes in your iOS app's info.plist file.

    ```js
    <key>LSApplicationQueriesSchemes</key>
        <array>
        <string>tez</string>
        <string>phonepe</string>
        <string>paytmmp</string>
        </array>
    ```

A descriptive list of valid options for customui options is available [here].

## License

react-native-customui is Copyright (c) 2021 Razorpay Software Pvt. Ltd.
It is distributed under [the MIT License][LICENSE].

We ♥ open source software!
See [our other supported plugins / SDKs][integrations]
or [contact us][contact] to help you with integrations.

[here]: https://docs.razorpay.com/v1/page/android-custom-ui-sdk-v2x
[contact]: mailto:integrations@razorpay.com?subject=Help%20with%20React%20Native "Send us a mail"
[index.js]: example/index.js "index.js"
[integrations]: https://razorpay.com/integrations "List of our integrations"
[LICENSE]: /LICENSE "MIT License"
[wiki]: https://github.com/razorpay/react-native-customui/wiki/Manual-installation
