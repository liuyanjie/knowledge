
const fs = require('fs')
const async_hooks = require('async_hooks')

const asyncHooks = async_hooks.createHook({
  init(asyncId, type, triggerAsyncId, resource) {
    fs.writeSync(1, `init: asyncId-${asyncId}, type-${type}, triggerAsyncId-${triggerAsyncId}\n`);
  },
  before(asyncId) {
    fs.writeSync(1, `before: asyncId-${asyncId}\n`);
  },
  after(asyncId) {
      fs.writeSync(1, `after: asyncId-${asyncId}\n`);
  },
  destroy(asyncId) {
    fs.writeSync(1, `destroy: asyncId-${asyncId}\n`);
  }
})

asyncHooks.enable()

console.log('...')

