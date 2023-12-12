let events = require('events')

//create a event emitter
let eventEmitters = new events.EventEmitter();

//Event listener and callback function
eventEmitters.on('connection', (error)=>{
    if (error) return console.log(error);
    console.log('Connection sucessfully')
});
//Event listener and callback function
eventEmitters.on('print', (error)=>{
    if (error) return console.log(error);
    console.log('This is the test text')
});

//Event emitter call
eventEmitters.emit('connection')
eventEmitters.emit('print')