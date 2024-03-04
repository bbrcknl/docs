---
toc: true
layout: project
SPDX-License-Identifier: CC-BY-SA-4.0
SPDX-FileCopyrightText: 2024 seL4 Project a Series of LF Projects, LLC.
---


# Hello, world!
In this tutorial you will
- Run Hello, World! to ensure your setup is working correctly
- Become familiar with the jargon *root task*
- Build and simulate a seL4 project
- Have a basic understanding of the role of the `CMakeLists.txt` file in applications

## Building your first program

seL4 is a microkernel, not an operating system, and as a result only provides very minimal services.
After the kernel boots, an initial thread called the *root task* is started, which is then responsible for
 setting up the user-level system.
When the root task starts there are no available drivers, however a minimal C library is provided.

The tutorial is already set up to print "Hello, world!", so at this point
all you need to do is build and run the tutorial.

### Initialise the build directory

```
cd sel4-tutorials-manifest
./init --tut hello-world
```
This step creates two new directories in `sel4-tutorials-manifest`, namely `hello-world` and `hello-world_build`

<details markdown='1'>
<summary style="display:list-item"><em>Hint:</em> tutorial solutions</summary>
<br>
All tutorials come with complete solutions. To get solutions run:
```
./init --solution --tut hello-world
```
This will generate another `hello-world` directory and `hello-world_build` directory, with unique names, e.g. `hello-world44h1po5q` and `hello-world44h1po5q_build`.
</details>

We will now use two terminals, as described in [Setting up your machine](setting-up#mapping-a-container).

 - Terminal A is just a normal terminal, and is used for git operations, editing (e.g., vim, emacs), and other normal operations.
 - Terminal B is running in a container, and is only used for compilation.

This gives you the flexibility to use all the normal tools you are used to, while having the seL4 dependencies separated from your machine.

### Create a container
Open a new terminal, Terminal B, to run a container.

Create a container:
```
container
```

### Build the program

```
cd sel4-tutorials-manifest/hello-world_build
```

Next, build the program in Terminal B using ninja

```
ninja
```


If successful, you should see the final ninja rule passing, e.g.:
```
[150/150] objcopy kernel into bootable elf
```



### Run Hello, World using QEMU
The final image can be run *inside* the container using the command:

```
./simulate
```

This will run the result on an instance of the [QEMU](https://www.qemu.org) simulator.
If everything has worked, you should see:

```
Booting all finished, dropped to user space
Hello, World!
```

After that output, there should be a capability violation and a stack dump,
because the program hasn't properly cleaned up after itself yet. (This will come in later examples.)

`Ctrl-A, X` will terminate QEMU.

## Looking at the sources
To look at the sources, open a new terminal, Terminal A:

```
cd sel4-tutorials-manifest/hello-world
ls
```

In your tutorial directory, you will find the following files:
 * `CMakeLists.txt` - the file that incorporates the root task into the wider seL4 build system.
 * `src/main.c` - the single source file for the initial task.
 * `hello-world.md` - A generated README for the tutorial.

### `CMakeLists.txt`

Every application and library in an seL4 project requires a `CMakeLists.txt` file in order to be
 incorporated into the project build system.

```cmake
/*-- set build_file --*/
include(${SEL4_TUTORIALS_DIR}/settings.cmake)
sel4_tutorials_regenerate_tutorial(${CMAKE_CURRENT_SOURCE_DIR})

cmake_minimum_required(VERSION 3.7.2)
# declare the hello-world CMake project and the languages it is written in (just C)
project(hello-world C ASM)

# In future tutorials, these setup steps will be replaced with
# sel4_tutorials_setup_roottask_tutorial_environment()
find_package(seL4 REQUIRED)
find_package(elfloader-tool REQUIRED)
find_package(musllibc REQUIRED)
find_package(util_libs REQUIRED)
find_package(seL4_libs REQUIRED)

sel4_import_kernel()
elfloader_import_project()

# This sets up environment build flags and imports musllibc and runtime libraries.
musllibc_setup_build_environment_with_sel4runtime()
sel4_import_libsel4()
util_libs_import_libraries()
sel4_libs_import_libraries()
sel4_tutorials_import_libsel4tutorials()

# Name the executable and list source files required to build it
add_executable(hello-world src/main.c)

# List of libraries to link with the application.
target_link_libraries(hello-world
    sel4runtime sel4
    muslc utils sel4tutorials
    sel4muslcsys sel4platsupport sel4utils sel4debug)

# Tell the build system that this application is the root task.
include(rootserver)
DeclareRootserver(hello-world)
/*- endset -*/
/*? build_file ?*/
```

### `main.c`
The main C is a very typical C file. For a basic root server application, the only requirement is that
a `main` function is provided.

```c
#include <stdio.h>

/*-- filter TaskContent("hello-world", TaskContentType.ALL) -*/
int main(int argc, char *argv[]) {
    printf("Hello, World!\n");

    return 0;
}
/*- endfilter --*/
```

## Making a change
Test making a change to `main.c` by adding a second printf to output `"Second hello\n"`.

```c
/*-- filter TaskContent("hello-world-mod", TaskContentType.COMPLETED) -*/
int main(int argc, char *argv[]) {
    printf("Hello, World!\n");

    printf("Second hello\n");
    return 0;
}
/*- endfilter --*/
```
Once you have made your change, use Terminal B to rebuild the project:

*Hint:* Remember to exit the QEMU siumator before rerunning the project with `ctrl-A,x`. *And* exit the container using `ctrl-D`

Then rebuild using ninja and run the simulator again:
```
ninja
container
./simulate
```

On success, you should see the following:

```
Hello, World!
Second hello
```

Next tutorial: <a href="capabilities">Capabilities</a>