const http = require("http")
const casual = require("casual")


const server = http.createServer((req, res)=>{
    res.end(casual.sentence)
});

server.listen(4000, ()=>{
    console.log('Server start at port 4000')
});
