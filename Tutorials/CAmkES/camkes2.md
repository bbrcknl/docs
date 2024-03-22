---
toc: true
layout: tutorial
SPDX-License-Identifier: CC-BY-SA-4.0
SPDX-FileCopyrightText: 2024 seL4 Project a Series of LF Projects, LLC.
---

# CAmkES Tutorial 2: Events
This tutorial shows how to build events in CAmkES.

Learn how to:
- Represent and implement events in CAmkES.
- Use Dataports.


## Initialising

```sh
# For instructions about obtaining the tutorial sources see https://docs.sel4.systems/Tutorials/#get-the-code
#
# Follow these instructions to initialise the tutorial
# initialising the build directory with a tutorial exercise
./init --tut hello-camkes-2
# building the tutorial exercise
cd hello-camkes-2_build
ninja
```
<details markdown='1'>
<summary style="display:list-item"><em>Hint:</em> tutorial solutions</summary>
<br>
All tutorials come with complete solutions. To get solutions run:
```
./init --solution --tut hello-camkes-2
```
</details>


### TASK 1
 Here you're declaring the events that will be bounced
back and forth in this tutorial. An event is a signal is sent over a
Notification connection.

You are strongly advised to read the manual section on Events here:
<https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-events>.

  ''Ensure that when declaring the consumes and emits keywords between
  the Client.camkes and Echo.camkes files, you match them up so that
  you're not emitting on both sides of a single interface, or consuming
  on both sides of an interface.''

#### Specify an events interface
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```
    /* TASK 1: the event interfaces */
    /* hint 1: specify 2 interfaces: one "emits" and one "consumes"
     * hint 2: you can use an arbitrary string as the interface type (it doesn't get used)
     * hint 3: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-events
     */
    emits TheEvent echo;
    consumes TheEvent client;
```
</details>


### TASK 10, 11, 14, 15, 22, 25
 Recall that CAmkES prefixes the name
of the interface instance to the function being called across that
interface? This is the same phenomenon, but for events; in the case of a
connection over which events are sent, there is no API, but rather
CAmkES will generate \_emit() and \_wait() functions to enable the
application to transparently interact with these events.

#### Signal that the data is available
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* TASK 10: emit event to signal that the data is available */
  /* hint 1: use the function <interface_name>_emit
    * hint 2: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-events
    */
  echo_emit();
```
</details>

#### Wait for data to become available
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
    /* TASK 11: wait to get an event back signalling that the reply data is available */
    /* hint 1: use the function <interface_name>_wait
     * hint 2: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-events
     */
    client_wait();
```
</details>

#### Signal that data is available
</details>
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* TASK 14: emit event to signal that the data is available */
    /* hint 1: we've already done this before */
    echo_emit();
```
</details>

#### Wait for data to be read
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* TASK 15: wait to get an event back signalling that data has been read */
  /* hint 1: we've already done this before */
  client_wait();
```
</details>

#### Signal that data is available
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* TASK 22: notify the client that there is new data available for it */
  /* hint 1: use the function <interface_name>_emit
    * hint 2: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-events
    */
  client_emit();
```
</details>

#### Signal that data has been read
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* TASK 25: notify the client that we are done reading the data */
  /* hint 1: use the function <interface_name>_emit
    * hint 2: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-events
    */
  client_emit();
```
</details>


### TASK 18, 21, 24
 One way to handle notifications in CAmkES is to
use callbacks when they are raised. CAmkES generates functions that
handle the registration of callbacks for each notification interface
instance. These steps help you to become familiar with this approach.

#### Register a callback handler
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* this function is invoked to initialise the echo event interface before it
  * becomes active. */
  /* TASK 17: replace "echo" with the actual name of the "consumes" event interface */
  /* hint 1: use the interface name as defined in Echo.camkes.
  * For example if you defined it as "consumes TheEvent c_event" then you would use "c_event".
  */
  void echo__init(void) {
    /* TASK 18: register the first callback handler for this interface */
    /* hint 1: use the function <interface name>_reg_callback()
     * hint 2: register the function "callback_handler_1"
     * hint 3: pass NULL as the extra argument to the callback
     * hint 4: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-events
     */
    int error = echo_reg_callback(callback_handler_1, NULL);
    ZF_LOGF_IF(error != 0, "Failed to register callback");
  }
```
</details>

#### Register another callback handler
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* TASK 21: register the second callback for this event. */
  /* hint 1: use the function <interface name>_reg_callback()
    * hint 2: register the function "callback_handler_2"
    * hint 3: pass NULL as the extra argument to the callback
    * hint 4: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-events
    */
  int error = echo_reg_callback(callback_handler_2, NULL);
  ZF_LOGF_IF(error != 0, "Failed to register callback");
```
</details>

#### Register a callback handler
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* TASK 24: register the original callback handler for this event */
    /* hint 1: use the function <interface name>_reg_callback()
     * hint 2: register the function "callback_handler_1"
     * hint 3: pass NULL as the extra argument to the callback
     * hint 4: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-events
     */
    int error = echo_reg_callback(callback_handler_1, NULL);
    ZF_LOGF_IF(error != 0, "Failed to register callback");
```
</details>

------------------------------------------------------------------------

### TASK 2, 4
 Dataports are typed shared memory mappings. In your
CAmkES ADL specification, you state what C data type you'll be using to
access the data in the shared memory -- so you can specify a C struct
type, etc.

The really neat part is more that CAmkES provides access control for
accessing these shared memory mappings: if a shared mem mapping is such
that one party writes and the other reads and never writes, we can tell
CAmkES about this access constraint in ADL.

So in TASKs 2 and 4, you're first being led to create the "Dataport"
interface instances on each of the components that will be participating
in the shared mem communication. We will then link them together using a
"seL4SharedData" connector later on.

#### Specify dataport interfaces
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```
  /* TASK 2: the dataport interfaces */
    /* hint 1: specify 3 interfaces: one of type "Buf", one of type "str_buf_t" and one of type "ptr_buf_t"
     * hint 2: for the definition of these types see "str_buf.h".
     * hint 3: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-dataports
     */
    dataport Buf d;
    dataport str_buf_t d_typed;
    dataport ptr_buf_t d_ptrs;
```
</details>

#### Specify dataport interfaces
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```
  /* TASK 4: the dataport interfaces */
    /* hint 1: specify 3 interfaces: one of type "Buf", one of type "str_buf_t" and one of type "ptr_buf_t"
     * hint 3: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-dataports
     */
    dataport Buf d;
    dataport str_buf_t d_typed;
    dataport ptr_buf_t d_ptrs;
```
</details>

### TASK 6
 And here we are: we're about to specify connections
between the shared memory pages in each client, and tell CAmkES to link
these using shared underlying Frame objects. Fill out this step, and
proceed.

#### Specify dataport connections
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```
  /* TASK 6: Dataport connections */
  /* hint 1: connect the corresponding dataport interfaces of the components to each other
    * hint 2: use seL4SharedData as the connector
    * hint 3: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-dataports
    */
  connection seL4SharedData data_conn(from client.d, to echo.d);
  connection seL4SharedData typed_data_conn(from client.d_typed, to echo.d_typed);
  connection seL4SharedData ptr_data_conn(from client.d_ptrs, to echo.d_ptrs);
```
</details>

### TASK 9, 12, 13
 These steps are asking you to write some C code
to access and manipulate the data in the shared memory mapping
(Dataport) of the client. Follow through to the next step.

#### Copy strings to an untyped dataport
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
    /* TASK 9: copy strings to an untyped dataport */
    /* hint 1: use the "Buf" dataport as defined in the Client.camkes file
     * hint 2: to access the dataport use the interface name as defined in Client.camkes.
     * For example if you defined it as "dataport Buf d" then you would use "d" to refer to the dataport in C.
     * hint 3: first write the number of strings (NUM_STRINGS) to the dataport
     * hint 4: then copy all the strings from "s_arr" to the dataport.
     * hint 5: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-dataports
     */
    int *n = (int*)d;
    *n = NUM_STRINGS;
    char *str = (char*)(n + 1);
    for (int i = 0; i < NUM_STRINGS; i++) {
        strcpy(str, s_arr[i]);
        str += strlen(str) + 1;
    }
```
</details>

#### Read the reply data from a typed dataport
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```
  /* TASK 12: read the reply data from a typed dataport */
    /* hint 1: use the "str_buf_t" dataport as defined in the Client.camkes file
     * hint 2: to access the dataport use the interface name as defined in Client.camkes.
     * For example if you defined it as "dataport str_buf_t d_typed" then you would use "d_typed" to refer to the dataport in C.
     * hint 3: for the definition of "str_buf_t" see "str_buf.h".
     * hint 4: use the "n" field to determine the number of strings in the dataport
     * hint 5: print out the specified number of strings from the "str" field
     * hint 6: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-dataports
     */
    for (int i = 0; i < d_typed->n; i++) {
        printf("%s: string %d (%p): \"%s\"\n", get_instance_name(), i, d_typed->str[i], d_typed->str[i]);
    }
```
</details>

# Send data using dataports
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```
  /* TASK 13: send the data over again, this time using two dataports, one
     * untyped dataport containing the data, and one typed dataport containing
     * dataport pointers pointing to data in the untyped, dataport.
     */
    /* hint 1: for the untyped dataport use the "Buf" dataport as defined in the Client.camkes file
     * hint 2: for the typed dataport use the "ptr_buf_t" dataport as defined in the Client.camkes file
     * hint 3: for the definition of "ptr_buf_t" see "str_buf.h".
     * hint 4: copy all the strings from "s_arr" into the untyped dataport
     * hint 5: use the "n" field of the typed dataport to specify the number of dataport pointers (NUM_STRINGS)
     * hint 6: use the "ptr" field of the typed dataport to store the dataport pointers
     * hint 7: use the function "dataport_wrap_ptr()" to create a dataport pointer from a regular pointer
     * hint 8: the dataport pointers should point into the untyped dataport
     * hint 9: for more information about dataport pointers see: https://github.com/seL4/camkes-tool/blob/master/docs/index.md
     */
    d_ptrs->n = NUM_STRINGS;
    str = (char*)d;
    for (int i = 0; i < NUM_STRINGS; i++) {
        strcpy(str, s_arr[i]);
        d_ptrs->ptr[i] = dataport_wrap_ptr(str);
        str += strlen(str) + 1;
    }
```
</details>

### TASK 19, 20, 23
 And these steps are asking you to write some C
code to access and manipulate the data in the shared memory mapping
(Dataport) of the server.

#### Read data from an untyped dataport
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* TASK 19: read some data from the untyped dataport */
  /* hint 1: use the "Buf" dataport as defined in the Echo.camkes file
    * hint 2: to access the dataport use the interface name as defined in Echo.camkes.
    * For example if you defined it as "dataport Buf d" then you would use "d" to refer to the dataport in C.
    * hint 3: first read the number of strings from the dataport
    * hint 4: then print each string from the dataport
    * hint 5: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-dataports
    */
  int *n = (int*)d;
  char *str = (char*)(n + 1);
  for (int i = 0; i < *n; i++) {
      printf("%s: saying (%p): \"%s\"\n", get_instance_name(), str, str);
      str += strlen(str) + 1;
  }
```
</details>

#### Put data into a typed dataport
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* TASK 20: put a modified copy of the data from the untyped dataport into the typed dataport */
    /* hint 1: modify each string by making it upper case, use the function "uppercase"
     * hint 2: read from the "Buf" dataport as above
     * hint 3: write to the "str_buf_t" dataport as defined in the Echo.camkes file
     * hint 4: to access the dataport use the interface name as defined in Echo.camkes.
     * For example if you defined it as "dataport str_buf_t d_typed" then you would use "d_typed" to refer to the dataport in C.
     * hint 5: for the definition of "str_buf_t" see "str_buf.h"
     * hint 6: use the "n" field to specify the number of strings in the dataport
     * hint 7: copy the specified number of strings from the "Buf" dataport to the "str" field
     * hint 8: look at https://github.com/seL4/camkes-tool/blob/master/docs/index.md#an-example-of-dataports
     * hint 9: you could combine this TASK with the previous one in a single loop if you want
     */
    n = (int*)d;
    str = (char*)(n + 1);
    for (int i = 0, j = *n - 1; i < *n; i++, j--) {
        strncpy(d_typed->str[j], str, STR_LEN);
        uppercase(d_typed->str[j]);
        str += strlen(str) + 1;
    }
    d_typed->n = *n;
```
</details>

#### Read data from a typed dataport
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```c
  /* TASK 23: read some data from the dataports. specifically:
    * read a dataport pointer from one of the typed dataports, then use
    * that pointer to access data in the untyped dataport.
    */
  /* hint 1: for the untyped dataport use the "Buf" dataport as defined in the Echo.camkes file
    * hint 2: for the typed dataport use the "ptr_buf_t" dataport as defined in the Echo.camkes file
    * hint 3: for the definition of "ptr_buf_t" see "str_buf.h".
    * hint 4: the "n" field of the typed dataport specifies the number of dataport pointers
    * hint 5: the "ptr" field of the typed dataport contains the dataport pointers
    * hint 6: use the function "dataport_unwrap_ptr()" to create a regular pointer from a dataport pointer
    * hint 7: for more information about dataport pointers see: https://github.com/seL4/camkes-tool/blob/master/docs/index.md
    * hint 8: print out the string pointed to by each dataport pointer
    */
  char *str;
  for (int i = 0; i < d_ptrs->n; i++) {
      str = dataport_unwrap_ptr(d_ptrs->ptr[i]);
      printf("%s: dptr saying (%p): \"%s\"\n", get_instance_name(), str, str);
  }
```
</details>

### TASK 7
 This is an introduction to CAmkES attributes: you're
being asked to set the priority of the components.

#### Set component priorities
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```
  /* TASK 7: set component priorities */
  /* hint 1: component priority is specified as an attribute with the name <component name>.priority
   * hint 2: the highest priority is represented by 255, the lowest by 0
  */
  client.priority = 255;
  echo.priority = 254;
```
</details>

### TASK 8, 16
 This is where we specify the data access constraints
for the Dataports in a shared memory connection. We then go about
attempting to violate those constraints to see how CAmkES has truly met
our constraints when mapping those Dataports.

#### Restrict access to dataports
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```
  /* TASK 8: restrict access to dataports */
  /* hint 1: use attribute <component>.<interface_name>_access for each component and interface
    * hint 2: appropriate values for the to_access and from_access attributes are: "R" or "W"
    * hint 4: make the "Buf" dataport read only for the Echo component
    * hint 3: make the "str_buf_t" dataport read only for the Client component
    */
  echo.d_access = "R";
  client.d_access = "W";
  echo.d_typed_access = "W";
  client.d_typed_access = "R";
```
</details>

#### Test the read and write permissions on the dataport
<details markdown='1'>
<summary style="display:list-item"><em>Quick solution</em></summary>
```
  /* TASK 16: test the read and write permissions on the dataport.
    * When we try to write to a read-only dataport, we will get a VM fault.
    */
  /* hint 1: try to assign a value to a field of the "str_buf_t" dataport */

  d_typed->n = 0;
```
</details>

## Done!
 Congratulations: be sure to read up on the keywords and
structure of ADL: it's key to understanding CAmkES. And well done on
writing your first CAmkES application.



Next tutorial: <a href="camkes3">CAmkES 3: Timer</a>
