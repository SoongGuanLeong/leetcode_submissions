class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        if len(nums) > 1:
            nums.sort()
            i = 1
            count = 1
            while i < len(nums):
                if nums[i] == nums[i-1]:
                    count += 1
                    if count > len(nums) / 2:
                        return nums[i]
                else:
                    count = 1
                
                i += 1
        else:
            if len(nums) == 1:
                return nums[0]