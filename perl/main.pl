#!/usr/bin/env perl
use strict;

my $MAX = 440_000_000;
my @cache = map { $_ ** $_ } (0..9);
$cache[0] = 0;

sub is_munchausen
{
	my $n = $_[0];
	my $total = 0;

	while ($n > 0)
	{
		my $digit = $n % 10;
		$total += $cache[$digit];
		if ($total > $_[0])
		{
			return 0;
		}
		$n = int($n / 10);
	}
	return $total == $_[0];
}

for (my $i = 0; $i < $MAX; $i++)
{
  if (is_munchausen($i))
  {
    print "$i\n";
  }
}
