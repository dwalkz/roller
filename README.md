# Roller

This was just a very simple one-day bash together to get some familiarity with Ruby. I'm a big D&D player and DM so my first thought was "let's make a dice roller". 

The program uses the ruby CLI with the following options:
```
-v, --verbose       If supplied, will output all the steps used in calculation
-d, --dice STRING   The dice to roll in standard D&D format
```

If you've got all of this on your machine, all you need to do is make the `cli.rb` executable OR call `ruby <path>/<to>/cli.rb` and it will calculate the outcome!

# Example usage
```
$: ruby cli.rb -v -d 1d12+2d8+(1d4*3)+5
1d12+2d8+(1d4*3)+5
  d12 rolled 4
  d8 rolled 3
  d8 rolled 5
  d4 rolled 2
4+8+(2*3)+5
23
```

Without the `-v` option supplied, the same call would be
```
$: ruby cli.rb -v -d 1d12+2d8+(1d4*3)+5
23
```

The program is not limited in dice size so you can technically throw in any size you want like `d300` or `d10000`. Although for standard use, I would recommend sticking to the normal D&D dice sizes.

This was just a simple project for me to get my feet wet so there's no major input validations, it assumes positive numbers only, and I'm sure it's riddled with bugs. Please don't @ me, just submit a PR or fork it if you'd like!
