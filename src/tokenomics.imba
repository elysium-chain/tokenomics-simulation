import {Chart} from './chart.imba'

# ----------------------
# Random number genrator
# ----------------------
let seed = Date.now! % 1000
def random(max = 9, min = 0)
	seed += Date.now! % 10 + 1
	let x = Math.abs(Math.sin(seed)) * 10000000
	x -= Math.floor(x)
	return Math.floor(x * (max + 1 - min) + min)

# ----------------------
# time series generator
# ----------------------
def generate base, opt
	let options = opt.gen
	if !options.inited
		options.inited = true
		let init = options..init || 1
		return init

	let change = options..change || 1
	let direction = options..direction || 0
	let minimum = options..minimum || 0
	let maximum = options..maximum || 0
	let integer = options..integer || false

	direction = 0 if Number.isNaN(direction)
	direction *= 4
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
	
	let chg = base * mult * change / 100
	if integer
		if Math.abs(chg) < 1 then chg = Math.sign(chg) * 1
		chg = Math.round(chg)
	return base + chg

# ----------------------
# Model of Tokenomics
# ----------------------
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
		swap: 1
		rate: 0
		gen:
			init: 0
			inited: true
			minimum: 0
			maximum: 1000000
			direction: 1
			change: 3
	}
	# ----------------------
	grinder = {
		sky: 100000000
		ray: 10000000
		rate: 0
		daily_sky: 0
		daily_ray: 0
		k: 0
	}
	# ----------------------
	assets = {
		amount: 0
		gen:
			init: 10
			minimum: 10
			maximum: 10000000
			direction: 0.5
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
		fee_per_trx: 0
		fee: do |trxs| 10000000 / (trxs + 10000000)
		gen:
			init: 1000
			direction: 5
			minimum: 1000
			maximum: 100000000
			change: 5
			integer: true
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
			direction: 0.5
			minimum: 100
	}

	def constructor
		#day = 0
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
			ray_supply: <Chart line='#fff'>
			sky_supply: <Chart line='#fff'>
			sky_dailyburn: <Chart>
			sky_burned: <Chart>
			fees: <Chart>
			fee: <Chart>
			grinder_rate: <Chart>
			grinder_daily_sky: <Chart>
			grinder_daily_ray: <Chart>
			grinder_sky: <Chart>
		grinder.k = grinder.sky * grinder.ray

	def next
		#day++

		# -----------------------------
		# Generate values
		# -----------------------------
		assets.amount = generate(assets.amount, assets)
		emptiness.percent = generate(emptiness.percent, emptiness)
		nodes.amount = generate(nodes.amount, nodes)
		market.swap = generate(market.swap, market) if #day > 20
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
		# trx.gen.maximum = market.ray /30
		trx.amount = generate(trx.amount, trx)
		trx.gen.direction = 0 if trx.amount > 40000000
		trx.total += trx.amount
		# trx.gen.minimum += 500  if trx.gen.minimum < 10000
		let fee = trx.fee(trx.amount)
		trx.fee_per_trx = fee
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
		grinder.daily_ray = trx.fees
		let need = ray.curve(#day)
		let have = market.ray
		grinder.daily_ray += (need - have) / 20 if need > have
		grinder.daily_ray -= (have - need) / 20 if need < have
		grinder.daily_sky = grinder.daily_ray / (1.1 * market.swap)
		if grinder.daily_sky > market.sky * 0.01
			grinder.daily_sky = market.sky * 0.01
		if grinder.daily_ray > 0
			let br = sky.burned / sky.init
			grinder.sky += grinder.daily_sky * br
			sky.burned += grinder.daily_sky * (1 - br)
			sky.dailyburn = grinder.daily_sky * (1 - br)
			market.sky -= grinder.daily_sky
			market.ray += grinder.daily_ray
		
		#charts.grinder_daily_sky.add(x:#day, y:grinder.daily_sky)
		#charts.grinder_daily_ray.add(x:#day, y:grinder.daily_ray)
		#charts.ray_supply.add(x:#day, y:market.ray)
		#charts.sky_supply.add(x:#day, y:market.sky)
		#charts.sky_dailyburn.add(x:#day, y:sky.dailyburn)
		#charts.sky_burned.add(x:#day, y:sky.burned)

		# -----------------------------
		# Calculatig validators rewards
		# -----------------------------
		let rewards_ray = trx.fees # + blocks.empty * 0.01
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
		market.swap = market.rate if #day <= 20
		#charts.grinder_rate.add(x:#day, y:grinder.rate)
		#charts.reward_ray.add(x:#day, y:nodes.reward_ray)
		#charts.rewards_ray.add(x:#day, y:nodes.rewards_ray)
		if #day > 10
			#charts.reward_sky.add(x:#day, y:nodes.reward_sky)
			#charts.rewards_sky.add(x:#day, y:nodes.rewards_sky)
			#charts.grinder_sky.add(x:#day, y:grinder.sky)
			#charts.market_rate.add(x:#day, y:market.rate)
			#charts.market_swap.add(x:#day, y:market.swap)
		
		# -----------------------------
		# The End
		# -----------------------------
		if sky.supply < 0 or ray.supply < 0
			console.log sky
			console.log ray
		imba.commit!
