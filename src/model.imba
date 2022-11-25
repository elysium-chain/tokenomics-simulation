import {random} from './random.imba'
import {Generator} from './generator'
import {Chart} from './chart'

export class Tokenomics
	# ----------------------
	sky = { 
		init: 100000000
		burned: 0
		dailyburn: 0
	}
	# ----------------------
	ray = {
		burned: 0
		curve: do |day| (43500000 * Math.pow(day, 1/8)/(1 + 590 * Math.pow(Math.E,-day/100))) - 40000
	}
	# ----------------------
	market = {
		ray: 0
		sky: 0
		deviation: 0
		swap: 0
		rate: 0
	}
	# ----------------------
	grinder = {
		sky: 100000000
		ray: 1000
		rate: 0
		daily_sky: 0
		k: 0
	}
	# ----------------------
	assets = {
		amount: 0
		gen:
			init: 10
			minimum: 10
			maximum: 10000000
			direction: 1
			integer: true
	}
	# ----------------------
	emptiness = {
		percent: 0
		gen:
			init: 100
			maximum: 99
			minimum: 1
	}
	# ----------------------
	blocks = {
		empty: 0
		reward: 0
		filled: 0
		opers: 0
		amount: 0
		perasset: 60 * 60 * 24
	}
	# ----------------------
	trx = {
		amount: 0
		total: 0
		fees: 0
		dailyfee: 0
		fee: do |trxs| 10000000 / (trxs + 10000000)
		gen:
			init: 10
			direction: 5
			minimum: 10
			maximum: 40000000
			change: 3
	}
	# ----------------------
	nodes = {
		amount: 0
		welcome: 1000
		reward_ray: 0
		rewards_ray: 0
		reward_sky: 0
		rewards_sky: 0
		gen:
			init: 10
			direction: 1
			minimum: 100
	}

	def constructor
		#day = 0
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
			reward_ray: <Chart>
			rewards_ray: <Chart>
			reward_sky: <Chart>
			rewards_sky: <Chart>
			market_rate: <Chart>
			market_swap: <Chart>
			ray_supply: <Chart>
			sky_supply: <Chart>
			sky_dailyburn: <Chart>
			sky_burned: <Chart>
			fees: <Chart>
			fee: <Chart>
			grinder_rate: <Chart>
			grinder_daily_sky: <Chart>
		grinder.k = grinder.sky * grinder.ray

	def next
		#day++

		# -----------------------------
		# Generate values
		# -----------------------------
		assets.amount = #gen.next(assets.amount, assets)
		emptiness.percent = #gen.next(emptiness.percent, emptiness)
		nodes.amount = #gen.next(nodes.amount, nodes)
		blocks.amount = assets.amount * blocks.perasset * (1 + (random(20) - 10)/100)
		blocks.empty = blocks.amount * emptiness.percent / 100
		blocks.filled = blocks.amount - blocks.empty
		
		market.ray = nodes.amount * nodes.welcome if !market.ray
		
		#charts.assets.add(x:#day, y:assets.amount)
		#charts.emptiness.add(x:#day, y:emptiness.percent)
		#charts.blocks.add(x:#day, y:blocks.amount)
		#charts.empty.add(x:#day, y:blocks.empty)
		#charts.filled.add(x:#day, y:blocks.filled)
		#charts.nodes.add(x:#day, y:nodes.amount)
		

		# -----------------------------
		# calucalate fees
		# -----------------------------
		trx.amount = #gen.next(trx.amount, trx)
		trx.total += trx.amount
		trx.gen.minimum += 500  if trx.gen.minimum < 10000
		let fee = trx.fee(trx.amount)
		trx.dailyfee = fee
		trx.fees = trx.amount * fee
		
		ray.burned += trx.fees
		market.ray -= trx.fees
		console.log "{#day}: fees {trx.fees} are greater then 20% of RAY supply {market.ray}" if trx.fees / market.ray > 0.2
		#charts.trx.add(x:#day, y:trx.amount)
		#charts.fee.add(x:#day, y:trx.dailyfee)
		#charts.fees.add(x:#day, y:trx.fees)
			
		# -----------------------------
		# Minting RAY through Grinder
		# -----------------------------
		grinder.daily_sky = 0
		let rays = trx.fees
		let need = ray.curve(#day)
		let have = market.ray
		rays += (need - have) / 20 if need > have
		rays -= (have - need) / 20 if need < have
		if rays > 0 and market.sky
			let way = random(2) - 1
			market.deviation += random(10) / 100 if way > 0 
			market.deviation -= random(10) / 100 if way < 0
			market.deviation = -0.9 if market.deviation < -0.9 
			# market.deviation += (random(2) - 1)/100
			grinder.daily_sky = rays / (1.1 * (1 + market.deviation) * market.ray / market.sky)
			# "{#day}: sky burned {skys} more then 2% of SKY supply {market.sky}" if skys > 0.02 * market.sky
			# skys = 0.02 * market.sky if #day < 100 and skys > 0.02 * market.sky
			let br = sky.burned / sky.init
			grinder.sky += grinder.daily_sky * br
			sky.burned += grinder.daily_sky * (1 - br)
			sky.dailyburn = grinder.daily_sky * (1 - br)
			market.sky -= grinder.daily_sky
			market.ray += rays
		
		#charts.grinder_daily_sky.add(x:#day, y:grinder.daily_sky)
		#charts.ray_supply.add(x:#day, y:market.ray)
		#charts.sky_supply.add(x:#day, y:market.sky)
		#charts.sky_dailyburn.add(x:#day, y:sky.dailyburn)
		#charts.sky_burned.add(x:#day, y:sky.burned)

		# -----------------------------
		# Calculatig validators rewards
		# -----------------------------
		let rewards_ray = trx.fees + blocks.empty * 0.01
		let rewards_sky = grinder.sky - grinder.k / (grinder.ray + rewards_ray)
		nodes.rewards_ray = rewards_ray
		nodes.reward_ray = rewards_ray / nodes.amount
		nodes.rewards_sky = rewards_sky
		nodes.reward_sky = rewards_sky / nodes.amount
		grinder.ray += rewards_ray
		grinder.sky -= rewards_sky 
		grinder.rate = rewards_ray / rewards_sky
		market.sky += rewards_sky
		market.rate = market.ray / market.sky
		market.swap = (1 + market.deviation) * market.ray / market.sky
		#charts.grinder_rate.add(x:#day, y:grinder.rate)
		#charts.market_rate.add(x:#day, y:market.rate)
		#charts.market_swap.add(x:#day, y:market.swap)
		#charts.reward_ray.add(x:#day, y:nodes.reward_ray)
		#charts.rewards_ray.add(x:#day, y:nodes.rewards_ray)
		if #day > 10
			#charts.reward_sky.add(x:#day, y:nodes.reward_sky)
			#charts.rewards_sky.add(x:#day, y:nodes.rewards_sky)
		
		# -----------------------------
		# The End
		# -----------------------------
		if sky.supply < 0 or ray.supply < 0
			console.log sky
			console.log ray
		imba.commit!
