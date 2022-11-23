import { assert } from 'chai'
import {Generator} from './generator'
import {Chart} from './chart'

export class Tokenomics
	def constructor
		sky =
			init: 100000000
			pooled: 100000000
			burned: 0
			supply: 0
			rate: 0
			burn: 0
		ray =
			muti: 31700000
			pooled: 1000
			burned: 0
			supply: 0
			drain: 0
			supply_mean: 0
		assets = 
			amount: 0
			gen :
				init: 10
				minimum: 10
				maximum: 10000000
				direction: 1
				integer: true
		emptiness =
			percent: 0 # the percent of empty blocks during current day
			gen :
				init: 100
				maximum: 100
		blocks =
			empty: 0 # the number of empty blocks during current day
			reward: 0
			filled: 0 # the number of filled blocks
			opers: 0 # the mean amount of operations in filled blocks
			amount: 0 # total amount of blocks
			perasset: 60 * 60 * 24
			# gen :
			#	init: 60 * 60 * 24
			#	direction: 1
			#	minimum: 60 * 60 * 24
		trx =
			multi: 10000000
			amount: 0 # daily amount of transations
			total: 0 # total amount of transations
			fees: 0 # daily amount of fees
			fee: 0 # cost of a transaction
			gen :
				init: 100000
				direction: 5
				minimum: 1000
				maximum: 10000000
				change: 3
		nodes =
			amount: 0 # total amount of nodes
			reward: 0 # the mean reward per node
			rewards: 0 # total amount of validator rewards
			reward_sky: 0 # the mean reward per node
			rewards_sky: 0 # total amount of validator rewards
			gen :
				init: 1000
				direction: 1
				minimum: 100

		#day = 0
		#k = sky.pooled * ray.pooled
		#gen = new Generator!

		#charts =
			assets: <Chart>
			emptiness: <Chart>
			blocks: <Chart>
			empty: <Chart>
			filled: <Chart>
			trx: <Chart>
			nodes: <Chart>
			opers: <Chart>
			reward: <Chart>
			rewards: <Chart>
			rate: <Chart>
			ray_supply: <Chart>
			sky_supply: <Chart>
			sky_burn: <Chart>
			fees: <Chart>
			fee: <Chart>

	def next
		# generate the assets
		assets.amount = #gen.next(assets.amount, assets)
		#charts.assets.add(x:#day, y:assets.amount)

		# generate the percent of empty blocks
		emptiness.percent = #gen.next(emptiness.percent, emptiness)
		#charts.emptiness.add(x:#day, y:emptiness.percent)
		
		# generate the total amount of blocks
		# blocks.amount = #gen.next(blocks.amount, blocks)
		# #charts.blocks.add(x:#day, y:blocks.amount)
		blocks.amount = assets.amount * blocks.perasset
		#charts.blocks.add(x:#day, y:blocks.amount)

		# calculate the amount of empty blocks
		blocks.empty = blocks.amount * emptiness.percent / 100
		#charts.empty.add(x:#day, y:blocks.empty)

		# calculate the amount of filled blocks
		blocks.filled = blocks.amount - blocks.empty
		#charts.filled.add(x:#day, y:blocks.filled)

		# generate nodes
		nodes.amount = #gen.next(nodes.amount, nodes)
		#charts.nodes.add(x:#day, y:nodes.amount)
		ray.supply = nodes.amount * 10 if !ray.supply # every new validator get 10 RAY bonus
		
		# generate trx
		trx.amount = #gen.next(trx.amount, trx)
		# trx.fee = 1
		trx.fee = trx.multi / (trx.amount + trx.multi) # the more trasnsactions we have the less is the fee
		trx.fee = 0.001 if trx.fee < 0.001
		trx.fees = trx.amount * trx.fee
		# trx.amount = ray.supply / 2 if trx.amount > ray.supply # not likely that half of RAY will be use for trs durint the day
		trx.total += trx.amount
		ray.burned += trx.fees
		ray.supply -= trx.fees
		ray.drain = (9 * ray.drain + trx.fees) / 10
		#charts.trx.add(x:#day, y:trx.amount)
		#charts.fee.add(x:#day, y:trx.fee)
		#charts.fees.add(x:#day, y:trx.fees)
			
		# calculate the amount of operatons per filled block
		blocks.opers = trx.amount / blocks.filled
		#charts.opers.add(x:#day, y:nodes.amount)

		# calculate the amount of validators rewards
		# nodes.rewards = blocks.filled + blocks.empty * 0.01
		# nodes.rewards = trx.amount / 2 + blocks.empty * 0.01
		###
		nodes.rewards = trx.fees + blocks.empty * 0.01
		nodes.reward = nodes.rewards / nodes.amount
		ray.pooled += nodes.rewards
		nodes.rewards_sky = sky.pooled - #k / ray.pooled
		nodes.reward_sky = nodes.rewards_sky / nodes.amount
		sky.supply += sky.pooled - #k / ray.pooled
		sky.pooled -= sky.pooled - #k / ray.pooled
		###
		blocks.reward = (sky.init - sky.burned) / sky.init / 2
		nodes.rewards_sky = blocks.amount * blocks.reward
		nodes.reward_sky = nodes.rewards_sky / nodes.amount
		nodes.rewards = nodes.rewards_sky * ray.supply / sky.supply
		nodes.reward = nodes.reward_sky * ray.supply / sky.supply
		sky.pooled -= nodes.rewards_sky * 2
		sky.supply += nodes.rewards_sky
		sky.burned += nodes.rewards_sky
		#charts.reward.add(x:#day, y:nodes.reward_sky)
		#charts.rewards.add(x:#day, y:nodes.rewards_sky)

		# minting through Grinder
		let need = ray.muti * Math.pow(#day, 1/6) # how many RAYs do we need today
		let have = ray.supply # how many RAYs do we actially have
		let minting = ray.drain # let's mint to close the daily drain
		if need > have
			minting += (need - have) / 20
		elif need < have
			minting -= (have - need) / 20

		if minting > 0
			let skys = minting / (1.1 * ray.supply / sky.supply) # let's mint using the rate higher than the market
			skys = 0.02 * sky.supply if #day < 100 and skys > 0.02 * sky.supply
			# skys = minting / 10 if !skys or Number.isNaN(skys) or !Number.isFinite(skys)
			###
			if sky.burned / sky.init > 0.98
				let r = (sky.burned / sky.init - 0.98) / 0.01
				sky.pooled += skys * r
				sky.burned += skys * (1 - r)
			else
				sky.burned += skys
			###
			let r = sky.burned / sky.init
			sky.pooled += skys * r
			sky.burned += skys * (1 - r)

			sky.supply -= skys 
			sky.burn = (9 * sky.burn + skys) / 10
			# sky.rate = ray.supply / (sky.init - sky.burned)
			# sky.rate = minting / skys
			sky.rate = ray.supply / sky.supply
			ray.supply += minting
			ray.supply_mean = (9 * ray.supply_mean + ray.supply) / 10
			#charts.rate.add(x:#day, y:sky.rate)
			#charts.ray_supply.add(x:#day, y:ray.supply_mean)
			#charts.sky_supply.add(x:#day, y:sky.supply)
			#charts.sky_burn.add(x:#day, y:sky.burn)

		if sky.supply < 0
			console.log sky
			console.log ray

		# increase the day
		#day++
		# update the interface
		imba.commit!
