export tag ChartSVG
	css 
		.relative width:100% h:100%
		svg, polyline pos:absolute t:0 r:0 l:0 b:0
		$pip o:0
		$svgContainer@hover $pip o:1

	prop interval
	prop highlightedPoint
	prop points = ""

	@observable width = 0
	@observable height = 0
	@observable pointsArray\array = []

	@autorun def formatPoints
		return if pointsArray.length < 1
		const firstPlot = (pointsArray[0].split(","))[1]
		const lastPlot = (pointsArray[pointsArray.length - 1].split(","))[1]

		points = "-2,160 0,{firstPlot} {pointsArray.join " "} {width+2},{lastPlot} {width+2},180"

	@autorun def makePoints
		return [] unless width

		interval = width / (data.length - 1)

		const min = Math.min(...data)
		const max = Math.max(...data)
		const scale = min - max

		let intervalCount = 0
		const _pointsArray = []

		data.forEach do(n)
			const plot = (n - max) / scale * height
			_pointsArray.push "{intervalCount.toFixed 0},{plot.toFixed 0}"
			intervalCount = intervalCount + interval

		pointsArray = _pointsArray
    
	def track e do
		$pip.style.left = "{e.pageX + 32}px"
		$pip.style.top = "{e.pageY + 16}px"
    
	def mount
		width = $svgContainer.offsetWidth
		height = $svgContainer.offsetHeight
		highlightedPoint = data.length - 1

	<self>
		<div[pos:absolute t:6 r:0 b:2 l:0]>
			<div$svgContainer[pos:relative w:100% h:100% d:flex j:center]>
				<svg width="100%" height="100%" viewbox="0 0 500 160" preserveAspectRatio="none">
					<defs>            
						<linearGradient#linear x1="0%" y1="0%" x2="0%" y2="100%">
							<stop offset="0%" stop-color="#8959f7" stop-opacity="10%">
							<stop offset="80%" stop-color="#6467f2" stop-opacity="0%">
				<polyline stroke-linejoin="round" fill="transparent" stroke="#7c3bed" stroke-width="2" points=points>

				<div[d:flex pos:absolute w:{width + interval}px h:100%] @mousemove=track @mouseleave=(highlightedPoint = data.length - 1)>
					for point,index in data
						<div[pos:relative flg:1 h:100% o:0 o@hover:1 d:flex fld:column j:end a:center] @mouseenter=(highlightedPoint = index)>
							<div[bd:solid 1px border-image:linear-gradient(to top, violet6/0, violet6, violet6/0) 1 / 5px w:0 h:100%]>

				<p$pip[pos:fixed z:10 ta:center d:inline px:2 fs:xs bg:violet5 c:white rd:100px fw:700 ls:110% ws:nowrap y:12]> data[highlightedPoint]