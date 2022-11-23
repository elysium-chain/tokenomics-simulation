import {Chart} from './chart'
import {random} from './random'

export class Rate
	data = []
	chart
	initial = 1000 # the initial rate
	dataset = 100 # how many points should be in the data
	change = 1 # percent of change on every step

	def constructor initial, dataset, change
		initial ||= initial
		dataset ||= dataset
		change ||= change
		chart = <Chart>
	
	def fake initial, dataset, change
		initial ||= 100
		
		data = [initial]

		let value = initial
		let step = initial * change / 100
		for i in [0 .. dataset]
			value += random(1) ? step : -step
			data.push value
		chart.points = data
	
	# get view
	#	<Chart points=data>
