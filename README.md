# McDonaldsFix

A tweak to bypass the forced upgrade in the McDonald's app

Despite some older versions of the McDonald's app having some level of compatibility, the McDonald's API (at least in the US) blocks their requests. This tweak restores functionality to certain older versions of the app by modifying the User-Agent header in requests to the API and by preventing upgrade popups from being displayed.

## Compatible Versions

McDonaldsFix is currently compatible with at least versions 7.x.x and 8.x.x of the McDonalds US app. It might work with older versions provided they use the same API.

## Configuration

The iOS and app versions that are being spoofed to can be changed. The tweak can also be toggled on or off. These changes can be made in a preference pane in Settings.

## Download

* Download from my [repo](https://repo.dimphoton.me/)
* or, alternatively, download from [Releases](https://github.com/dimphoton/McDonaldsFix/releases)

## License

This project is made available under the [GNU GPLv3](LICENSE).