//
//  DVT_Store_Map_Details.swift
//  DVT-Store_iOS
//
//  Created by DVT on 4/28/16.
//  Copyright © 2016 DVT. All rights reserved.
//

import Foundation

public class StoreLocationDetails
{
    private var place:String = ""
    private var address:String = ""
    private var lat: Double = 0.0
    private var long:Double = 0.0
    
    
    public init(p:String,a:String,latitude:Double,longitude:Double)
    {
        self.place = p
        self.address = a
        self.lat = latitude
        self.long = longitude
        
    }
    public init()
    {
        
    }
    public func setPlace(place1:String)
    {
        self.place = place1
    }
    public func getPlace() -> String
    {
    return self.place
    }
    public func setAddress(address1:String)
    {
        self.address = address1
    }
    public func getAddress() -> String
    {
        return self.address
    }
    public func setLat(lat1: Double)
    {
        self.lat = lat1
    }
    public func getLat() -> Double
    {
        return self.lat
    }
    public func setLong(long1: Double)
    {
        self.long = long1
    }
    public func getLong() -> Double
    {
        return self.long
    }
    
}