class Solution:
    def isPalindrome(self, x: int) -> bool:
        # negative x cannot be a palindrome
        # if we end with 0 we have to begin with 0
        if (x<0 or (x%10 == 0 and x!=0)):
            return False

        revertedN = 0
        while x > revertedN:
            # append the last digit of x
            revertedN = revertedN*10 + x%10
            # change the last digit of x
            x=x//10
        
        return x == revertedN or x == revertedN//10