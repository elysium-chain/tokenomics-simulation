import {GrinderChart} from './grinderchart'
import {Chart} from './chart'
import {Generator} from './generator.imba'
import {Grinder} from './grinder.imba'

import {Tokenomics} from './model.imba'

let tncs = new Tokenomics!
# tncs.next!

let blocks = new Generator({min:2, dir:1})
let trx = new Generator({min:1, dir:5, vola:10})
let blocksChart = <Chart>
let trxChart = <Chart>
let SKYChart = <Chart>
let RAYChart = <Chart>
let RAYSKYChart = <Chart>
let RAYSKYMintChart = <Chart>

let grinder = new Grinder!
let grinderChart = <GrinderChart>

let speed = 1000 # speed of generating (from 1 to 1000)
let stopped = false

def next
	return if stopped
	blocks.next!
	# trx.next!
	trx.next(0.1 * grinder.ray.supply)
	grinder.rewards(blocks.current)
	grinder.fees(trx.current)
	grinder.mint!
	blocksChart.points.push({x:blocks.counter, y:blocks.current})
	blocksChart.draw()
	trxChart.points.push({x:trx.counter, y:trx.current})
	trxChart.draw()
	SKYChart.points.push({x:blocks.counter, y:grinder.sky.supply})
	SKYChart.draw()
	RAYChart.points.push({x:blocks.counter, y:grinder.ray.supply})
	RAYChart.draw()
	RAYSKYChart.points.push({x:blocks.counter, y:grinder.ray.supply / grinder.sky.supply})
	RAYSKYChart.draw()
	RAYSKYMintChart.points.push({x:blocks.counter, y:grinder.rate})
	RAYSKYMintChart.draw()

	
	
	
	# grinderChart.points = grinder.data
	# let dots = [{x: grinder.ray.pooled, y: grinder.sky.pooled}]
	grinderChart.draw({dots: [{x:grinder.ray.pooled, y:grinder.sky.pooled}]})

	let timeout = Math.round(1000 / speed)
	setTimeout(&,timeout) do next!

tag App
	<self>
		<label> 'speed'
			<input bind=speed min=1 max=1000>
		<p> "Day: {blocks.counter}"
		<p> 'Block generation'
		<label> 'blocks per second (min)'
			<input bind=blocks.minimum min=-10 max=10>
		<label> 'block directon'
			<input bind=blocks.direction min=-10 max=10>
		<label> 'block change (%)'
			<input bind=blocks.change min=-10 max=10>
		<(blocksChart) [w: 300px h:150px bd: 1px solid black d:block]>
		<p> "Total blocks: {blocks.total}"
		<(grinderChart) [w: 300px h:300px bd: 1px solid black]>
		<button @click=(grinderChart.scaleX += 5; grinderChart.scaleY += 5)> '+'
		<button @click=(grinderChart.scaleX -= 5; grinderChart.scaleY -= 5)> '-'
		<p> "SKY supply: {grinder.sky.supply.toFixed(0)} burned: {grinder.sky.burned.toFixed(0)}"
		<(SKYChart) [w: 300px h:150px bd: 1px solid black d:block]>
		<p> "RAY supply: {grinder.ray.supply.toFixed(0)}"
		<(RAYChart) [w: 300px h:150px bd: 1px solid black d:block]>
		<p> 'Transaction generation'
		<label> 'trx per second (min)'
			<input bind=trx.minimum min=-10 max=10>
		<label> 'trx directon'
			<input bind=trx.direction min=-10 max=10>
		<label> 'trx change (%)'
			<input bind=trx.change min=-10 max=10>
		<(trxChart) [w: 300px h:150px bd: 1px solid black d:block]>
		<p> "Total transactions: {trx.total}"
		<p> "RAYs per SKY: {grinder.ray.supply / grinder.sky.supply}"
		<(RAYSKYChart) [w: 300px h:150px bd: 1px solid black d:block]>
		<p> "RAYs per SKY in Grinder: {grinder.rate}"
		<(RAYSKYMintChart) [w: 300px h:150px bd: 1px solid black d:block]>
		<button [d:block] @click=(stopped = false; next!)> 'Start'
		<button [d:block] @click=(stopped = true)> 'Stop'

imba.mount <App>