//
//  Util+DateConverter.swift
//  Me-cognize
//
//  Created by Hailey on 2023/07/22.
//

import Foundation

extension Util{
    enum DateConverter {
        /**
         포멧별로 날짜를 컨버트 해 줌
         
         - .commaDay :         "yyyy.MM.dd"
         - .dashDayCommaTime :     "yyyy-MM-dd HH:mm:ss"
         - .dashDay :          "yyyy-MM-dd"
         - .dashDayTime :      "yyyy-MM-dd-HH-mm-ss"
         - .weekday :          Language.korean ? "yyyy년 MM월 dd일 EEEE" : "EEEE, MMM dd, yyyy"
         - .engWeekBracket :   "(EEE), MMMM dd, yyyy"
         - .slashDay :         "yyyy/MM/dd"
         - .slashDayTime :     "yyyy/MM/dd HH:mm"
         - .dashmilliSec :     "yyyy-MM-dd HH:mm:ss.S"
         - .daytime:           "EEE, MMM dd hh:mm:ss +zzzz yyyy"
         - .hour:                "HH:mm"
         - .second:         "HH:mm:ss"
         */
        
        enum MyFormat {
            ///"MMM dd, yyyy"
            case dayMMM
            ///"EEEE, MMM dd, yyyy"
            case weekdayMMM
            ///"yyyy MMM dd, EEEE  HH:mm"
            case timeWeekdayMMM
            ///"HH:mm"
            case hour
            
            var formatString : String {
                switch self {
                case .dayMMM:           return "MMM dd, yyyy"
                case .weekdayMMM:       return "EEEE, MMM dd, yyyy"
                case .timeWeekdayMMM:   return "yyyy MMM dd, EEEE  HH:mm"
                case .hour:             return "HH:mm"
                }
            }
        }
        
        static func getNow(_ type: MyFormat) -> String{
            //            Locale.preferredLanguages.first
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = type.formatString
            return formatter.string(from:now)
        }

        static func getDateString(_ type: MyFormat, date: Date) -> String {
            //            Locale.preferredLanguages.first
            let formatter = DateFormatter()
            formatter.dateFormat = type.formatString
            return formatter.string(from:date)
            
        }
        
        static func getDate(_ type: MyFormat, dateString: String?, placeHolder: String = "") -> String{
            //            Locale.preferredLanguages.first
            let formatter = DateFormatter()
            formatter.dateFormat = type.formatString
            guard let _dateString = dateString else {
                return placeHolder
            }
            
            if let _date = formatter.date(from: _dateString) {
                return formatter.string(from: _date)
            } else {
                return placeHolder
            }
        }
        
        static func getDateToString(_ getType: MyFormat, dateString: String?, toType: MyFormat, placeHolder: String = "") -> String {
            //            Locale.preferredLanguages.first
            let formatter = DateFormatter()
            formatter.dateFormat = getType.formatString
            guard let _dateString = dateString else {
                return placeHolder
            }
            
            let toFormatter = DateFormatter()
            toFormatter.dateFormat = toType.formatString
            
            if let _date = formatter.date(from: _dateString) {
                return toFormatter.string(from: _date)
            } else {
                return placeHolder
            }
        }
        
        static func getDate(_ type: MyFormat, timeStamp: Int?, placeHolder: String = "") -> String{
            //            Locale.preferredLanguages.first
            let formatter = DateFormatter()
            formatter.dateFormat = type.formatString
            guard let _timeStamp = timeStamp else {
                return placeHolder
            }
            
            let _date = Date(timeIntervalSince1970: TimeInterval(_timeStamp))
            return _date.toString(dateFormat: type.formatString)
            
        }
        static func getDate(_ type: MyFormat, from str: String) -> Date? {
            //            Locale.preferredLanguages.first
            let formatter = DateFormatter()
            formatter.dateFormat = type.formatString
            //            formatter.locale = Locale(identifier: "ko-KR")
            
            if let _date = formatter.date(from: str) {
                return _date
            } else {
                return nil
            }
        }
    
    }
}

extension Date {
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
    
}
