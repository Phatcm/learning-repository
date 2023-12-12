const express = require('express');
const app = new express();

app.get('/', (req, res)=>{
    res.send('<a href="/contact">Contact</a> <br> <a href="/about">About Us</a>');
});

app.get('/contact', (req, res)=>{
    res.send('<h1>This is the contact page</h1>');
});

app.get('/about', (req, res)=>{
    res.send('<h1>This is the about page</h1>');
});

app.get('*', (req, res)=>{
    res.send('Page does not exist. <a href="/">Return home</a>')
})

app.listen(3000, ()=>{
    console.log('Running on port 3000')
})