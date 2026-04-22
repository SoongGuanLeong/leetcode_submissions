class Solution:
    def lateFee(self, daysLate: List[int]) -> int:
        return sum(
            1 if d == 1 else
            2 * d if 2 <= d <= 5 else
            3 * d
            for d in daysLate
        )
