extends Reference
class_name Rand

static func bellbiasi(min_i, max_i, bias_val, weight):
  randomize()
  var weighted_values = Array()
  for _i in weight:
    weighted_values.push_back(rangei(min_i, max_i))

  var norm = float(max_i)
  for val in weighted_values:
    var abs_val = abs(val - bias_val)
    if abs_val < norm:
      norm = val

  var mix = randf()
  return round((norm * (1 - mix)) + (bias_val * mix))

static func belli(min_i, max_i, weight):
  randomize()
  # weight is how likely the middle values are over the outer values as a multiplier (2 is double)
  var rand_total = 0
  for _i in weight:
    rand_total += rangei(min_i, max_i)

  return int(rand_total / weight)

static func rangei(min_i, max_i):
  randomize()
  return ((randi() % (max_i-min_i+1)) + min_i)

# Just used for testing purposes
static func calc_stats():
  var hold_stats = Array()
  for _i in range(5000):
    # var val = rangei(0, 100)
    var val = bellbiasi(0, 100, 30, 2) # Swap for other test function
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

  arr_counts.sort_custom(CustomSorter, "sort_by_first")
  for count in arr_counts:
    print(str(count[0]) + ": " + str(count[1]))

class CustomSorter:
  static func sort_by_first(a, b):
    if int(a[0]) < int(b[0]):
      return true
    return false
