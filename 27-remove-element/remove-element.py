class Solution:
    def removeElement(self, nums: List[int], val: int) -> int:
        if nums == None or len(nums) == 0:
            return 0
        l, r = 0, len(nums)-1
        while l < r:
            while nums[l] != val and l < r:
                l += 1
            while nums[r] == val and r > 0:
                r -= 1
            if l < r:
                nums[l], nums[r] = nums[r], nums[l]
        return l if nums[l] == val else l+1