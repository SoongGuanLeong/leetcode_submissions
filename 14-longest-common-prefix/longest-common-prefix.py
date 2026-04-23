class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        
        #taking the first item as a prefix
        prefix = strs[0]

        #loop through all of the items in the list
        for string in strs[1:]:
            i=0
            while i<len(string) and i<len(prefix) and prefix[i] == string[i]:
                i+=1
            prefix = prefix[:i]
        
        return prefix