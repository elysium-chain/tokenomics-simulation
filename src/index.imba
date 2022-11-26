import {Tokenomics} from './tokenomics.imba'
import {Discord, Twitter, Medium, GitHub, World} from './icons.imba'

import favicon from './logo.png'
let favicon-link = document.querySelector("link[rel~='icon']")
if !favicon-link
	let link = document.createElement("link")
	link.type = "image/png"
	link.rel="icon"
	link.href = favicon.url
	document.head.appendChild(link)

global css html
	m: 0 p: 0
	c: #fff
	ff: 'Montserrat' fs: 20px fw: 500 lh: 32px
	fs: mono
	bg: #13061A
	body
		m: 0
	h1
		d: flex ai: center g: 8px
		ff: 'Roboto Mono'
		fs: 32px lh: 32px fw: 500 tt: uppercase
		m: 0
		span
			ff: 'Montserrat'
			fs: 10px lh: 14px fw: 700
			c: #6E5579
			max-width: 72px
	h2
		zi: 1
		pos: relative
		d: flex fld: column-reverse
		ff: 'Roboto Mono'
		fs: 20px lh: 24px fw: 400 tt: uppercase
		m: 0
		span
			ff: 'Montserrat'
			fs: 10px lh: 16px fw: 700
			c: #6E5579
	p
		m: 0
	button
		ol: none
		cursor: pointer
		ff: 'Montserrat' fs: 12px lh: 24px fw: 600 tt: uppercase c: #fff
		d: flex ai: center jc: center s: 44px
		border-width: 1px
		border-style: solid
		border-image: linear-gradient(to right top, #4E01FF, #FE039B) 1 1 1 1
		bg: linear-gradient(to right top, #4E01FF, #FE039B)
		bgp: -1px -1px
		bgs: 0% 105%
		bgr: no-repeat
		tween: ease 0.2s
		&:hover
			bgs: 105% 105%
		&.active
			bgs: 105% 105%
		&.play, &.next
			>>> svg
				s: 12px
				fill: #fff
		&.reset
			>>> svg
				of: visible
				s: 12px
				stroke: #fff
				stroke-width: 2px
				fill: none
	input[type="range"]
		m: 0 p: 0
		-webkit-appearance: none
		w: 200px
		height: 2px
		bg: rgba(255, 255, 255, 0.1)
		bgi: linear-gradient(to right, #FE039A, #4E01FF)
		background-repeat: no-repeat
		&::-webkit-slider-thumb
			-webkit-appearance: none
			cursor: grab
			s: 20px
			rd: 50%
			bd: solid 1px rgba(255,255,255,.05)
			bg: #FFF
			tween: ease 0.2s
			&:hover
				s: 24px
				bc: rgba(255,255,255,.75)
		&::-webkit-slider-runnable-track
			-webkit-appearance: none
			box-shadow: none
			border: none
			background: transparent
	>>> svg
		zi: 200
		d: block
		pos: relative
		&.arrow
			of: visible
			stroke: #6E5579
			stroke-width: 2px
			stroke-linecap: round
			fill: none
			as: center
			js: center
			s: 40px
			line, .dotted
				stroke-dasharray: 2 4
				animation: dash linear .5s infinite
			&.sky
				stroke: #FFF
			&.ray
				stroke: #FFF
			@keyframes dash
				from stroke-dashoffset: -6
	canvas
		d: block
		bd: none
		ol: none

css .header
	d: grid gtc: auto 1fr 180px auto g: 40px ai: center
	p: 32px 40px
	.logo
		cursor: pointer
		h: 44px
		d: flex g: 16px ai: center
		.symbol
			pos: relative
			img
				h: 44px
				object-fit: cover
				o: 0.35
				&:last-child, &:nth-child(2)
					pos: absolute t: 0 l: 0
					o: 1
					mix-blend-mode: overlay
		.name
			d: flex fld: column g: 8px
			p
			fs: 8px tt: uppercase ls: 5px fw: 700 m: 0 lh: 10px
			c: #6E5579
		img
			d: block
			w: auto
			&.elysium
				h: 12px
				filter: saturate(0.35)
	.icon
		d: flex ai: center jc: center
		s: 44px
		bg: rgba(255,255,255,.05)
		>>> svg
			of: visible
			d: block
			s: 16px
			stroke: #fff
			stroke-width: 2px
			circle stroke-width: 3px
	.actions
		js: end
		d: grid gtc: repeat(3, 44px) g: 16px

css .speed
	pos: relative
	d: flex ai: center g: 16px
	.icon-box
		zi: 100
		&:hover
			& ~ *
				o: 1
				visibility: visible
	.input-container
		zi: 1000
		d: flex ai: center jc: center
		pos: absolute l: 0 t: 0
		o: 0
		visibility: hidden
		tween: ease 0.2s
		&:hover
			zi: 1000
			o: 1
			visibility: visible
		.input-box
			zi: 1000
			d: flex ai: center jc: center g: 16px
			h: 44px p: 0 16px
			bd: solid 1px rgba(255,255,255,.05)
			box-sizing: border-box
			bg: rgba(19, 6, 26, .6)
			backdrop-filter: blur(10px)
			-webkit-backdrop-filter: blur(10px)
			bxs: 0 8px 24px rgba(19, 6, 26, .5)
			origin: 22px 22px
			transform: rotateZ(90deg)
			.plus-minus
				pos: relative
				s: 10px
				&:before
					content: ''
					pos: absolute l: 0 t: 0 r: 0 b: 0 m: auto
					w: 2px
					bg: #6e5579
				&.plus
					&:after
						content: ''
						pos: absolute l: 0 t: 0 r: 0 b: 0 m: auto
						h: 2px
						bg: #6e5579

css .section
	p: 0 40px
	m: auto

css .scheme
	d: grid
	gtc: 1fr 80px 1fr 80px 1fr g: 8px
	p: 40px
	bg: rgba(255,255,255,.05)
	bd: solid 1px rgba(255,255,255,.05)

css .blocks
	zi: 22
	pos: relative
	d: grid gtc: 1fr g: 8px
	&:before
		zi: 0
		pos: absolute
		content: ''
		l: -48px t: 0 r: -48px b: -48px
		# bg: rgba(255,255,255,.025)
		border-width: 1px
		border-style: solid
		border-image: linear-gradient(to right top, #4E01FF, #FE039B) 1 1 1 1

css .block
	# zi: 2
	pos: relative
	d: flex fld: column g: 20px
	p: 20px
	bd: solid 1px rgba(255,255,255,.05)
	bg: rgba(255,255,255,.05)
	&.simple
		bg: none
		bd: none
	&.rainbow
		bd: none
		bg: linear-gradient(to right top, #4E01FF, #FE039B)
		h2 span
			c: rgba(0,0,0,0.4)
		.title .hint
			bd: solid 1px rgba(255,255,255,.15)
			&:before
				c: rgba(255,255,255,.4)
		.chart
			bg: repeating-linear-gradient(to top, rgba(255,255,255,.2) 0px, rgba(255,255,255,0) 1px, rgba(255,255,255,0) 15px)
	.shine
		pos: absolute l: 0 t: 0 r: 0 b: 0
		of: hidden
		border-width: 1px
		border-style: solid
		border-image: linear-gradient(to right top, #4E01FF, #FE039B) 1 1 1 1
		&:before
			content: ''
			pos: absolute l: 120% t: -40px b: -40px
			w: 60px
			bg: rgba(255,255,255,.035)
			transform: rotateZ(30deg)
			filter: blur(10px)
			animation: breathe ease-in-out .5s backwards
			tween: ease .5s
			@keyframes breathe
				from l: -20%
	.title
		pos: relative
		d: flex jc: space-between
		.hint
			pos: relative
			d: flex ai: center jc: center
			s: 40px rd: 100%
			bd: solid 1px rgba(255,255,255,.05)
			box-sizing: border-box
			&:before
				content: '?'
				pos: absolute
				fs: 16px fw: 600 lh: 17px c: #6e5579
			&:hover
				&:before
					c: rgba(255,255,255,1)
				& ~ *
					o: 1
					visibility: visible
					transform: translateY(0px)
					tween: visibility 0s, transform 0.2s, opacity 0.2s
		.hint-text
			zi: 1000
			pos: absolute l: 0 r: 0 t: 100% m: auto mt: 18px
			d: flex
			o: 0
			fs: 12px lh: 20px
			p: 20px
			bd: solid 1px rgba(255,255,255,.05)
			bg: rgba(19, 6, 26, .6)
			transform: translateY(40px)
			visibility: hidden
			tween: visibility 0s 0.2s, transform 0.2s, opacity 0.2s
			backdrop-filter: blur(10px)
			-webkit-backdrop-filter: blur(10px)
			bxs: 0 16px 40px rgba(19, 6, 26, .5)
			&.bottom
				t: auto b: 100% mt: 0 mb: 18px
				transform: translateY(-40px)
		.actions
			d: flex g: 8px ai: start
			.speed
				.input-container
					r: 0 b: 0
					.input-box
						transform: rotateZ(-90deg)
						origin: 50% 50%
						h: 40px
	.chart
		zi: 1
		pos: relative
		w: 100% h: 77px
		# bg: rgba(255,255,255,.025)
		bg: repeating-linear-gradient(to top, rgba(255,255,255,.075) 0px, rgba(255,255,255,0) 1px, rgba(255,255,255,0) 15px)
		# bd: solid 1px rgba(255,255,255,.025)
		# box-sizing: border-box
		# bxs: 0 8px 16px 0 rgba(0,0,0,.1)

css .info
	d: flex fld: column g: 24px
	h2 ta: left

css .grind
	fs: 12px fw: 600 lh: 28px js: center tt: uppercase m: 11px 0 1px 0

css .footer
	d: flex jc: space-between
	p: 32px 40px
	p c: #6E5579
	.social
		d: flex ai: center jc: center g: 32px
		>>> svg
			d: block
			stroke: none
			stroke-linejoin: round
			m: 0
			p: 0
			cursor: pointer
			h: 16px
			fill: #6E5579
			tween: ease 0.2s
			&:hover
				fill: #fff

let speed = 30 # speed of generating (from 1 to 1000)
let trans = 0
let running = false

let tcns = new Tokenomics!
let skyactive = false
let rayactive = false

let ShowSettings = false

def SpaceNum number 
	return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

def next
	return if !running
	tcns.next!

	# call self after some timeout
	let timeout = Math.round(1000 / speed)
	setTimeout(&,timeout) do next!

def reset
	running = false
	tcns = new Tokenomics!

tag Settings
	css self
		cursor: pointer
		d: flex ai: center jc: center
		bd: solid 1px rgba(255, 255, 255, .05)
		box-sizing: border-box
		s: 44px
		&:hover
			>>> svg
				fill: #fff
		&.small
			s: 40px
			rd: 100%
		>>> svg
			d: block
			fill: #6E5579
			s: 14px 16px
			stroke-linecap: round
			tween: ease 0.2s
	def render
		<self>
			<svg viewBox="0 0 14 16">
				<path d="M3 0C2.44769 0 2 0.447716 2 1V2.17071C0.834778 2.58254 0 3.69378 0 5C0 6.30622 0.834778 7.41746 2 7.82929V15C2 15.5523 2.44769 16 3 16C3.55231 16 4 15.5523 4 15V7.82929C5.16522 7.41746 6 6.30622 6 5C6 3.69378 5.16522 2.58254 4 2.17071V1C4 0.447716 3.55231 0 3 0ZM4 5C4 5.55228 3.55231 6 3 6C2.44769 6 2 5.55228 2 5C2 4.44772 2.44769 4 3 4C3.55231 4 4 4.44772 4 5Z">
				<path d="M11 0C10.4477 0 10 0.447716 10 1V8.17071C8.83478 8.58254 8 9.69378 8 11C8 12.3062 8.83478 13.4175 10 13.8293V15C10 15.5523 10.4477 16 11 16C11.5523 16 12 15.5523 12 15V13.8293C13.1652 13.4175 14 12.3062 14 11C14 9.69378 13.1652 8.58254 12 8.17071V1C12 0.447716 11.5523 0 11 0ZM12 11C12 11.5523 11.5523 12 11 12C10.4477 12 10 11.5523 10 11C10 10.4477 10.4477 10 11 10C11.5523 10 12 10.4477 12 11Z">

tag App
	<self>
		<.header>
			<.logo @click=(do window.open("https://elysium-chain.com"))>
				<.symbol>
					<img src='./logo.png'>
					<img src='./logo.png'>
					<img src='./logo.png'>
				<.name>
					<img.elysium src='./elysium.webp'>
					<p> 'tokenomics'
			<h1[js: end]> "{tcns.#day}"
				<span> "days from start"
			<.speed>
				<.icon-box>
					<Settings>
				<.input-container>
					<.input-box>
						<.plus-minus>
						<input[bgs: {speed*3.333333}% 100%] type='range' bind=speed min=1 max=30>
						<.plus-minus.plus>
				<h1> "{speed}"
					<span> "Days per second"
			<.actions>
				<button.next @click=(tcns.next!)>
					<svg viewBox="0 0 12 12">
						<path d="M0,0 L8,6 L0,12">
						<path d="M10,0 L12,0 L12,12 L10,12 Z">
				<button.play.active=(running == true) @click=(running = !running; next!)>
					if running
						<svg viewBox="0 0 12 12">
							<path d="M1,1 L11,1 L11,11 L1,11 Z">
					else
						<svg viewBox="0 0 12 12">
							<path d="M1,0 L11,6 L1,12">
				<button.reset @click=(reset!)>
					<svg viewBox="0 0 12 12">
							<path d="M1,1 L11,1 L11,11 L1,11 L3,9 L3,11">
		<.section>
			<.scheme>
				<.info>
					<h2> tcns.trx.fee_per_trx.toFixed(4)
						<span> 'Fee per transaction in RAY'
					<h2> "{SpaceNum((tcns.sky.init - tcns.sky.burned).toFixed(0))}"
						<span> 'SKY tokens remain'
					<h2> "{tcns.nodes.reward_sky.toFixed(4)}"
						<span> "Validator's daily reward in SKY"
				<.empty>
				# Grinder
				<.blocks[gc: 3 / 4 gr: 1 / 6]>
					<.grind> 'Elysium Grinder'
					# SKY Burned
					<.block>
						<.title>
							<h2> "{SpaceNum(tcns.sky.burned.toFixed(0))} SKY"
								<span> 'SKY Burned'
							<.hint>
							<.hint-text> "Not all SKY is burned. The less SKY remains - the less is the part that is burned.{<br>}For example, if 90% of the initial supply is burned, then Grinder will burn only 10% of the used SKY."
						<(tcns.#charts.sky_burned).chart>
					# SKY Storage
					<.block>
						<.title>
							<h2> "{SpaceNum(tcns.grinder.sky.toFixed(0))} SKY"
								<span> 'SKY Storage'
							<.hint>
							<.hint-text> "The function used to calculate the price of SKY is x * y = k. It means that the Grinder swap price grows exponentially. The more SKY is taken from the storage - the more expensive it becomes in terms of RAY."
						<(tcns.#charts.grinder_sky).chart>
					<div[d: flex js: center]>
						<svg.arrow.sky=skyactive @mouseenter=(skyactive = true) @mouseleave=(skyactive= false) [transform: rotateZ(90deg)]>
							<path.dotted d="M1,20 L39,20">
							<path d="M6,15 L1,20 L6,25">
						<svg.arrow.ray=rayactive @mouseenter=(rayactive = true) @mouseleave=(rayactive= false) [transform: rotateZ(-90deg)]>
							<path.dotted d="M1,20 L39,20">
							<path d="M6,15 L1,20 L6,25">
					# RAY Dealer
					<.block>
						<.title>
							<h2> "{SpaceNum(tcns.grinder.daily_ray.toFixed(0))} RAY"
								<span> 'RAY daily issue'
							<.hint>
							<.hint-text> "The RAY amount printed daily should compensate for fees burned. And raise the supply to meet the target amount if needed."
						<(tcns.#charts.grinder_daily_ray).chart>
				<.empty>
				# Fees
				<.block>
					<.title>
						<h2> "{SpaceNum(tcns.trx.fees.toFixed(0))} RAY"
							<span> 'Fees Burned'
						<.hint>
						<.hint-text> "The more transactions proceeded the less will be the price for each. The daily ceiling for the amount of the fees is 10m."
					<(tcns.#charts.fees).chart>
				<.empty>
				<.empty>
				<.empty>
				<svg.arrow.ray=rayactive @mouseenter=(rayactive = true) @mouseleave=(rayactive= false) [transform: rotateZ(90deg)]>
					<path.dotted d="M1,20 L39,20">
					<path d="M6,15 L1,20 L6,25">
				# SKY Circulation
				<.block.rainbow>
					<.title>
						<h2> "{SpaceNum(tcns.market.sky.toFixed(0))} SKY"
							<span> 'SKY Circulation'
						<.hint>
						<.hint-text> "The amount of SKY on hand. SKY owners could use it to print some RAY."
					<(tcns.#charts.sky_supply).chart>
					if rayactive
						<.shine>
				<div[m: auto]>
					<svg.arrow.ray=rayactive @mouseenter=(rayactive = true) @mouseleave=(rayactive= false) [w: 80px]>
						<path.dotted d="M32,20 L1,20">
						<path.dotted d="M80,20 L48,20">
						<path.dotted d="M80,-140 L63,-140 L63,20">
						<path d="M48,24 L48,16">
						<path d="M32,24 L32,16">
						<path d="M75,15 L80,20 L75,25">
						<path d="M75,-135 L80,-140 L75,-145">
					<svg.arrow.sky=skyactive @mouseenter=(skyactive = true) @mouseleave=(skyactive= false) [w: 80px]>
						<path.dotted d="M1,20 L32,20">
						<path.dotted d="M48,20 L80,20">
						<path d="M48,24 L48,16">
						<path d="M32,24 L32,16">
						<path d="M6,15 L1,20 L6,25">
				<.empty>
				# Transactions
				<.block>
					<.title>
						<h2> "{SpaceNum(tcns.trx.amount.toFixed(0))}"
							<span> 'Transactions'
						<.actions>
							<.speed>
								<.icon-box>
									<Settings.small>
								<.input-container> <.input-box>
									<.plus-minus>
									<input[bgs: {(tcns.trx.gen.direction + 5)*10}% 100%] type='range' bind=tcns.trx.gen.direction min=-5 max=5 step=1>
									<.plus-minus.plus>
							<.hint>
							<.hint-text> "The most crucial parameter that triggers the amount of the fees burned and as a result the amount of RAY to be issued."
					<(tcns.#charts.trx).chart>
				<.empty>
				<.empty>
				<.empty>
				<svg.arrow.ray=rayactive @mouseenter=(rayactive = true) @mouseleave=(rayactive= false) [transform: rotateZ(90deg)]>
					<path.dotted d="M1,20 L39,20">
					<path d="M6,15 L1,20 L6,25">
				# Rewards
				<.block>
					<.title>
						<h2> "{SpaceNum(tcns.nodes.rewards_ray.toFixed(0))} RAY"
							<span> 'Daily Rewards (total)'
						<.hint>
						<.hint-text> "The validators' rewards are calculated in RAY and then are swaped for SKY, which goes to validators."
					<(tcns.#charts.rewards_ray).chart>
				<svg.arrow.sky=skyactive @mouseenter=(skyactive = true) @mouseleave=(skyactive= false) [w: 80px]>
					<path.dotted d="M32,20 L0,20">
					<path.dotted d="M80,20 L48,20">
					<path d="M48,24 L48,16">
					<path d="M32,24 L32,16">
					<path d="M75,15 L80,20 L75,25">
				<svg.arrow.ray=rayactive @mouseenter=(rayactive = true) @mouseleave=(rayactive= false) [w: 80px]>
					<path.dotted d="M32,20 L0,20">
					<path.dotted d="M80,20 L48,20">
					<path d="M48,24 L48,16">
					<path d="M32,24 L32,16">
					<path d="M75,15 L80,20 L75,25">
				# RAY Circulation
				<.block.rainbow>
					<.title>
						<h2> "{SpaceNum(tcns.market.ray.toFixed(0))} RAY"
							<span> 'RAY Circulation'
						<.hint>
						<.hint-text> "The amount of RAY on hand. RAY could be used to pay the transaction fees."
					<(tcns.#charts.ray_supply).chart>
				<svg.arrow.sky=skyactive @mouseenter=(skyactive = true) @mouseleave=(skyactive= false) [transform: rotateZ(90deg) s: 80px]>
					<path.dotted d="M1,40 L80,40">
					<path d="M6,35 L1,40 L6,45">
				<.empty>
				<.empty>
				<.empty>
				<.empty>
				# Blocks
				<.block>
					<.title>
						<h2> "{SpaceNum(tcns.blocks.amount.toFixed(0))}"
							<span> 'Blocks'
						<.hint>
						<.hint-text.bottom> "The amount of generated blocks does not really matter. The rewards are calculated to be equal to fees."
					<(tcns.#charts.blocks).chart>
					if skyactive
						<.shine>
				<.empty>
				# Supply Based Rate
				<.block.simple>
					<.title>
						<h2> "{tcns.market.rate.toFixed(2)}"
							<span> 'SKY/RAY on hand ratio'
						<.hint>
						<.hint-text.bottom> "The rate is calculated as the ratio of SKY and RAY on hand."
					<(tcns.#charts.market_rate).chart>
				<.empty>
				# Market Exchange Rate
				<.block.simple>
					<.title>
						<h2> "{tcns.market.swap.toFixed(2)}"
							<span> 'SKY/RAY market rate'
						<.actions>
							<.speed>
								<.icon-box>
									<Settings.small>
								<.input-container> <.input-box>
									<.plus-minus>
									<input[bgs: {(tcns.market.gen.direction + 5)*10}% 100%] type='range' bind=tcns.market.gen.direction min=-5 max=5 step=1>
									<.plus-minus.plus>
							<.hint>
							<.hint-text.bottom> "The SKY/RAY exchange rate on the market. Could be anything. You can play with its dynamics."
					<(tcns.#charts.market_swap).chart>
			<.footer>
				<p> '© 2022. Elysium Team'
				<.social>
					<a href="https://elysium-chain.com" target="_blank" title="Elysium Main Site"><World>
					<a href="https://discord.gg/elysiumchain" target="_blank" title="Elysium Discord"><Discord>
					<a href="https://twitter.com/elysium_chain" target="_blank" title="Elysium Twitter"><Twitter>
					<a href="https://medium.com/@heap.void" target="_blank" title="Elysium Medium"><Medium>
					<a href="https://github.com/elysium-chain/tokenomics-simulation" target="_blank" title="Elysium GitHub"><GitHub>

imba.mount <App>