const XMAS = require('./xmas.js')
const fs = require('fs')
const readline = require('readline')

const f = readline.createInterface({
	input: fs.createReadStream('./input'),
	crlfDelay: Infinity,
	terminal: false
})

const proto = new XMAS()

f.on('line', function (line) {
	const i = parseInt(line)
	if (!proto.canConsume(i)) {
		console.log('Can\'t consume ' + i)
		f.close()
		f.removeAllListeners()
	}
	console.log('Succesfully consumed ' + proto.numbers.length + ' numbers');
})
