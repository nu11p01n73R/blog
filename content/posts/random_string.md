+++ 
draft = false 
comments = false 
slug = "" 
tags = []
categories = []
title = "Generating Random String"
date = 2017-11-12T21:00:24+05:30

showpagemeta = true
showcomments = false
+++

Generating random string is a very common problem that we encounter
at often. How easy is it to generate a random string of `n` characters?
How efficiently can we generate the random string.

# Easy Way

Lets say we need to generate a string from alphabets,

```
const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
```

The easiest way is to get a random integer less than 52, and then use 
it as an index into `letters` to add them up.

We could write it as,

```
func getRandomString(n int) string {
        const letter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

        random := ""
        for i := 0; i < n; i++ {
                index := rand.Intn(52)
                random += string(letter[index])
        }

        return random
}
```

This is a good way, but how good it if we want to generate 1 million strings?

```
Byte array:     1.395217759s
```

Can we do better?

-----

# Using Bit Manipulation

The `Intn` solution is in-efficient because it calls `Int32n` which 
inturn calls `Int32`.

Another way to generate the bits using `Int32` or `Int63` directly.
To be more efficient, lets take `Int63`. This returns an int with
63 bits. 

Now, our `letters` has 52 elements in it. So we require min `6` bits to
represent all of them.

So if we generate one `63 bit` random number we can get `10` `6bits` out
of it. 

We check if that number generated is less than 52, if so we get an index
for `letters`, add it to the `random` array and so on.

We could write it as,

```
func getRandomString(n int) string {
        const letter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

        random := make([]byte, n)
        mask := 1<<6 - 1
        num := rand.Int63()

        for i := 0; i < n; {
                index := int(num) & mask
                if index < len(letter) {
                        random[i] = letter[index]
                        i++
                        num = num >> 6
                } else {
                        num = num >> 1
                }

                if num == 0 {
                        num = rand.Int63()
                }
        }

        return string(random)
}
```

-------

# Reference
- Ideas from [this Stack Overflow answer](https://stackoverflow.com/a/31832326/3150943)
