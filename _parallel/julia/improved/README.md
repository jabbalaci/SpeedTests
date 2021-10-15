See https://github.com/jabbalaci/SpeedTests/pull/27 for more info.

As our contributor, MasonProtter explained:

"...I used this instead of `Threads.@threads` because it's little bit faster (it can do work stealing which is relevant here because the bigger the number, the longer it takes to compute, so some threads might finish before other threads, leaving them idle). But it's not a huge difference, so feel free to just use `Threads.@threads`."

Since the difference is very small, I kept `Threads.@threads` for its simplicity.
