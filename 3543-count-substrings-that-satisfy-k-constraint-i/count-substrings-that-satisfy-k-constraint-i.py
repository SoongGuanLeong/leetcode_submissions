class Solution:
    def countKConstraintSubstrings(self, s: str, k: int) -> int:
        l = 0
        total = 0
        cnt0 = 0
        cnt1 = 0

        for r in range(len(s)):
            if s[r] == "0":
                cnt0 += 1
            else:
                cnt1 += 1

            while cnt0 > k and cnt1 > k:
                if s[l] == "0":
                    cnt0 -= 1
                else:
                    cnt1 -= 1
                l += 1

            total += r - l + 1
        return total
