let fs = require('fs')

fs.readFile('example.txt', (error, data) =>{
    if(error) return console.log(error);
    console.log(data.toString())
})

console.log('Process ended')