class Solution:
    def findLHS(self, nums: List[int]) -> int:
        nums = sorted(nums)

        l = 0
        max_window = 0

        for r in range(len(nums)):

            while nums[r] - nums[l] > 1:
                l += 1

            if nums[r] - nums[l] == 1:
                max_window = max(max_window, r - l + 1)

        return max_window
