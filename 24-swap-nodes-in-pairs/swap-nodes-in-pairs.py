# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def swapPairs(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if head == None or head.next == None:    # hinted by ex.2 and 3
            return head
        nxt = head.next  #remove 1 store as nxt
        head.next = self.swapPairs(head.next.next) # remove 2, retain 1, loop 3rd++
        nxt.next = head # add back 1
        return nxt



        # head = [1,2,3,4]
        # nxt = [2,3,4]
        # head.next = swapPairs([3,4]) = [4,3]         	head = [3,4]
		#						                        nxt = [4]
		#						                        head.next = []
		#						                        nxt.next = [3]
		#						                        return nxt = [4,3]
        # nxt.next = [1,4,3]
        # return [2,1,4,3]