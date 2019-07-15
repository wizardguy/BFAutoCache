//
//  BFAutoCache.swift
//
//
//  Created by Dennis on 2019/5/10.
//  Copyright © 2019 Dennis Wu. All rights reserved.
//
import Foundation


/**
 Protocol Cachable
 */
public protocol Cachable {
    associatedtype T
    static func cache(value: T, forKey: String)
    static func fetchValue(forKey: String) -> T
    static func regist(value: T, forKey: String)
    static func clear(forKey: String)
}


public extension Cachable {
    static func clear(forKey: String) {
        UserDefaults.standard.removeObject(forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    static func regist(value: T, forKey: String) {
        UserDefaults.standard.register(defaults: [forKey: value])
    }
}


extension Int: Cachable {
    public typealias T = Int
    public static func cache(value: Int, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    public static func fetchValue(forKey: String) -> Int {
        return UserDefaults.standard.integer(forKey: forKey)
    }
}


extension String: Cachable {
    public typealias T = String
    public static func cache(value: String, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    public static func fetchValue(forKey: String) -> String {
        return UserDefaults.standard.string(forKey: forKey) ?? ""
    }
}

extension Bool: Cachable {
    public typealias T = Bool
    public static func cache(value: Bool, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    public static func fetchValue(forKey: String) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey)
    }
}

extension Float: Cachable {
    public typealias T = Float
    public static func cache(value: Float, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    public static func fetchValue(forKey: String) -> Float {
        return UserDefaults.standard.float(forKey: forKey)
    }
}

extension Double: Cachable {
    public typealias T = Double
    public static func cache(value: Double, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    public static func fetchValue(forKey: String) -> Double {
        return UserDefaults.standard.double(forKey: forKey)
    }
}


extension Array: Cachable {
    public typealias T = [Any]
    public static func fetchValue(forKey: String) -> [Any] {
        return UserDefaults.standard.array(forKey: forKey) ?? []
    }
    public static func cache(value: [Any], forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
}


extension Dictionary: Cachable {
    public typealias T = [String: Any]
    public static func fetchValue(forKey: String) -> [String : Any] {
        return UserDefaults.standard.dictionary(forKey: forKey) ?? [:]
    }
    public static func cache(value: [String : Any], forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
}

/**
 A box value for automatically caching the value<V> to a specific backend(default is UserDefaults)
 
 To cache a value, a key is needed to save the value and retrieve it. So when defining a AutoCache value,
 a *name* is always required to bind the value. The value of the AutoValue instance is retrieved by accessing
 the *value* property.
 
 Samples:
 ```
 var i = AutoCache<Int>(name: "a")
 i.value = 1
 print(i.value)
 
 // This is equal to (by default Cachable implementation):
 // UserDefaults.standard.set(1, forKey: "a")
 // UserDefaults.standard.synchronize()
 // print(UserDefaults.standard.int(forKey: "a"))
 
 Or you can use a initial value as the default value if there is no such key in Defaults
 var i = AutoCache<Int>(name: "a", initial: 1)
 
 // This is equal to (by default Cachable implementation):
 // UserDefaults.standard.regist(defaults: ["a": 1])
 
 var s = AutoCache<String>(name: "s")
 s.value = "Snow"
 print(s.value)
 
 // This is equal to (by default Cachable implementation):
 // UserDefaults.stand.set("Snow", forKey: "a")
 // UserDefaults.synchronize()
 // print(UserDefaults.standard.string(forKey: "a"))
 
 ```
 
 There are also three operators which help maniplulate the AutoCache value much more easier and simple.
 - To bind the key name with a default value, use '*~~*':
 ```
 var i = 1~~'i'
 var s = "Ned"~~"LordOfNorth"
 ```
 
 - To assign a value, use '*<~*'
 ```
 i <~ 2
 s <~ "Snow"
 ```
 
 - To access the value, use '*%%*'
 ```
 print(%%i)
 print(%%s)
 ```
 - To clear a value in cache, assign a nil value to the AutoCache variable:
 ```
 i <~ nil
 s <~ nil
 ```
 
 AutoCache value is particularly usaful when declaring multiple configuration properties in a struct or class.
 You can specify which properties need to be save/access from the backend cache or not.
 
 For example:
 ```
 struct Settings {
 var delay: AutoCache<Int>      // need cache
 var title: AutoCache<String>   // need cache
 var brightness: Float          // not cache
 }
 
 var settings = Settings(delay: 11~~"Delay", name: "hello"~~"Title", brightness: 1.0)
 ```
 
 */
public struct AutoCache<V: Cachable> {
    typealias T = V
    let name: String
    
    var value: V {
        set {
            V.cache(value: newValue as! V.T, forKey: name)
        }
        get {
            let v = V.fetchValue(forKey: name) as! V
            return v
        }
    }
    
    func clear() {
        V.clear(forKey: name)
    }
    
    public init(name: String, initial: V? = nil) {
        self.name = name
        if let v = initial {
            V.regist(value: v as! V.T, forKey: name)
        }
    }
}

infix operator ~~
public func ~~ <V>(lhs: V, rhs: String) -> AutoCache<V> {
    let v = AutoCache<V>(name: rhs, initial: lhs)
    return v
}


infix operator <~
public func <~ <V>(lhs: inout AutoCache<V>, rhs: V?) {
    if rhs == nil {
        lhs.clear()
    }
    else {
        lhs.value = rhs!
    }
}

prefix operator %%
public prefix func %% <V>(rhs: AutoCache<V>) -> V {
    return rhs.value
}
