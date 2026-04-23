class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        result =[]
        mydict = {}
        for i in range (0,len(nums)):
            mydict[nums[i]] = i
        for j in range(0,len(nums)):
            diff = target - nums[j]
            if diff in mydict and mydict[diff] != j:
                result.append(j)
                result.append(mydict[diff])
                return result
        return result

