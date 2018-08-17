//
//  XMLParser.swift
//  XliffParser
//
//  Created by Tudor Ana on 7/31/18.
//  Copyright © 2018 Tudor Ana. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class Parser: NSObject {
    
    static let shared: Parser = {
        let instance = Parser()
        return instance
    }()
    
    var foundCharacters: String = ""
    var count: Int = 0
    var index: Int = 0
    
    var keys: [String] = []
    var values: [String] = []
    
    var output: String = ""
    
    func parse(string: String, type: Int) -> String? {
        
        print(type)
        output = ""
        
        if let xmlData = string.data(using: .utf8) {
            print(xmlData)
            
            let xml = XML.parse(xmlData)
            
            let fileCount: Int = xml["xlf:xliff"].element?.childElements.count ?? 0
            print(fileCount)
            
            for count in 0..<fileCount {
                
                let objectsCount: Int = xml["xlf:xliff"]["xlf:file"][count]["xlf:body"].element?.childElements.count ?? 0
                
                for count2 in 0..<objectsCount {
                    
                    if count2 == 0 {
                        output = String(format: "%@\n\n\n========================================================\n%@\n========================================================\n\n", output, xml["xlf:xliff"]["xlf:file"][count].element?.attributes["original"] ?? "Unknow")
                    }
                
                    if type == 0 {
                        if let key = xml["xlf:xliff"]["xlf:file"][count]["xlf:body"]["xlf:trans-unit"][count2].attributes["id"],
                            let value = xml["xlf:xliff"]["xlf:file"][count]["xlf:body"]["xlf:trans-unit"][count2]["xlf:source"].text,
                            let note = xml["xlf:xliff"]["xlf:file"][count]["xlf:body"]["xlf:trans-unit"][count2]["xlf:note"].text{
                            
                            output = String(format: "%@/* %@ */\n\"%@\" = \"%@\";\n\n", output, note, key, value)

                        }
                    } else {
                        if let key = xml["xlf:xliff"]["xlf:file"][count]["xlf:body"]["xlf:trans-unit"][count2].attributes["id"],
                            let value = xml["xlf:xliff"]["xlf:file"][count]["xlf:body"]["xlf:trans-unit"][count2]["xlf:target"].text,
                            let note = xml["xlf:xliff"]["xlf:file"][count]["xlf:body"]["xlf:trans-unit"][count2]["xlf:source"].text{
                            
                            output = String(format: "%@/* %@ */\n\"%@\" = \"%@\";\n\n", output, note, key, value)
                            
                        }
                    }
                    
                }
            }
            
            
            return output
            
        }

        return nil
    }
}

extension Parser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {

//        print(elementName)
//        print("--------------------------")
//        count += 1
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if !(string.contains("\n") && string.contains(" ")) {
    
            if index % 2 == 0 {
                keys.append(string)
            } else {
                values.append(string)
            }
            
            index += 1
        }
        
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
//        print(count)
//        //if elementName == "xlf:xliff" {
//        if elementName == "xlf:target" {
//            print(foundCharacters)
//            print("--------------------------")
//        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(keys)
    }
}
