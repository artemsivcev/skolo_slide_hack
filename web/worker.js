onmessage = a => {
// a is a message from flutter
console.log(a.data)

//send an another message back
postMessage({customKey: 'Hello from the JavaScript',})

};