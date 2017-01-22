import Foundation

public class MathService {
    
    // Standard fibonacci sequence
    public class func fibonacci(n: Int) -> Int {
        return fibonacci(n: n, k: 1)
    }
    
    // Fibonacci function where each generation can produce k new offspring (instead of just 1)
    public class func fibonacci(n: Int, k: Int) -> Int{
        
        switch(n){
            case 0:
                return 0
            
            case 1, 2:
                return 1
            
            default :
                break
        }
        
        var a = 1, b = 1, c = 1

        for _ in 2...n-1 {
            c = b
            b = (b + (a * k))
            a = c
        }
        return b
    }
}
