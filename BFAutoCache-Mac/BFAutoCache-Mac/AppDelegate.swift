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
        print(%%i) // 0
        
        var ii = AutoCache<Int>(name: "ValueInitialInt", initial: -1)
        print(%%ii) // 1st time: -1 ; Otherwise: 123
        
        ii<~123
        print(%%ii) // 123
        
        var s = AutoCache<String>(name: "ValueString")
        print(%%s) // ""
        
        var d = 1.0~~"ValueDouble"
        print(%%d) // 1.0
        
        i <~ 1
        print(%%i) // 1
        i <~ 2
        print(%%i) // 2
        
        print(%%s) // ""
        s <~ "World"
        print(%%s) // World
        
        d <~ 2.0
        print(%%d) // 2.0
        
        
        var ms = MyStruct()
        
        print(%%ms.i) // 0
        print(%%ms.s) // Hello
        print(%%ms.d) // 0.0
        
        ms.i <~ 1
        ms.s <~ "World"
        ms.d <~ 2.0
        
        print(%%ms.i) // 1
        print(%%ms.s) // World
        print(%%ms.d) // 2.0
        
        i <~ nil
        s <~ nil
        d <~ nil

        ms.i <~ nil
        ms.s <~ nil
        ms.d <~ nil
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

