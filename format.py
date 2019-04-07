import sys
import re

for line in sys.stdin:
  match = re.match(r"^\s*(\w+):", line)
  if match:
    print("%s:" % match.group(1))
    continue
  match = re.match(r"^\s+(\w+)\s*(?:([^,\s]+)\s*(?:(?:,\s*(.+))|[^,\s](.+))?)?$", line)
  if match:
    second = ""
    if match.group(2):
      if match.group(3):
        second = "%s, %s" % (match.group(2), match.group(3))
      elif match.group(4):
        second = "%s %s" % (match.group(2), match.group(4))
      else:
        second = match.group(2)
    comment = ""
    #if match.group(5):
    #  comment = match.group(5)
    print("    %-4s %-20s &%s" % (match.group(1), second, comment))
    continue
  print(line.strip('\n'))
