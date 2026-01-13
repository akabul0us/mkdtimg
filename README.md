# mkdtimg tool from AOSP

Have a look at [this repo](https://android.googlesource.com/platform/system/libufdt) in AOSP. If I want to built this tool, what am I missing?

The Makefile, of course (or an Android.mk file which is essentially the same thing). That's because Google, as a corporate environment where everyone constantly needs to prove their worth, changes how AOSP is built every year or so. You'll notice an Android.bp file. These .bp ("blueprint") files are used by the Soong build system.

"But akabul0us, what the f*** is the Soong build system?" I didn't know, either, but according to [this StackOverflow answer](https://stackoverflow.com/questions/52384832/difference-between-android-bp-and-android-mk), *"Soong is a build system for Android, intended as a replacement for the old make-based build system. Soong reads Android.bp files, which define modules in a Bazel-like syntax. Soong itself is written in Go on top of the Blueprint framework, which in turn uses Ninja as a back-end. Ninja is designed for high efficiency, especially for incremental builds."*

Oh, good, so it's more efficient. How do I install it, then? Plot twist: **you can't**[^1].

When I was trying to compile `mkdtimg` (a tool needed to convert certain kernel build output files to a format Android can use), the only information I could find online suggested I check out the entire AOSP source code. [As you can see in the build requirements](https://source.android.com/docs/setup/start/requirements), that is an INSANE thing to suggest. Ah, yes, I need 400GB of free space... to build a 39Kb util. Because it's *more efficient*.

Luckily, I found [this repo](https://github.com/affggh/mkdtimg) here on github with a functional Makefile. All I've done in my fork is find which .c and .h files present in both the current AOSP repo and this one had differences, and copied the new versions in. (And updating the README.md, I suppose, mostly because I'm annoyed at Google for making this so f***ing difficult).

If you want to build this from source, clone the repo, run `make clean` and then `make -j$(nproc)`. Alternatively, save the compiled binary, either the dynamic version, built with Clang [here](https://github.com/akabul0us/mkdtimg/raw/refs/heads/master/mkdtimg), or a statically-compiled version built with GCC 14 against musl from [here](https://github.com/akabul0us/mkdtimg/raw/refs/heads/static/mkdtimg).

Enjoy.


[^1]: at least not as a standalone bit of software, anyway.
