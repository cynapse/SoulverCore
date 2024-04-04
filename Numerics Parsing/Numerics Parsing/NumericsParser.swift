//
//  NumericsParser.swift
//  Numerics Parsing
//
//  Created by Zac Cohan on 5/4/2024.
//

import Foundation
import SoulverCore

typealias ParsedData = (number: Decimal, date: Date)

class NumericsParser {
    
    class func parse(expression: String) -> ParsedData? {
        
        /// Grab the standard SoulverCore engine customization
        var customization = EngineCustomization.standard
                
        /// We're expecting a date in the expression, so by setting this flag to true, SoulverCore will be optimized for date seeking in ambiguous situations
        customization.featureFlags.seeksFutureDate = true
        
        /// Create a standard calculator
        let calculator = Calculator(customization: customization)
        
        // Evaluate the expression
        let calculationResult = calculator.calculate(expression)
        
        /// Get a list of tokens parsed from the expression (this should never fail)
        guard let parsedExpression = calculationResult.parsedExpression else {
            return nil
        }
        
        /// Grab the last decimal number in the expression
        var number = parsedExpression.lastToken(ofType: .number)?.decimalValue
        
        /// Grab the last datestamp in the expression, and extract its date object
        var date = parsedExpression.lastToken(ofType: .datestamp)?.datestampValue?.date
        
        /// The user might have used a natural language function, like "3 weeks ago" instead of a date. If this is the last token in the expression, then the result will be the result of this function, so we can get the date from the result of the calculation instead
        if date == nil {
            date = calculationResult.evaluationResult.datestampValue?.date
        }
        
        /// Numerics supports numbers that are considered comments by SoulverCore
        if number == nil {
            number = parsedExpression.lastCommentNumber
        }
        
        /// If we've found both a number and a date, the parse was succesful
        if let number, let date {
            return (number, date)
        }
        
        /// No data found for this query
        return nil
    }
    
}

private extension TokenList {
    
    /// SoulverCore interprets "20apples" as a comment, rather than a number, however the 20 and the apples will be separate tokens
    /// We can loop through the word comment tokens, and see if a number can be extracted from any of them
    var lastCommentNumber: Decimal? {
        for token in self.tokensOfType(.wordComment).reversed() {
            if let decimalValue = token.stringValue.find(.number) {
                return decimalValue
            }
        }
        
        return nil
    }
    
}
