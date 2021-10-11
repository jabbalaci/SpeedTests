Here is my original attempt.
It was quite slow, the runtime was 45 seconds.

And why? Because the global variable `N` was not a constant
(and it was accessed a lot of times). Once it was made
a `const`, the runtime dropped from 45 sec to 7 sec!

More info here: https://docs.julialang.org/en/v1/manual/performance-tips/

I got lots of tips on Reddit ( https://old.reddit.com/r/Julia/comments/q5ax1d/compile_for_faster_execution/ ). Thanks for that!
