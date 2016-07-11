# Multiplatform Calabash

## Impetus

Frequently, companies develop native mobile applications for both iOS and Android alongside one another. Usually, parity of behaviour between apps is
 an important requirement. If I switch platforms I don't want to find that several features I relied on are no where to be seen!
 
The apps will not be identical however - there may be differing design principles between platforms. For example, say I want to see my saved locations.
This may mean opening a burger menu on Android and tapping the Locations option, whereas there is a tab bar icon for the same purpose on iOS.

This project provides a framework for sharing as much test code between platforms as possible, allowing you to delegate behaviour only when you need to.