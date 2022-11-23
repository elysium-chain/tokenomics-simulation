import {random} from './random.imba'

export class Generator

	def next base, opt
		let options = opt.gen
		if !options.inited
			options.inited = true
			let init = options..init || 1
			return init

		let change = options..change || 1
		let direction = options..direction || 0
		let minimum = options..minimum || 0
		let maximum = options..maximum || 0

		direction = 0 if Number.isNaN(direction)
		let sign = direction >= 0 ? 1 : -1
		let mult = 0

		if base <= minimum
			mult = 1
		elif maximum and base >= maximum
			mult = -1
		elif direction != 0
			mult = sign * (random(100 + Math.abs(direction)) >= 50 ? 1 : -1)
		else
			mult = random(1) ? 1 : -1
		
		return base * (1 + mult * change / 100)
		