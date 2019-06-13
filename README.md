# BFAutoCache

![](https://img.shields.io/badge/language-swift-orange.svg)
![](https://img.shields.io/cocoapods/v/BFAutoCache.svg?style=flat)
![](https://img.shields.io/cocoapods/p/BFAutoCache.svg?style=flat)
![](https://img.shields.io/cocoapods/l/BFAutoCache.svg?style=flat)

A box value type for automatically caching the value<V> to a specific backend(default is UserDefaults)

## Motivation
Everytime you need to save & access a value which saved in UserDefaults, you'll probablly endup in such code fragment: 

```Swift
var isOn: Bool {
  set {
    UserDefaults.standard.set(newValue, forKey: "kIsOn")
  }
  get {
    return UserDefaults.standard.bool(forKey: "kIsOn")
  }
}

var userID: Int {
  set {
    UserDefaults.standard.set(newValue, forKey: "kUserID")
  }
  get {
    return UserDefaults.standard.integer(forKey: "kUserID")
  }
}

...
```

Things get much boring and annoying if you have a bunch of different values to handle. You have to repeatly write the same code for each value that need to read from/write to UserDefaults. Though you can wrapper a general method to make the setValue/getValue simpler, you still have to care about the "Key" name to make read/write consistent.

**BFAutoCache** makes such boring task much simpler and even a little bit funny!

## Using BFAutoCache
To cache a value, a key is needed to save the value and retrieve it. So when defining a AutoCache value,
 a *name* is always required to bind the value. The value of the AutoValue instance is retrieved by accessing
 the *value* property.
 
 Samples:
 
 ```Swift
 var i = AutoCache<Int>(name: "a")
 i.value = 1
 print(i.value)
 
 // This is equal to (by default Cachable implementation):
 // UserDefaults.standard.set(1, forKey: "a")
 // UserDefaults.standard.synchronize()
 // print(UserDefaults.standard.int(forKey: "a"))
 
 var s = AutoCache<String>(name: "s")
 s.value = "Snow"
 print(s.value)
 
 // This is equal to (by default Cachable implementation):
 // UserDefaults.stand.set("Snow", forKey: "a")
 // UserDefaults.synchronize()
 // print(UserDefaults.standard.string(forKey: "a"))
 
 ```
 
 There are also three operators which help maniplulate the AutoCache value much more easier and simple.
 - To bind the key name with the value, use '*~~*':
 
 ```Swift
 var i = 1~~'i'
 var s = "Ned"~~"LordOfNorth"
 ```
 
 - To assign a value, use '*<~*'
 
 ```Swift
 i <~ 2
 s <~ "Snow"
 ```
 
 - To access the value, use '*%%*'
 
 ```Swift
 print(%%i)  // 2
 print(%%s)  // Snow
 ```

 - To clear a value in cache, assign a nil value to the AutoCache variable:
 
 ```Swift
 i <~ nil
 s <~ nil
 ```
 
 AutoCache value is particularly usaful when declaring multiple configuration properties in a struct or class.
 You can specify which properties need to be save/access from the backend cache or not.
 
 For example:
 
 ```Swift
 struct Settings {
 var delay: AutoCache<Int>      // need cache
 var title: AutoCache<String>   // need cache
 var brightness: Float          // not cache
 }
 
 var settings = Settings(delay: 11~~"Delay", name: "hello"~~"Title", brightness: 1.0)
 ```
 
 **BFAutoCache** also supports Array & Dictionary of the `basic value type` that compatible with UserDefaults.
 
 ```Swift
 var cards: AutoCache<[Int]>
 cards <~ [A, 2, J, K]
 
 var books: AutoCache<[String: Float]>
 books <~ ["Swift": 10.0, "Java": 8.0]
 ```
 
 ## Enhance the BFAutoCache
Actually, any type that confirms to **`Cachable`** protocol can leverage the benefit of AutoCache box value. You can write you own cachable type extension to pass into AutoCache, for example, a sqlite wrapper or CoreData wrapper, or even a plist wrapper.
 
 
  
 
