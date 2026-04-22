class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        l = 0
        window_chars = set()
        max_window = 0

        for r in range(len(s)):
            while s[r] in window_chars:
                window_chars.remove(s[l])
                l += 1
            window_chars.add(s[r])
            max_window = max(max_window, r - l + 1)

        return max_window
