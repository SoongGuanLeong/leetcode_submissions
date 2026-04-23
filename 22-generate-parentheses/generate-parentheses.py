class Solution:
    def generateParenthesis(self, n: int) -> List[str]:
        result = []

        def backtrack (l,r,path):
            if l == r == n:
                result.append(path)
                return
            
            if l < n:
                backtrack(l+1, r, path + "(")

            if r < l:
                backtrack(l, r+1, path + ")")
            
        backtrack(0,0,"")
        return result

             