# CurrencyAPI (Framework)
This is part of the old architecture still kept here for reference purposes.

## What is this?
This project is an Xcode project of type framework. Initially, we determined that this aspect of the app i.e. getting exchange rate information can exist independantly of the main app and as such can be deoupled from the UICode.

## The process to get here

This is how the code evolved over time in the AUDCurrencyConverter app

| Version        | Description |
| ------------- |:-------------
| 1      | All the code was within it's individual classex
| 2      | All the code was grouped under it's own folder within app
| 3 | The code was tranferred into it's own Xcode framework and used via library
|4| All methods to be used outside the project were marked public and this was published as a [CurrencyAPI pod on Github]. You can look at that repo for installation instructions

## Goal
Remember the reason this project still exits as a part of this repo is for reference purposes only. At run-time the app uses the [CurrencyAPI pod on Github].

### Summary
If you found this Github repo useful, would like to support me and My Day To-Do, you can support me by trying one of My Day To-Do [apps]. While you there and maybe leave a review for the app on the iOS app store or read mmy [blog].

[CurrencyAPI pod on Github]: https://github.com/cptdanko/CurrencyAPI
[apps]:(https://mydaytodo.com/apps/)
[My Day To-Do]: (https://mydaytodo.com/)
[blog]: (https://mydaytoco.com/blog)
[![N|Solid](https://mydaytodo.com/wp-content/uploads/2018/08/MDTicon-1-150x150.png)](https://mydaytodo.com/)
