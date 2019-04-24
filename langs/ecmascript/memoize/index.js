
function memoize(fn) {
  const cache = {}
  return function(...args) {
    // const callback = args.pop()
    return fn(...args)
  }
}

function sum(a, b) {
  return a + b
}

const fastSum = memoize(sum)

const result = fastSum(1, 2)

console.log(result)
