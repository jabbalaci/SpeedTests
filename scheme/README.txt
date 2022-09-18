Under Manjaro, I had to install these packages (command -> package):

chez    -> chez-scheme
gambitc -> gambit-c

I couldn't compile stalin but at https://packages.debian.org/bullseye/stalin
you can find a Debian prebuilt library (thanks @uninhm).

stalin didn't recognize my architecture, thus I had to specify
it manually in the Makefile.
