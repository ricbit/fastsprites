import sys
import re

ans = []
for line in sys.stdin:
  match = re.search(r"^(\d{3}) emutime", line)
  if match:
    ans.append(int(match.group(1)))

for i in range(len(ans) // 5):
  l, h, a, lout, eout = ans[i*5:i*5+5]
  pos = h * 256 + l
  print(pos, pos-12345, a, lout, eout)
