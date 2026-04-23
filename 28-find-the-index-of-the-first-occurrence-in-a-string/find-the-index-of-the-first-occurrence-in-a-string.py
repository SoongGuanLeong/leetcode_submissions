class Solution:
    def strStr(self, haystack: str, needle: str) -> int:
        if len(haystack)==0 or len(haystack)<len(needle):
            return -1
        
        count = 0
        for i in range(len(haystack)):
            if haystack[i:i+len(needle)]!=needle:
                count += 1
            elif haystack[i:i+len(needle)]==needle:
                return count
        if (count+1) > len(haystack):
            return -1
        else:
            return count-1