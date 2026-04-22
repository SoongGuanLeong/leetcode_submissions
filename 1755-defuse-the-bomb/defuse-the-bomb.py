class Solution:
    def decrypt(self, code: List[int], k: int) -> List[int]:
        n = len(code)
        results = [0] * n
        window_sum = 0

        if k == 0:
            return results

        if k > 0:
            l, r = 1, k
        else:
            l, r = n - abs(k), n - 1

        for i in range(l, r + 1):
            window_sum += code[i]

        for i in range(len(code)):
            results[i] = window_sum
            window_sum -= code[l % n]
            window_sum += code[(r + 1) % n]
            l += 1
            r += 1

        return results
