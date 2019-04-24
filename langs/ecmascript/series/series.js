
function series(tasks, callback) {
    const results = []
    function iterate(index) {
        if (index === tasks.length) {
            return finish()
        }
        const task = tasks[index]
        task(function(err, res) {
            results.push(res)
            iterate(index + 1)
        })
    }

    function finish() {
        callback(null, results)
    }

    iterate(0)
}
