extends Reference
class_name Rand

static func belli(min_i, max_i, height):
  # height is how likely the middle values are over the outer values as a multiplier (2 is double)
  var rand_total = 0
  for _i in height:
    rand_total += rangei(min_i, max_i)

  return int(rand_total / height)

static func rangei(min_i, max_i):
  return ((randi() % (max_i-min_i+1)) + min_i)

static func calc_stats(times):
  var hold_stats = Array()
  for _i in range(times):
    var val = belli(0, 10, 2) # Swap for other test func
    hold_stats.push_back(val)

  return stats(hold_stats)

static func stats(nums):
  var counts = {}
  for num in nums:
    var name = str(num)
    if !counts.has(name):
        counts[name] = 0
    counts[name] += 1

  var arr_counts = Array()
  for count_key in counts.keys():
    arr_counts.push_back([count_key, counts[count_key]])

  for count in arr_counts:#.sort_custom(SortArray, "first"):
    print(str(count[0]) + ": " + str(count[1]))

class SortArray:
  static func first(a, b):
    return int(a[0]) > int(b[0])
