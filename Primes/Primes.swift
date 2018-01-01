//
//  Primes.swift
//  Primes
//
//  Created by Christian Otkjær on 24/10/2017.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

// https://en.wikipedia.org/wiki/Safe_prime
public let SomeSafePrimes = [5, 7, 11, 23, 47, 59, 83, 107, 167, 179, 227, 263, 347, 359, 383, 467, 479, 503, 563, 587, 719, 839, 863, 887, 983, 1019, 1187, 1283, 1307, 1319, 1367, 1439, 1487, 1523, 1619, 1823, 1907]

public let PrimesLessThan1000 = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997]

private var knownPrimes = Set(PrimesLessThan1000)

extension Int
{
    public var isPrime: Bool
    {
        if knownPrimes.contains(self) { return true }
        
        guard self > 1000 else { return false }
        
        guard self % 2 != 0 else { return false }
        
        guard self % 3 != 0 else { return false }
        
        let limit = Int(floor(sqrt(Double(self))))
        
        for i in Swift.stride(from: 5, to: limit, by: 6)
        {
            if self % i == 0 { return false }
            if self % (i + 2) == 0 { return false }
        }
        
        knownPrimes.insert(self)
        
        return true
    }
    
    public var primeFactorization: [Int]
    {
        guard self < 997*997 else { fatalError("Direct Search Factorization is only for smaller numbers" )}
        
        return Int.directSearchPrimeFactorize(number: self, primeIndex: 0)
    }

    private static func directSearchPrimeFactorize(number: Int, primeIndex: Int) -> [Int]
    {
        guard number > 1 else { return [] }
        
        guard !number.isPrime else { return [number] }
        
        let prime = PrimesLessThan1000[primeIndex]
        
        if number % prime != 0
        {
            return directSearchPrimeFactorize(number: number, primeIndex: primeIndex + 1)
        }

        var remainder = number
        
        var factors: [Int] = []

        while remainder % prime == 0
        {
            factors.append(prime)
            remainder /= prime
        }
        
        return factors + directSearchPrimeFactorize(number: remainder, primeIndex: primeIndex + 1)
    }
}
