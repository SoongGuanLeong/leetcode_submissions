class Solution:
    def maximumStrongPairXor(self, nums: List[int]) -> int:
        nums = sorted(nums)
        l = 0
        max_XOR = 0

        for r in range(len(nums)):
            y = nums[r]

            while nums[r] > 2 * nums[l]:
                l += 1

            for i in range(l, r + 1):
                x = nums[i]
                max_XOR = max(max_XOR, x ^ y)

        return max_XOR
