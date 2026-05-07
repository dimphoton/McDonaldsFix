# McDonaldsFix

A tweak to bypass the forced upgrade in the McDonald's app

Despite some older versions of the McDonald's app having some level of compatibility, the McDonald's API (at least in the US) blocks their requests. This tweak restores functionality to certain older versions of the app by modifying the User-Agent header in requests to the API and by preventing upgrade popups from being displayed.

## Update (6 May 2026)

As I mentioned when I announced this tweak, I looked into adding support for the global version of the McDonald's app. However, I did not have the knowledge necessary to bypass its greater security.

Since publishing the tweak, my life has become busier, and I no longer use my iPhone 12 regularly. Unfortunately I believe, within the past few months, older versions of the McDonald's app have broken more.

Due to these reasons, I have decided to not continue working on this project. I will be archiving the GitHub repo. Also, my package repo will be terminated on 6 June.

Thanks to those who help test the tweak and anyone who used it!

## Compatible Versions

McDonaldsFix is currently compatible with at least versions 7.x.x and 8.x.x of the McDonalds US app. It might work with older versions provided they use the same API.

## Configuration

The iOS and app versions that are being spoofed to can be changed. The tweak can also be toggled on or off. These changes can be made in a preference pane in Settings.

## License

This project is made available under the [GNU GPLv3](LICENSE).
