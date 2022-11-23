export tag GrinderChart < canvas
	width = 0
	height = 0
	step = 100000000
	scaleX = 50
	scaleY = 50

	def mount
		width = self.clientWidth
		height = self.clientHeight
	
	def draw options
		let ctx = self.getContext("2d")
		ctx.clearRect(0, 0, width, height) 

		const axisX = 0
		const axisY = height

		ctx.font = "9px Arial"
		ctx.textAlign = 'left'
		ctx.textBaseline = 'top'

		ctx.beginPath!
		ctx.strokeStyle = '#f5f0e8'

		for i in [0 .. width]
			i += scaleX
			ctx.moveTo(i,0)
			ctx.lineTo(i,height)
			# ctx.fillText(Math.round((i - axisX) / scaleX).toFixed(0), i + 3, axisY + 3)

		for i in [0 .. height]
			i += scaleY
			let k = height - i
			ctx.moveTo(0,k)
			ctx.lineTo(width,k)
			# ctx.fillText(Math.round((axisY - k) / scaleY).toFixed(0), axisX + 3, k - 8)

		ctx.stroke!
		ctx.closePath!

		
		###
		ctx.beginPath!
		ctx.strokeStyle = '#000000'
		ctx.moveTo(axisX,0)
		ctx.lineTo(axisX,height)
		ctx.moveTo(0,axisY)
		ctx.lineTo(width,axisY)
		ctx.stroke!
		ctx.closePath!
		###

		ctx.beginPath!
		ctx.strokeStyle = '#393939'
		for i in [0 .. width]
			let x = (i - axisX) / scaleX
			let y = 1 / x
			ctx.lineTo(x * scaleX + axisX, axisY - y * scaleY)
		ctx.stroke!
		ctx.closePath!

		ctx.beginPath!
		if options..dots..length
			for dot in options.dots
				ctx.arc(dot.x / step * scaleX + axisX, axisY - dot.y / step * scaleY , 3, 0, 2 * Math.PI)
			ctx.fillStyle = 'green'
			ctx.fill!
			# console.log "minY: {minY}, maxY:{maxY}, minX:{minX}, {maxX}"
		ctx.stroke!
		ctx.closePath!

	def render
		<self>