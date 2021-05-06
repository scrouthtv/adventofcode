class XMAS {

	constructor (blockSize) {
		this.numbers = []
		this.blockSize = blockSize
	}

	canConsume (x) {
		if (this.numbers.length < this.blockSize) {
			this.numbers.push(x)
			return true
		}

		// move downwards from the last number that was added:
		let n1 = this.numbers.length - 1
		for (; n1 > this.numbers.length - this.blockSize; n1--) {
			if (this.canSum(n1, x)) {
				this.numbers.push(x)
				return true
			}
		}

		return false
	}

	canSum (n1, x) {
		let n2 = this.numbers.length - this.blockSize
		for (; n2 < n1; n2++) {
			if (this.numbers[n1] + this.numbers[n2] === x) return true
		}

		return false
	}

	findSummingRange (x) {
		let n2

		for (let n1 = 0; n1 < this.numbers.length - 1; n1++) {
			n2 = this.canRangeSum(n1, x)
			if (n2 !== -1) {
				console.log(`Found a range from ${n1} through ${n2}.`)
				console.log(`Weakness: ${this.calcWeakness(n1, n2)}`)
				return true
			}
		}

		return false
	}

	calcWeakness (n1, n2) {
		let min = this.numbers[n1]
		let max = this.numbers[n1]

		for (let i = n1 + 1; i <= n2; i++) {
			if (this.numbers[i] < min) min = this.numbers[i]
			else if (this.numbers[i] > max) max = this.numbers[i]
		}

		return min + max
	}

	canRangeSum (n1, x) {
		let n2 = n1
		let sum = this.numbers[n1]
		while (sum < x) {
			n2++
			sum += this.numbers[n2]

			if (n2 >= this.numbers.length) return -1
		}

		if (sum === x) return n2
		else return -1
	}

}

module.exports = XMAS
