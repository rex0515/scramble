# Scramble
Have you ever wanted to just take a file and change the order of individual bytes? Then you are in the correct place!
Scramble aims to do just that! Either randomly or in an orderly fashion (quite literally!)!

## Getting started

Scramble is really easy to setup and use. You can either download a release or compile it yourself!

### How do I install Scramble?

#### Option 1: Install a precompiled version
Just go to the [releases](https://github.com/rex0515/scramble/releases/latest) page and download the latest file suitable for you system

#### Option 2: Compile the source code
This is a bit longer than the first option but still quite easy!

##### Requirements
- [Opam](https://opam.ocaml.org/doc/Install.html)
- [Dune](https://dune.build/install)

Once you have all of these you can clone the repository:
    
    git clone https://github.com/rex0515/scramble.git
    cd scramble
    
And then you can build it using:

    dune build

Which should produce a `main.exe` in `_build/default/bin`

> [!IMPORTANT]
> `dune` uses `.exe` extention no matter what you are compiling on. So if you are on macOS or Hannah Montana Linux you will see a `main.exe`. Don't be scared, just rename it to `scramble` and you are golden.

### How do I use Scramble?

Once you have the built version installed you can rename it to scramble and open the terminal equivalent in your OS.
After you have done that you can run `scramble`, which will output the help message:

    scramble

<pre>
scramble [-sort] [-s seed] <input> -o <output>  
   -sort Sort bytes instead of shuffling them  
   -o Set output file name  
   -s Set a custom seed  
   -help  Display this list of options  
   --help  Display this list of options 
</pre>

 Using this we can scramble `foo.txt` and write the results to `bar.txt` using:

     scramble foo.txt -o bar.txt

if you are scared of randomness you can set your own seed using `-s` option:

    scramble -s 2 foo.txt -o bar.txt

or if you are really scared of randomness you can sort the bytes of `foo.txt`:

    scramble -sort foo.txt -o bar.txt

> [!Note]
> Due to the way it is optiomised it can handle pretty large files. But this optimisation comes at the cost of not being able to sort large files perfectly.
> This happens because both sorting and scrambling happens for 4096 byte chunks. So if a file is larger than that Scramble divides files into smaller chunks and does operations on those chunks.
> For scrambling this is fine (unless you are really paranoid about cyber-securty in which case you are in the wrong repo). For sorting however this means it sorts chunk by chunk :(
> This is has many fixes but since this is not sort.exe I'm just gonna call it a feature.



  
