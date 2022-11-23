import {Tokenomics} from './model.imba'

global css html
	m: 0 p: 0
	c: #fff
	ff: 'Montserrat' fs: 20px fw: 500 lh: 32px
	bg: #13061A
	p: 0 40px
	body
		m: 0
	h1
		m: 0
	h2
		d: flex fld: column-reverse g: 4px
		fs: 32px lh: 32px fw: 500 tt: uppercase
		m: 0
		span
			fs: 10px lh: 15px fw: 700
			c: #6E5579
	p
		m: 0
	button
		cursor: pointer
		ff: 'Montserrat' fs: 12px lh: 24px fw: 600 tt: uppercase c: #fff
		p: 4px 24px
		bg: transparent
		border-width: 1px
		border-style: solid
		border-image: linear-gradient(to right top, #4E01FF, #FE039B) 1 1 1 1
	input[type="range"]
		-webkit-appearance: none
		w: 100%
		height: 1px
		bg: rgba(255, 255, 255, 0.1)
		bgi: linear-gradient(to right, #FE039A, #4E01FF)
		background-repeat: no-repeat
		&::-webkit-slider-thumb
			-webkit-appearance: none
			cursor: grab
			s: 21px
			rd: 50%
			bd: solid 1px rgba(255,255,255,.05)
			bg: rgba(255,255,255,.1)
			tween: ease 0.2s
			backdrop-filter: blur(10px)
			&:hover
				s: 25px
				bc: rgba(255,255,255,.75)
		&::-webkit-slider-runnable-track
			-webkit-appearance: none
			box-shadow: none
			border: none
			background: transparent
	canvas
		d: block
		bd: none
		ol: none
css .header
	d: flex jc: space-between ai: center
	p: 24px 0
	.actions
		d: flex g: 16px

css .block
	d: flex fld: column g: 40px
	p: 40px
	bd: solid 1px rgba(255,255,255,.05)
	bg: rgba(255,255,255,.05)
	.title
		d: grid gtc: repeat(3, 120px) g: 40px
	.chart
		w: 100% h: 200px
		bg: rgba(255,255,255,.025)

let speed = 1 # speed of generating (from 1 to 1000)
let running = false

let tcns = new Tokenomics!

def next
	return if !running
	tcns.next!

	# call self after some timeout
	let timeout = Math.round(1000 / speed)
	setTimeout(&,timeout) do next!

def reset
	running = false
	tcns = new Tokenomics!

tag App
	css self
		>>> svg
			d: block
			of: visible
			s: 12px 100px
			stroke: #fff
			stroke-width: 2px
			stroke-linecap: round
			fill: none
			line
				stroke-dasharray: 1 4
				animation: dash linear .5s infinite
			@keyframes dash
				from stroke-dashoffset: 4
	<self>
		<.header>
			<label> "{speed} Days per second"
				<input[bgs: {speed*3.333333}% 100%] type='range' bind=speed min=1 max=30>
			<p> "Day: {tcns.#day}"
			<.actions>
				<button @click=(running = true; next!) disabled=running> 'Start'
				<button @click=(running = false) disabled=!running> 'Stop'
				<button @click=(reset!)> 'Reset'
		# <label> 'minimum'
		#	<input bind=tcns.generate.blocks.emptiness.change min=0 max=99>
		# <.section><.block> 
		# 	<h2> "Rate of empty blocks: {tcns.emptiness.percent.toFixed(0)}%"
		# 	<(tcns.#charts.emptiness).chart>
		<.block>
			<.title>
				<h2> "{tcns.blocks.amount.toFixed(0)}"
					<span> 'total blocks'
				<h2> "{tcns.blocks.empty.toFixed(0)}"
					<span> 'empty blocks'
				<h2> "{tcns.blocks.filled.toFixed(0)}"
					<span> 'filled blocks'
			<(tcns.#charts.blocks).chart>
		<svg viewBox="0 0 12 100">
			<line x1="6" x2="6" y1="0" y2="100">
			<path d="M0,94 L6,100 L12,94">
			# <.block>
			# 	<.title>
			# 		<h2> "{tcns.blocks.empty.toFixed(0)}"
			# 			<span> 'empty blocks'
			# 		<h2> "{tcns.emptiness.percent.toFixed(0)}%"
			# 	<(tcns.#charts.empty).chart>
		# <label> "Filled blocks: {tcns.blocks.filled.toFixed(0)}"
		# 	<(tcns.#charts.filled) [w: 300px h:50px]>
		# <label> "Transactions: {tcns.trx.amount.toFixed(0)}, total: {tcns.trx.total.toFixed(0)}"
		# 	<(tcns.#charts.trx) [w: 300px h:50px]>
		# <.block>
		# 	<h2> "{tcns.nodes.amount.toFixed(0)}"
		# 		<span> 'Active nodes'
		# 	<(tcns.#charts.nodes).chart>
		# <label> "Operations per filled block: {tcns.blocks.opers.toFixed(2)}"
		# 	<(tcns.#charts.opers) [w: 300px h:50px]>
		# <label> "Daily rewards: {tcns.nodes.rewards.toFixed(0)} RAYs {tcns.nodes.rewards_sky.toFixed(4)} SKYs"
		# 	<(tcns.#charts.rewards) [w: 300px h:50px]>
		<.block> 
			<h2> "{tcns.nodes.reward.toFixed(4)} RAYs {tcns.nodes.reward_sky.toFixed(4)} SKY"
				<span> 'Reward per validator'
			<(tcns.#charts.reward).chart>
		# <label> "Fee per operation: {tcns.trx.fee.toFixed(8)} RAYs"
		# 	<(tcns.#charts.fee) [w: 300px h:50px]>
		# <label> "Daily fees: {tcns.trx.fees.toFixed(0)} RAYs"
		# 	<(tcns.#charts.fees) [w: 300px h:50px]>
		# <label> "SKY = {tcns.sky.rate.toFixed(2)} RAY"
		# 	<(tcns.#charts.rate) [w: 300px h:50px]>
		<.block>
			<h2> "{tcns.ray.supply.toFixed(4)}"
				<span> 'RAY supply'
			<(tcns.#charts.ray_supply).chart>
		# <label> "SKY supply: {tcns.sky.supply.toFixed(0)}"
		# 	<(tcns.#charts.sky_supply) [w: 300px h:50px]>
		# <label> "SKY daily burn: {tcns.sky.burn.toFixed(2)}"
		# 	<(tcns.#charts.sky_burn) [w: 300px h:50px]>

imba.mount <App>