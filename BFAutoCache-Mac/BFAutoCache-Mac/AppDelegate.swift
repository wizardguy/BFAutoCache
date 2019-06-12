//
//  AppDelegate.swift
//  BFAutoCache-Mac
//
//  Created by Dennis on 2019/6/12.
//  Copyright © 2019 Dennis. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    
    struct MyStruct {
        var i = 0~~"i"
        var s = "Hello"~~"s"
        var d = AutoCache<Double>(name: "d")
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        var i = AutoCache<Int>(name: "ValueInt")
        var s = AutoCache<String>(name: "ValueString")
        var d = 1.0~~"ValueDouble"
        
        i <~ 1
        print(%%i)
        i <~ 2
        print(%%i)
        
        s <~ "Hello"
        print(%%s)
        s <~ "World"
        print(%%s)
        
        print(%%d)
        d <~ 2.0
        print(%%d)
        
        
        var ms = MyStruct()
        
        print(%%ms.i)
        print(%%ms.s)
        print(%%ms.d)
        
        ms.i <~ 1
        ms.s <~ "World"
        ms.d <~ 2.0
        
        print(%%ms.i)
        print(%%ms.s)
        print(%%ms.d)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

