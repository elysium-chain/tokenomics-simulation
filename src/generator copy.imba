import {random} from './random.imba'

export class Generator
	minimum # the minimum amount generated per second
	current # the current amount generating per day
	change # percent of change in one day
	step # the amount of one change
	direction # where is headed (from -10 to 10)
	total = 0 # total generated
	counter = 0 # total steps made

	def minday
		minimum * 60 * 60 * 24

	def constructor options
		minimum = options..min || 1
		direction = options..dir || 0
		change = options..vola || 1
		current = minday!
		# step = Math.round(minday! * change / 100)

	def next limit
		step = Math.round(current * change / 100)
		# step = 1 if !step

		let sign = 1
		if direction < 0 then sign = -1
		if direction < -10 then direction = -10
		if direction > 10 then direction = 10

		if Number.isNaN(direction)
			direction = 0

		if current <= minday!
			current += step
		elif direction != 0
			current += sign * (random(100 + Math.abs(direction)) >= 50 ? step : -step)
		else
			current += random(1) ? step : -step
		
		current = limit if limit and current > limit 
		total += current
		# data.push {x:counter, y:current}
		counter++
		imba.commit!