// YOUR CODE HERE
var secretNumber = Math.floor(Math.random() * 100 + 1);

var guess ;

while (secretNumber !== parseInt(guess)) {
  guess = prompt("Guess a number between 1 and 100");
  if (parseInt(guess) > secretNumber) {alert("Too high!");
} else if (parseInt(guess) < secretNumber) {
  alert("Too low!");
};
}
alert("You Win!");
