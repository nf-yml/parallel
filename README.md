# Parallel execution of processes
Nextflow will act as a head process and will oversee parallel execution of the child commands.
The execution is compatible with all standard Nextflow features (e.g., resource definitions, remote execution, automatic process restarting, etc.).
The Nextflow process will block the shell, acting effectively as a `join` operator for integrating parallel processes back into a common execution flow.

**Step 1:** Define a YAML file with the desired commands

``` yaml
greet:
  command: echo Hello World
sleepy time:
  command: sleep 5
```

**Step 2:** Provide the YAML file as input

``` bash
nextflow run nf-yml/parallel --in test.yml
```

The output of individual processes can be found in the `work/` directory created by the Nextflow process.
