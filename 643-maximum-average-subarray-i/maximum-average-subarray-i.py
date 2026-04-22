class Solution:
    def findMaxAverage(self, nums: List[int], k: int) -> float:
        l = 0
        window_sum = 0
        max_avg = -10000

        for r in range(len(nums)):
            window_sum += nums[r]

            while r - l + 1 > k:
                window_sum -= nums[l]
                l += 1

            if r - l + 1 == k:
                max_avg = max(max_avg, window_sum / k)
        return max_avg
