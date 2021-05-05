const blockSize = 25

class XMAS {

	constructor () {
		this.numbers = []
	}

	canConsume (x) {
		if (this.numbers.length < blockSize) {
			this.numbers.push(x)
			return true
		}

		// move downwards from the last number that was added:
		let n1 = this.numbers.length - 1
		for (; n1 > this.numbers.length - blockSize; n1--) {
			if (this.canSum(n1, x)) {
				this.numbers.push(x)
				return true
			}
		}

		return false
	}

	canSum (n1, x) {
		let n2 = this.numbers.length - blockSize
		for (; n2 < n1; n2++) {
			if (this.numbers[n1] + this.numbers[n2] === x) return true
		}

		return false
	}

}

module.exports = XMAS
