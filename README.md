# AyranOS
A simple operating system kernel for learning purpose
The name could be iOS (Inefficient Operating System).

## V1
In this version, the OS doesn't have either kernel
interruptions, virtual memory or file system.

## QEMU

```qemu-system-x86_64 -kernel -nographic```

In **nographic** mode, QEMU has a special key combination to access the QEMU monitor, where you can issue commands directly. To exit:

Press **Ctrl+A** (hold **Ctrl** and press **A**).  
Then, release **Ctrl** and press **X**.