class Solution:
    def romanToInt(self, s: str) -> int:
        roman = {
            "I":1,
            "V":5,
            "X":10,
            "L":50,
            "C":100,
            "D":500,
            "M":1000,       
            "IV":4,
            "IX":9,
            "XL":40,
            "XC":90,
            "CD":400,
            "CM":900
        }

        currentsum = 0
        i = 0
        while i<len(s):

            if i<(len(s)-1):

                double = s[i:i+2]

                # check if this is the length-2 symbol case.
                if double in roman:
                    currentsum += roman[double]
                    i+=2
                    continue
            
            #otherwise it must be the length-1 symbol case
            single = s[i:i+1]
            currentsum += roman[single]
            i+=1
        
        return currentsum