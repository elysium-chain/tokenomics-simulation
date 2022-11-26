export tag Chart < canvas
	width = 0
	height = 0
	line = '#FF049F'
	minY
	maxY
	minX
	maxX
	points = []
	ctx
	mounted = false

	def mount
		mounted = true
		width = self.clientWidth
		height = self.clientHeight
		ctx = self.getContext("2d")
		ctx.fillStyle = 'transparent'
		ctx.fillRect(0, 0, width, height)
	
	def scaleY y
		return (y - maxY) / (minY - maxY) * height
	
	def scaleX x
		return (x - minX) / (maxX - minX) * width

	def add point
		return if !mounted
		if !Object.hasOwn(point,'x') or !Object.hasOwn(point,'y')
			console.log "Chart error. Wrong x,y coordinates: {point}"
			return
		minX = point.x if minX is undefined or point.x < minX
		maxX = point.x if maxX is undefined or point.x > maxX
		minY = point.y if minY is undefined or point.y < minY
		maxY = point.y if maxY is undefined or point.y > maxY
		
		points.push point
		draw!

	def draw
		return if !mounted
		if !points.length
			console.log 'There is no data to draw!'
			return

		ctx.clearRect(0, 0, width, height)
		ctx.fillStyle = 'transparent'
		ctx.fillRect(0, 0, width, height)
		ctx.strokeStyle = line
		ctx.lineWidth = 2
		ctx.beginPath!
		ctx.moveTo(scaleX(points[0].x),scaleY(points[0].y))
		ctx.lineTo(scaleX(point.x), scaleY(point.y)) for point in points
		ctx.stroke!
		ctx.closePath!

	def render
		<self>