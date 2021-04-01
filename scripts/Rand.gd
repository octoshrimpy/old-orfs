extends Reference
class_name Rand

static func odds_are(odds_range_i): # 1 in x chance to return true
  return rangef(0, odds_range_i) == 0

static func bellbias(min_f, max_f, bias_val, weight):
  randomize()
  var weighted_values = Array()
  for _i in weight:
    weighted_values.push_back(rangef(min_f, max_f))

  var norm = float(max_f)
  for val in weighted_values:
    var abs_val = abs(val - bias_val)
    if abs_val < norm:
      norm = val

  var mix = randf()
  return (norm * (1 - mix)) + (bias_val * mix)

static func bell(min_f, max_f, weight):
  randomize()
  # weight is how likely the middle values are over the outer values as a multiplier (2 is double)
  var rand_total = 0
  for _i in weight:
    rand_total += rangef(min_f, max_f)

  return int(rand_total / weight)

static func rangef(min_f, max_f):
  randomize()
  return randf() * (max_f - min_f) + min_f

static func rangei(min_i, max_i):
  randomize()
  return (randi() % ((max_i - min_i) + 1) + min_i)

# Just used for testing purposes
static func calc_stats():
  var hold_stats = Array()
  for _f in range(10000):
    # var val = rangef(0, 10)
    var val = round(bellbias(0, 10, 7, 2)) # Swap for other test function
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
