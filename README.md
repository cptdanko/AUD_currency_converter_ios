[![N|Solid](https://mydaytodo.com/wp-content/uploads/2018/08/MDTicon-1-150x150.png)](https://mydaytodo.com/)
# AUDCurrencyConverter (Full iOS app)
The open-source part of my recently released [AUD $ Converter] app on the iOS App Store. The project in this repository has all aspects of the iOS app published to the App Store, except 
1. The logic to setup and add 3 favourite currencies for conversion
2. The asynchoronous queue used to pipeline network requests to make it scaleable

Apart from the aforementioned features, every other aspect of the version of the app released on the iOS App Store is here. 

## Who's this app for? User Story
I am an Australian backpacker travelling across Europe and I want an app which can tell me how much of the local currency of the country where I am will I get for the Australian $ I have on me. Have a read of the [CurrencyConverterApp.pdf] file included in this repo, to see the above user story in more detail. I have extrapolated that story into a 4+ page requirements specification document, which adopts a top down approach i.e. 
- Define the user story
- Understand the user story
- Think what's required technically e.g. specific iOS controls such as UIButton etc
- Think about the app architecture and how to decouple network request API code
- Questions from the project if any?

### How to use it?
Checkout the repo and before you start the project,
Navigate to the project directory on command line and run 
```
pod install
```

Have a read of this post on medium to know more on building and [publishing Cocoapods] on Github.


### Aspects of this repo, that can be imroved
These are strictly things that I can think of right now, if you feel I have missed something after you read this, then please let me know.
1. For this version of the repo MVVM pattern is only partially implemented
2. The app code should supply the external API url to the CurrencyAPI Cocoapod? I think so, but I think it's hard to parse the json response without knowing it's structure. What do you think?
3. Should we add showLoadingIcon (UIActivityIndicator) to UIView and therefore every view that inherits from it? or should we just add it to the UIControls that need it in the app?


## Summary
If you found this Github repo useful, would like to support me and My Day To-Do, try one of our [apps]. While you there and maybe leave a review for the app on the iOS app store!


[CurrencyConverterApp.pdf]: https://github.com/cptdanko/AUDCurrencyConverter/blob/master/CurrencyConverterApp.pdf
[CurrencyAPI pod on Github]: https://github.com/cptdanko/CurrencyAPI
[AUD $ Converter]: https://apps.apple.com/au/app/aud-$-currency-converter/id1501784723
[apps]: https://mydaytodo.com/apps/
[publishing Cocoapods]: https://medium.com/@bhuman.soni/open-source-currencyapi-cocoapod-on-github-9734f068b650
[My Day To-Do]: https://mydaytodo.com/
[blog]: https://mydaytoco.com/blog
