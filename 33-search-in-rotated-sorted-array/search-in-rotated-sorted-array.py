class Solution:
    def search(self, nums: List[int], target: int) -> int:
        # target, nums, lo, hi
        lo, hi = 0, len(nums) - 1

        while lo <= hi:
            mid = lo + (hi - lo) // 2

            if nums[mid] == target:
                return mid
            elif nums[mid] >= nums[lo]: # left half is sorted
                if target >= nums[lo] and target < nums[mid]: # target in left half
                    hi = mid - 1
                else: # target in right half
                    lo = mid + 1
            else: # right half is sorted
                if target <= nums[hi] and target > nums[mid]: # target in right half
                    lo = mid + 1
                else:
                    hi = mid - 1
        return -1 # error if nth is  returned



        