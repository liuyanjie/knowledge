
/* eslint-disable */

function co(gen) {
  // TODO: check generator
  const iterator = gen()

  return new Promise((resolve, reject) => {
    function next(result) {
      // TODO: check Promise
      if (result.done) {
        return resolve(result.value)
      }
      return result.value.then((value) => {
        next(iterator.next(value))
      })
    }
    return next(iterator.next())
  })
}

co(function *g() {
  const x = yield Promise.resolve(6)
  const y = yield Promise.resolve(7)
  const z = yield Promise.resolve(8)
  // console.log(x, y, z)
  return x + y + z
}).then((r) => {
  console.log('rrrr', r)
})

// `n` 个 `yield` 将 `generator` 切分成 `n+1` 块
// 每次调用 `next` 将执行其中一个块，并将 执行结果在 `next` 放在了返回值中
// 而 `yield` 的返回值将在下一次 `next` 调用时通过 `next` 的参数传入
// 在两次 next 调用之间，给了我们处理 `yield` 返回值的时间窗口
