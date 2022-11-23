let seed = Date.now! % 1000

export def entropy
	seed += Date.now! % 10 + 1

export def random(max = 9, min = 0)
	entropy!
	let x = Math.abs(Math.sin(seed)) * 10000000
	x -= Math.floor(x)
	return Math.floor(x * (max + 1 - min) + min)
