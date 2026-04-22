class Solution:
    def dietPlanPerformance(self, calories: List[int], k: int, lower: int, upper: int) -> int:
        l = 0
        window_sum = 0
        pts = 0

        for r in range(len(calories)):
            window_sum += calories[r]

            while r - l + 1 > k:
                window_sum -= calories[l]
                l += 1

            if r - l + 1 == k:
                if window_sum < lower:
                    pts -= 1
                elif window_sum > upper:
                    pts += 1

        return pts
