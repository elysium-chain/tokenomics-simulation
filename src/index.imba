import {Tokenomics} from './model.imba'

let speed = 1000 # speed of generating (from 1 to 1000)
let stopped = false

let tcns = new Tokenomics!

def next
	return if stopped
	tcns.next!

	# call self after some timeout
	let timeout = Math.round(1000 / speed)
	setTimeout(&,timeout) do next!

def reset
	stopped = true
	tcns = new Tokenomics!

tag App
	<self>
		# <label> 'speed'
		#	<input bind=speed min=1 max=1000>
		<p> "Day: {tcns.#day}"
		# <label> 'minimum'
		#	<input bind=tcns.generate.blocks.emptiness.change min=0 max=99>
		<label> "Rate of empty blocks: {tcns.emptiness.percent.toFixed(0)}%"
			<(tcns.#charts.emptiness) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "Blocks generated: {tcns.blocks.amount.toFixed(0)}"
			<(tcns.#charts.blocks) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "Empty blocks: {tcns.blocks.empty.toFixed(0)}"
			<(tcns.#charts.empty) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "Filled blocks: {tcns.blocks.filled.toFixed(0)}"
			<(tcns.#charts.filled) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "Transactions: {tcns.trx.amount.toFixed(0)}, total: {tcns.trx.total.toFixed(0)}"
			<(tcns.#charts.trx) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "Nodes: {tcns.nodes.amount.toFixed(0)}"
			<(tcns.#charts.nodes) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "Operations per filled block: {tcns.blocks.opers.toFixed(2)}"
			<(tcns.#charts.opers) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "Daily rewards: {tcns.nodes.rewards.toFixed(0)} RAYs {tcns.nodes.rewards_sky.toFixed(4)} SKYs"
			<(tcns.#charts.rewards) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "Reward per validator: {tcns.nodes.reward.toFixed(0)} RAYs {tcns.nodes.reward_sky.toFixed(6)} SKYs"
			<(tcns.#charts.reward) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "Fee per operation: {tcns.trx.fee.toFixed(8)} RAYs"
			<(tcns.#charts.fee) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "Daily fees: {tcns.trx.fees.toFixed(0)} RAYs"
			<(tcns.#charts.fees) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "SKY = {tcns.sky.rate.toFixed(2)} RAY"
			<(tcns.#charts.rate) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "RAY supply: {tcns.ray.supply.toFixed(0)}"
			<(tcns.#charts.ray_supply) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "SKY supply: {tcns.sky.supply.toFixed(0)}"
			<(tcns.#charts.sky_supply) [w: 300px h:50px bd: 1px solid black d:block]>
		<label> "SKY daily burn: {tcns.sky.burn.toFixed(2)}"
			<(tcns.#charts.sky_burn) [w: 300px h:50px bd: 1px solid black d:block]>
		<button [d:block] @click=(stopped = false; next!)> 'Start'
		<button [d:block] @click=(stopped = true)> 'Stop'
		<button [d:block] @click=(reset!)> 'Reset'

imba.mount <App>