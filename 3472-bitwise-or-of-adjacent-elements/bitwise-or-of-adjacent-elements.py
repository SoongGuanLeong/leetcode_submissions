class Solution:
    def orArray(self, nums: List[int]) -> List[int]:
        answer = []
        
        for i in range(len(nums)-1):
            answer.append(nums[i] | nums[i + 1])

        return answer