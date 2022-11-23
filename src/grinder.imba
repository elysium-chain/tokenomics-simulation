import {random} from './random'

export class Grinder
	sky = {
		init: 100000000
		pooled: 100000000
		burned: 0
		supply: 0
	}
	ray = {
		init: 100000000
		pooled: 100000000
		burned: 0
		supply: 0
	}
	k = sky.pooled * ray.pooled
	mean = {
		burn: 0
	}
	counter = 0
	volume = 0.05
	rate = 0

	def rewards rays
		# ray.pooled += rays / 10
		# ray.burned += rays
		ray.pooled += mean.burn / 2
		
		let skyout = sky.pooled - k / ray.pooled
		sky.supply += skyout
		sky.pooled -= skyout
		counter++
	
	def fees rays
		ray.burned += rays
		ray.supply -= rays

		mean.burn = (9 * mean.burn + rays) / 10

	def mint
		let need = 31700000 * Math.pow(counter, 1/6)
		let have = ray.supply
		let minting = mean.burn
		if need > have
			minting += (need - have) / 20
		elif need < have
			minting -= (have - need) / 20

		return if minting <= 0
		
		let skys = minting / (1.5 * ray.supply / sky.supply)
		skys = minting / 3 if !skys or Number.isNaN(skys) or !Number.isFinite(skys)
		# console.log skys
		###
		if volume < 0.02
			volume = 0.02
		elif volume > 0.1
			volume = 0.1
		else
			volume += random(1) ? 0.001 : -0.001
		
		let skys = sky.supply * volume
		###

		# sky.skys += skys
		# sky.pooled += sky.burned / sky.init * skys
		# sky.burned += (1 - sky.burned / sky.init) * skys
		sky.burned += skys
		sky.supply -= skys 
		ray.supply += minting
		rate = minting / skys 
