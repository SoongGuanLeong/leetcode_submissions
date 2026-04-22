class Solution:
    def countGoodSubstrings(self, s: str) -> int:
        l = 0
        cnt = 0

        for r in range(2, len(s)):
            substring = s[l:r + 1]

            if len(substring) == len(set(substring)):
                cnt += 1

            l += 1

        return cnt
